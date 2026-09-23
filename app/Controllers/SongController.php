<?php
declare(strict_types=1);

namespace AdminApi\Controllers;

use AdminApi\Core\Database;
use AdminApi\Core\Env;
use AdminApi\Helpers\Request;
use AdminApi\Helpers\Response;
use AdminApi\Helpers\Slug;

final class SongController extends BaseController
{
    private \mysqli $db;

    private const INT_FIELDS = ['duration_seconds', 'is_explicit', 'is_active'];
    private const FIELDS = [
        'title', 'slug', 'description', 'lyrics', 'audio_url', 'cover_url',
        'duration_seconds', 'language', 'release_date', 'is_explicit', 'is_active',
    ];

    public function __construct()
    {
        parent::__construct();
        $this->db = Database::get();
    }

    public function index(): void
    {
        $page = max(1, Request::int('page', 1));
        $limit = min(100, max(1, Request::int('limit', 25)));
        $search = Request::string('search');

        $where = 's.deleted_at IS NULL';
        $params = [];
        $types = '';

        if ($search !== '') {
            $where .= ' AND s.title LIKE ?';
            $params[] = '%' . $search . '%';
            $types .= 's';
        }

        $count = $this->db->prepare("SELECT COUNT(*) AS total FROM songs s WHERE {$where}");
        if ($params) {
            $count->bind_param($types, ...$params);
        }
        $count->execute();
        $total = (int) $count->get_result()->fetch_assoc()['total'];

        $params[] = $limit;
        $params[] = ($page - 1) * $limit;
        $types .= 'ii';

        $stmt = $this->db->prepare(
            "SELECT
                s.id,
                s.title,
                s.slug,
                s.audio_url,
                s.cover_url,
                s.duration_seconds,
                s.language,
                s.release_date,
                s.is_explicit,
                s.is_active,
                s.play_count,
                s.like_count,
                s.download_count,
                (SELECT COUNT(*) FROM song_artists sa WHERE sa.song_id=s.id) AS artist_count,
                (SELECT COUNT(*) FROM song_genres sg WHERE sg.song_id=s.id) AS genre_count,
                (SELECT COUNT(*) FROM song_albums sal WHERE sal.song_id=s.id) AS album_count
             FROM songs s
             WHERE {$where}
             ORDER BY s.id DESC
             LIMIT ? OFFSET ?"
        );
        $stmt->bind_param($types, ...$params);
        $stmt->execute();

        Response::success([
            'items' => $stmt->get_result()->fetch_all(MYSQLI_ASSOC),
            'pagination' => [
                'page' => $page,
                'limit' => $limit,
                'total' => $total,
                'pages' => $total === 0 ? 0 : (int) ceil($total / $limit),
            ],
        ]);
    }

    public function show(int $id): void
    {
        $stmt = $this->db->prepare(
            'SELECT * FROM songs WHERE id=? AND deleted_at IS NULL LIMIT 1'
        );
        $stmt->bind_param('i', $id);
        $stmt->execute();

        $song = $stmt->get_result()->fetch_assoc();

        if (!$song) {
            Response::error('Song not found.', 404);
        }

        $artist = $this->db->prepare(
            "SELECT a.id, a.name, a.slug, sa.role
             FROM song_artists sa
             INNER JOIN artists a ON a.id=sa.artist_id
             WHERE sa.song_id=? AND a.deleted_at IS NULL
             ORDER BY a.name"
        );
        $artist->bind_param('i', $id);
        $artist->execute();

        $genre = $this->db->prepare(
            "SELECT g.id, g.name, g.slug
             FROM song_genres sg
             INNER JOIN genres g ON g.id=sg.genre_id
             WHERE sg.song_id=?
             ORDER BY g.name"
        );
        $genre->bind_param('i', $id);
        $genre->execute();

        $album = $this->db->prepare(
            "SELECT
                al.id,
                al.title,
                al.slug,
                sa.track_number,
                sa.disc_number
             FROM song_albums sa
             INNER JOIN albums al ON al.id=sa.album_id
             WHERE sa.song_id=? AND al.deleted_at IS NULL
             ORDER BY sa.disc_number, sa.track_number"
        );
        $album->bind_param('i', $id);
        $album->execute();

        $song['artists'] = $artist->get_result()->fetch_all(MYSQLI_ASSOC);
        $song['genres'] = $genre->get_result()->fetch_all(MYSQLI_ASSOC);
        $song['albums'] = $album->get_result()->fetch_all(MYSQLI_ASSOC);

        Response::success($song);
    }

