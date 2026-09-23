<?php
declare(strict_types=1);

namespace AdminApi\Helpers;

final class Request
{
    public static function json(): array
    {
        $raw = file_get_contents('php://input') ?: '';

        if (trim($raw) === '') {
            return [];
        }

        $data = json_decode($raw, true);

        if (!is_array($data)) {
            Response::error('Invalid JSON body.', 400);
        }

        return $data;
    }

    public static function int(string $key, int $default = 0): int
    {
        $value = $_GET[$key] ?? null;

        return is_numeric($value) ? (int) $value : $default;
    }

    public static function string(string $key, string $default = ''): string
    {
        return isset($_GET[$key]) ? trim((string) $_GET[$key]) : $default;
    }

    public static function bool(mixed $value, bool $default = false): bool
    {
        if ($value === null) {
            return $default;
        }

        return filter_var($value, FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE) ?? $default;
    }
}
