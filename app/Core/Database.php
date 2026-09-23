<?php
declare(strict_types=1);

namespace AdminApi\Core;

use mysqli;
use RuntimeException;

final class Database
{
    private static ?mysqli $db = null;

    public static function get(): mysqli
    {
        if (self::$db instanceof mysqli) {
            return self::$db;
        }

        mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

        try {
            self::$db = new mysqli(
                Env::get('DB_HOST', '127.0.0.1'),
                Env::get('DB_USER', 'root'),
                Env::get('DB_PASS', ''),
                Env::get('DB_NAME', 'music_app_v2'),
                Env::int('DB_PORT', 3306)
            );
            self::$db->set_charset('utf8mb4');
        } catch (\Throwable $e) {
            throw new RuntimeException('Database connection failed.', 0, $e);
        }

        return self::$db;
    }
}
