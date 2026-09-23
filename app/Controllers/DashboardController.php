<?php
declare(strict_types=1);

namespace AdminApi\Controllers;

use AdminApi\Core\Database;
use AdminApi\Helpers\Response;

final class DashboardController extends BaseController
{
    public function index(): void
    {
        $db = Database::get();

        $count = static function (\mysqli $db, string $table, bool $softDelete = true): int {
            $where = $softDelete ? ' WHERE deleted_at IS NULL' : '';
            $result = $db->query("SELECT COUNT(*) AS total FROM {$table}{$where}");
            return (int) $result->fetch_assoc()['total'];
        };

        $languages = (int) $db->query(
            "SELECT COUNT(DISTINCT language) AS total
             FROM songs
             WHERE deleted_at IS NULL
               AND language IS NOT NULL
               AND TRIM(language) <> ''"
        )->fetch_assoc()['total'];

        $recent = $db->query(
            "SELECT id, title, slug, cover_url, language, release_date, created_at
             FROM songs
             WHERE deleted_at IS NULL
             ORDER BY id DESC
             LIMIT 10"
        )->fetch_all(MYSQLI_ASSOC);

        Response::success([
            'counts' => [
                'songs' => $count($db, 'songs'),
                'albums' => $count($db, 'albums'),
                'artists' => $count($db, 'artists'),
                'genres' => $count($db, 'genres', false),
                'languages' => $languages,
            ],
            'recent_songs' => $recent,
        ]);
    }
}
