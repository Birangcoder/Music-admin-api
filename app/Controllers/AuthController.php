<?php
declare(strict_types=1);

namespace AdminApi\Controllers;

use AdminApi\Core\Env;
use AdminApi\Helpers\Request;
use AdminApi\Helpers\Response;
use AdminApi\Middleware\Auth;

final class AuthController
{
    public function login(): void
    {
        $data = Request::json();

        $username = trim((string) ($data['username'] ?? ''));
        $password = (string) ($data['password'] ?? '');
        $configuredUsername = (string) Env::get('ADMIN_USERNAME', ADMIN_USERNAME);
        $hash = trim((string) Env::get('ADMIN_PASSWORD_HASH', ADMIN_PASSWORD_HASH));
        $legacyPassword = (string) Env::get('ADMIN_PASSWORD', ADMIN_PASSWORD);
        $secret = trim((string) Env::get('ADMIN_TOKEN_SECRET', ADMIN_TOKEN_SECRET));

        if ($hash === '' && $legacyPassword === '') {
            Response::error('Admin authentication is not configured.', 503);
        }

        if (strlen($secret) < 32) {
            Response::error('Admin token secret is not configured securely.', 503);
        }

        $validPassword = $hash !== ''
            ? password_verify($password, $hash)
            : hash_equals($legacyPassword, $password);

        if (!hash_equals($configuredUsername, $username) || !$validPassword) {
            Response::error('Invalid credentials.', 401);
        }

        Response::success([
            'token' => Auth::token($username),
            'expires_in' => Env::int('TOKEN_TTL', 86400),
        ], 'Login successful.');
    }
}
