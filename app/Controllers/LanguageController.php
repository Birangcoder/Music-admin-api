<?php
declare(strict_types=1);

namespace AdminApi\Controllers;

use AdminApi\Core\Database;
use AdminApi\Helpers\Request;
use AdminApi\Helpers\Response;

final class LanguageController extends BaseController
{
    private \mysqli $db;

    public function __construct()
    {
        parent::__construct();
        $this->db = Database::get();
    }

    public function index(): void
    {
        $stmt = $this->db->query(
            "SELECT
                language,
                COUNT(*) AS song_count
             FROM songs
             WHERE deleted_at IS NULL
               AND language IS NOT NULL
               AND TRIM(language) <> ''
             GROUP BY language
             ORDER BY song_count DESC, language ASC"
        );

        Response::success($stmt->fetch_all(MYSQLI_ASSOC));
    }

    public function rename(): void
    {
        $data = Request::json();
        $from = trim((string) ($data['from'] ?? ''));
        $to = trim((string) ($data['to'] ?? ''));

        if ($from === '' || $to === '') {
            Response::error('Both from and to are required.', 422);
        }

        if (mb_strtolower($from) === mb_strtolower($to)) {
            Response::error('The source and target languages are the same.', 422);
        }

        $stmt = $this->db->prepare(
            'UPDATE songs SET language=? WHERE language=? AND deleted_at IS NULL'
        );
        $stmt->bind_param('ss', $to, $from);
        $stmt->execute();

        Response::success([
            'from' => $from,
            'language' => $to,
            'updated_songs' => $stmt->affected_rows,
        ], 'Language renamed successfully.');
    }
}