    public function create(): void
    {
        $this->save(null, Request::json());
    }

    public function update(int $id): void
    {
        $this->save($id, Request::json());
    }

    private function save(?int $id, array $data): void
    {
        if ($id === null) {
            foreach (['title', 'audio_url', 'duration_seconds'] as $required) {
                if (!array_key_exists($required, $data) || trim((string) $data[$required]) === '') {
                    Response::error("Missing field: {$required}", 422);
                }
            }
        } elseif (!$this->exists($id)) {
            Response::error('Song not found.', 404);
        }

        $this->db->begin_transaction();

        try {
            $clean = $this->cleanSongData($data, $id);
            $relationships = [
                'artists' => $data['artists'] ?? null,
                'genres' => $data['genres'] ?? null,
                'albums' => $data['albums'] ?? null,
            ];

            if ($id === null) {
                $columns = array_keys($clean);
                $values = array_values($clean);
                $types = $this->typesFor($columns);

                $stmt = $this->db->prepare(
                    'INSERT INTO songs (' . implode(',', $columns) . ')
                     VALUES (' . implode(',', array_fill(0, count($columns), '?')) . ')'
                );
                $stmt->bind_param($types, ...$values);
                $stmt->execute();
                $id = (int) $this->db->insert_id;
            } elseif ($clean !== []) {
                $columns = array_keys($clean);
                $values = array_values($clean);
                $types = $this->typesFor($columns);

                $sets = implode(',', array_map(static fn($column) => "{$column}=?", $columns));
                $values[] = $id;
                $types .= 'i';

                $stmt = $this->db->prepare("UPDATE songs SET {$sets} WHERE id=?");
                $stmt->bind_param($types, ...$values);
                $stmt->execute();
            }

            $this->syncRelationships($id, $relationships);

            $this->db->commit();

            $this->show($id);
        } catch (\Throwable $e) {
            $this->db->rollback();
            error_log((string) $e);

            if ((int) $e->getCode() === 1062) {
                Response::error('A song with the same unique value already exists.', 409);
            }

            Response::error(
                Env::get('APP_ENV', 'production') === 'local'
                    ? $e->getMessage()
                    : 'Unable to save song.',
                422
            );
        }
    }

    private function cleanSongData(array $data, ?int $ignoreId): array
    {
        $clean = [];

        foreach (self::FIELDS as $field) {
            if (!array_key_exists($field, $data)) {
                continue;
            }

            $clean[$field] = in_array($field, self::INT_FIELDS, true)
                ? (int) $data[$field]
                : ($data[$field] === null ? null : trim((string) $data[$field]));
        }

        $slugSource = array_key_exists('slug', $clean)
            ? (string) $clean['slug']
            : (string) ($data['title'] ?? '');

        if ($slugSource !== '') {
            $clean['slug'] = $this->uniqueSlug(Slug::make($slugSource), $ignoreId);
        }

        if ($ignoreId === null && !array_key_exists('is_active', $clean)) {
            $clean['is_active'] = 1;
        }

        if ($ignoreId === null && !array_key_exists('is_explicit', $clean)) {
            $clean['is_explicit'] = 0;
        }

        return $clean;
    }

    private function typesFor(array $columns): string
    {
        $types = '';

        foreach ($columns as $column) {
            $types .= in_array($column, self::INT_FIELDS, true) ? 'i' : 's';
        }

        return $types;
    }

    private function exists(int $id): bool
    {
        $stmt = $this->db->prepare(
            'SELECT id FROM songs WHERE id=? AND deleted_at IS NULL LIMIT 1'
        );
        $stmt->bind_param('i', $id);
        $stmt->execute();

        return (bool) $stmt->get_result()->fetch_assoc();
    }

    private function uniqueSlug(string $slug, ?int $ignoreId): string
    {
        $base = $slug;
        $suffix = 2;

        while (true) {
            $sql = 'SELECT id FROM songs WHERE slug=?';
            if ($ignoreId !== null) {
                $sql .= ' AND id<>?';
            }
            $sql .= ' LIMIT 1';

            $stmt = $this->db->prepare($sql);

            if ($ignoreId !== null) {
                $stmt->bind_param('si', $slug, $ignoreId);
            } else {
                $stmt->bind_param('s', $slug);
            }

            $stmt->execute();

            if (!$stmt->get_result()->fetch_assoc()) {
                return $slug;
            }

            $slug = $base . '-' . $suffix++;
        }
    }

