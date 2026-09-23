<?php

declare(strict_types=1);

require_once __DIR__ . '/config/config.php';
require_once __DIR__ . '/app/Core/Env.php';

use AdminApi\Core\Env;
use AdminApi\Core\Router;
use AdminApi\Helpers\Response;

// Local development convenience: load .env only when it exists.
// On Render, environment variables are already supplied by the platform.
Env::load(__DIR__ . '/.env');

spl_autoload_register(static function (string $class): void {
    $prefix = 'AdminApi\\';

    if (!str_starts_with($class, $prefix)) {
        return;
    }

    $relative = substr($class, strlen($prefix));
    $file = __DIR__ . '/app/' . str_replace('\\', '/', $relative) . '.php';

    if (is_file($file)) {
        require_once $file;
    }
});

$origin = Env::get('CORS_ORIGIN', CORS_ORIGIN);
header('Access-Control-Allow-Origin: ' . $origin);
header('Access-Control-Allow-Headers: Content-Type, Authorization');
header('Access-Control-Allow-Methods: GET, POST, PUT, PATCH, DELETE, OPTIONS');
header('Access-Control-Max-Age: 86400');
header('Vary: Origin');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

header('Content-Type: application/json; charset=utf-8');

try {
    $router = new Router();
    require __DIR__ . '/routes/api.php';

    $uri = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?: '/';
    $scriptDir = rtrim(str_replace('\\', '/', dirname($_SERVER['SCRIPT_NAME'] ?? '')), '/');

    // Local Apache can expose /MusicAdminAPI/...; Render exposes /...
    if ($scriptDir !== '' && $scriptDir !== '/' && str_starts_with($uri, $scriptDir)) {
        $uri = substr($uri, strlen($scriptDir));
    }

    $uri = '/' . ltrim($uri, '/');
    $router->dispatch($_SERVER['REQUEST_METHOD'], $uri);
} catch (Throwable $e) {
    error_log((string) $e);

    Response::error(
        APP_DEBUG ? $e->getMessage() : 'Internal server error.',
        500
    );
}
