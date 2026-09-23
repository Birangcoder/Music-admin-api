<?php
declare(strict_types=1);

namespace AdminApi\Middleware;

use AdminApi\Core\Env;
use AdminApi\Helpers\Response;

final class Auth
{
    public static function require(): void
    {
        $header = self::authorizationHeader();

        if (!preg_match('/^Bearer\s+(.+)$/i', trim($header), $matches)) {
            Response::error('Unauthorized.', 401);
        }

        if (!self::valid($matches[1])) {
            Response::error('Invalid or expired token.', 401);
        }
    }

    private static function authorizationHeader(): string
    {
        $header = $_SERVER['HTTP_AUTHORIZATION'] ?? '';

        if ($header === '' && isset($_SERVER['REDIRECT_HTTP_AUTHORIZATION'])) {
            $header = (string) $_SERVER['REDIRECT_HTTP_AUTHORIZATION'];
        }

        if ($header === '' && function_exists('getallheaders')) {
            $headers = getallheaders();
            $header = (string) ($headers['Authorization'] ?? $headers['authorization'] ?? '');
        }

        return trim($header);
    }

    public static function valid(string $token): bool
    {
        $parts = explode('.', $token);

        if (count($parts) !== 3) {
            return false;
        }

        [$encodedHeader, $encodedPayload, $signature] = $parts;

        $header = self::decode($encodedHeader);
        $payload = self::decode($encodedPayload);

        if (!is_array($header) || !is_array($payload)) {
            return false;
        }

        if (($header['alg'] ?? '') !== 'HS256' || ($header['typ'] ?? '') !== 'JWT') {
            return false;
        }

        $secret = (string) Env::get('ADMIN_TOKEN_SECRET', ADMIN_TOKEN_SECRET);

        if (strlen($secret) < 32) {
            return false;
        }

        $expected = self::base64UrlEncode(
            hash_hmac(
                'sha256',
                $encodedHeader . '.' . $encodedPayload,
                $secret,
                true
            )
        );

        if ($expected === '' || !hash_equals($expected, $signature)) {
            return false;
        }

        return ($payload['role'] ?? '') === 'admin'
            && isset($payload['exp'])
            && (int) $payload['exp'] > time();
    }

    public static function token(string $username): string
    {
        $now = time();

        $header = self::base64UrlEncode(json_encode([
            'alg' => 'HS256',
            'typ' => 'JWT',
        ], JSON_UNESCAPED_SLASHES));

        $payload = self::base64UrlEncode(json_encode([
            'sub' => $username,
            'role' => 'admin',
            'iat' => $now,
            'exp' => $now + Env::int('TOKEN_TTL', TOKEN_TTL),
        ], JSON_UNESCAPED_SLASHES));

        $signature = self::base64UrlEncode(
            hash_hmac('sha256', $header . '.' . $payload, (string) Env::get('ADMIN_TOKEN_SECRET', ADMIN_TOKEN_SECRET), true)
        );

        return $header . '.' . $payload . '.' . $signature;
    }

    private static function base64UrlEncode(string $value): string
    {
        return rtrim(strtr(base64_encode($value), '+/', '-_'), '=');
    }

    private static function decode(string $value): ?array
    {
        $value = strtr($value, '-_', '+/');
        $value .= str_repeat('=', (4 - strlen($value) % 4) % 4);

        $json = base64_decode($value, true);

        if ($json === false) {
            return null;
        }

        $data = json_decode($json, true);

        return is_array($data) ? $data : null;
    }
}