    private function syncRelationships(int $songId, array $relationships): void
    {
        if ($relationships['artists'] !== null) {
            $old = $this->db->prepare('DELETE FROM song_artists WHERE song_id=?');
            $old->bind_param('i', $songId);
            $old->execute();

            foreach ((array) $relationships['artists'] as $item) {
                $artistId = (int) (is_array($item) ? ($item['id'] ?? 0) : $item);
                $role = is_array($item) ? (string) ($item['role'] ?? 'Main') : 'Main';

                if ($artistId <= 0) {
                    continue;
                }

                $stmt = $this->db->prepare(
                    'INSERT INTO song_artists(song_id,artist_id,role) VALUES(?,?,?)'
                );
                $stmt->bind_param('iis', $songId, $artistId, $role);
                $stmt->execute();
            }
        }

        if ($relationships['genres'] !== null) {
            $old = $this->db->prepare('DELETE FROM song_genres WHERE song_id=?');
            $old->bind_param('i', $songId);
            $old->execute();

            foreach ((array) $relationships['genres'] as $item) {
                $genreId = (int) (is_array($item) ? ($item['id'] ?? 0) : $item);

                if ($genreId <= 0) {
                    continue;
                }

                $stmt = $this->db->prepare(
                    'INSERT INTO song_genres(song_id,genre_id) VALUES(?,?)'
                );
                $stmt->bind_param('ii', $songId, $genreId);
                $stmt->execute();
            }
        }

        if ($relationships['albums'] !== null) {
            $oldAlbums = $this->db->prepare(
                'SELECT album_id FROM song_albums WHERE song_id=?'
            );
            $oldAlbums->bind_param('i', $songId);
            $oldAlbums->execute();
            $affectedAlbums = array_column(
                $oldAlbums->get_result()->fetch_all(MYSQLI_ASSOC),
                'album_id'
            );

            $delete = $this->db->prepare('DELETE FROM song_albums WHERE song_id=?');
            $delete->bind_param('i', $songId);
            $delete->execute();

            foreach ((array) $relationships['albums'] as $item) {
                $albumId = (int) ($item['id'] ?? 0);

                if ($albumId <= 0) {
                    continue;
                }

                $track = array_key_exists('track_number', $item)
                    ? ($item['track_number'] === null ? null : (int) $item['track_number'])
                    : null;

                $disc = array_key_exists('disc_number', $item)
                    ? (int) $item['disc_number']
                    : 1;

                $stmt = $this->db->prepare(
                    'INSERT INTO song_albums(song_id,album_id,track_number,disc_number)
                     VALUES(?,?,?,?)'
                );
                $stmt->bind_param('iiii', $songId, $albumId, $track, $disc);
                $stmt->execute();

                $affectedAlbums[] = $albumId;
            }

            foreach (array_unique(array_map('intval', $affectedAlbums)) as $albumId) {
                $this->refreshAlbumCount($albumId);
            }
        }
    }

    private function refreshAlbumCount(int $albumId): void
    {
        $stmt = $this->db->prepare(
            'UPDATE albums
             SET total_tracks=(SELECT COUNT(*) FROM song_albums WHERE album_id=?)
             WHERE id=?'
        );
        $stmt->bind_param('ii', $albumId, $albumId);
        $stmt->execute();
    }

    public function delete(int $id): void
    {
        if (!$this->exists($id)) {
            Response::error('Song not found.', 404);
        }

        $this->db->begin_transaction();

        try {
            $albumsStmt = $this->db->prepare(
                'SELECT album_id FROM song_albums WHERE song_id=?'
            );
            $albumsStmt->bind_param('i', $id);
            $albumsStmt->execute();
            $albumIds = array_column(
                $albumsStmt->get_result()->fetch_all(MYSQLI_ASSOC),
                'album_id'
            );

            $update = $this->db->prepare(
                'UPDATE songs SET deleted_at=NOW(), is_active=0 WHERE id=?'
            );
            $update->bind_param('i', $id);
            $update->execute();

            foreach (['song_artists', 'song_genres', 'song_albums'] as $table) {
                $stmt = $this->db->prepare("DELETE FROM {$table} WHERE song_id=?");
                $stmt->bind_param('i', $id);
                $stmt->execute();
            }

            foreach (array_unique(array_map('intval', $albumIds)) as $albumId) {
                $this->refreshAlbumCount($albumId);
            }

            $this->db->commit();

            Response::success(['deleted' => true], 'Song deleted successfully.');
        } catch (\Throwable $e) {
            $this->db->rollback();
            error_log((string) $e);
            Response::error('Unable to delete song.', 422);
        }
    }
}
