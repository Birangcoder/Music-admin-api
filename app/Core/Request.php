<?php
declare(strict_types=1);
namespace App\Core;
final class Request {
    public static function body(): array {
        $raw = file_get_contents('php://input');
        if ($raw === false || trim($raw)==='') return [];
        $data = json_decode($raw, true);
        if (!is_array($data)) Response::error('Invalid JSON body', 400);
        return $data;
    }
    public static function query(string $key, mixed $default=null): mixed { return $_GET[$key] ?? $default; }
}
