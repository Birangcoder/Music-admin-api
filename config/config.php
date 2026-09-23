<?php

declare(strict_types=1);

date_default_timezone_set('Asia/Kolkata');

$environment = getenv('APP_ENV') ?: 'development';

$secretsFile = __DIR__ . '/secrets.php';

if ($environment !== 'production' && file_exists($secretsFile)) {
    require_once $secretsFile;
}

define('APP_VERSION', '1.0.0');
define('APP_NAME', 'MusicAdminAPI');
define('APP_ENV', $environment);
define('APP_DEBUG', $environment !== 'production');

define('APP_URL', getenv('APP_URL') ?: 'http://localhost/MusicAdminAPI/');

define('DB_HOST', getenv('DB_HOST') ?: '127.0.0.1');
define('DB_PORT', getenv('DB_PORT') ?: '3306');
define('DB_NAME', getenv('DB_NAME') ?: 'music_app_v2');
define('DB_USER', getenv('DB_USER') ?: 'root');
define('DB_PASS', getenv('DB_PASS') ?: '');

define('ADMIN_USERNAME', getenv('ADMIN_USERNAME') ?: 'admin');
define('ADMIN_PASSWORD_HASH', getenv('ADMIN_PASSWORD_HASH') ?: '');
define('ADMIN_PASSWORD', getenv('ADMIN_PASSWORD') ?: '');
define('ADMIN_TOKEN_SECRET', getenv('ADMIN_TOKEN_SECRET') ?: '');
define('TOKEN_TTL', (int) (getenv('TOKEN_TTL') ?: 86400));

define('CORS_ORIGIN', getenv('CORS_ORIGIN') ?: '*');

define('DEFAULT_LIMIT', 25);
define('MAX_LIMIT', 100);

error_reporting(E_ALL);
ini_set('display_errors', APP_DEBUG ? '1' : '0');
