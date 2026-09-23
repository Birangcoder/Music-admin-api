<?php
declare(strict_types=1);

namespace AdminApi\Helpers;

final class Slug
{
    public static function make(string $value): string
    {
        $value = trim(mb_strtolower($value));
        $value = preg_replace('/[^\pL\pN]+/u', '-', $value) ?? '';
        $value = trim($value, '-');

        return $value !== '' ? $value : 'item-' . bin2hex(random_bytes(4));
    }
}
