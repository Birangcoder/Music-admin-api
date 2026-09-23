<?php
declare(strict_types=1);

namespace AdminApi\Controllers;

use AdminApi\Helpers\Response;

final class AlbumController extends CrudController
{
    protected string $table = 'albums';
    protected array $required = ['title'];

    protected array $fields = [
        'title' => 's',
        'slug' => 's',
        'description' => 's',
        'cover_url' => 's',
        'release_date' => 's',
        'album_type' => 's',
        'copyright' => 's',
        'label' => 's',
    ];

    public function tracks(int $id): void
    {
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
                sa.track_number,
                sa.disc_number
             FROM song_albums sa
             INNER JOIN songs s ON s.id = sa.song_id
             WHERE sa.album_id = ?
               AND s.deleted_at IS NULL
             ORDER BY sa.disc_number, sa.track_number, s.id"
        );
        $stmt->bind_param('i', $id);
        $stmt->execute();

        Response::success([
            'album_id' => $id,
            'tracks' => $stmt->get_result()->fetch_all(MYSQLI_ASSOC),
        ]);
    }

    protected function afterUpdate(int $id, array $data): void
    {
        $this->refreshCount($id);
    }

    protected function afterDelete(int $id): void
    {
        $stmt = $this->db->prepare('DELETE FROM song_albums WHERE album_id=?');
        $stmt->bind_param('i', $id);
        $stmt->execute();
    }

    private function refreshCount(int $id): void
    {
        $stmt = $this->db->prepare(
            'UPDATE albums
             SET total_tracks=(SELECT COUNT(*) FROM song_albums WHERE album_id=?)
             WHERE id=?'
        );
        $stmt->bind_param('ii', $id, $id);
        $stmt->execute();
    }
}
