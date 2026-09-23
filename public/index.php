<?php
declare(strict_types=1);

require_once __DIR__ . '/../app/Core/Env.php';

use AdminApi\Core\Env;
use AdminApi\Core\Router;
use AdminApi\Helpers\Response;

Env::load(__DIR__ . '/../.env');

spl_autoload_register(
    static function (string $class): void {
        $prefix = 'AdminApi\\';

        if (!str_starts_with($class, $prefix)) {
            return;
        }

        $relative = substr($class, strlen($prefix));
        $file = __DIR__ . '/../app/' . str_replace('\\', '/', $relative) . '.php';

        if (is_file($file)) {
            require_once $file;
        }
    }
);

$origin = Env::get('CORS_ORIGIN', '*');

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

    require __DIR__ . '/../routes/api.php';

    $path = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?: '/';
    $path = '/' . ltrim(str_replace('\\', '/', $path), '/');

    // The front controller lives at /MusicAdminAPI/public/index.php, but the
    // API supports both /MusicAdminAPI/... and /MusicAdminAPI/public/....
    $publicBase = rtrim(str_replace('\\', '/', dirname($_SERVER['SCRIPT_NAME'] ?? '')), '/');
    $appBase = dirname($publicBase);
    if ($appBase === '.' || $appBase === DIRECTORY_SEPARATOR) {
        $appBase = '';
    }
    $appBase = rtrim(str_replace('\\', '/', $appBase), '/');

    foreach (array_values(array_unique(array_filter([$publicBase, $appBase]))) as $base) {
        if ($path === $base) {
            $path = '/';
            break;
        }

        if (str_starts_with($path, $base . '/')) {
            $path = substr($path, strlen($base));
            break;
        }
    }

    $path = '/' . ltrim($path, '/');
    $router->dispatch($_SERVER['REQUEST_METHOD'], $path);
} catch (\Throwable $e) {
    error_log((string) $e);

    Response::error(
        Env::get('APP_ENV', 'production') === 'local'
            ? $e->getMessage()
            : 'Internal server error.',
        500
    );
}
