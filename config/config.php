<?php
declare(strict_types=1);
date_default_timezone_set('Asia/Kolkata');

define('APP_ENV', getenv('APP_ENV') ?: 'development');
define('APP_NAME', 'MusicAdminAPI');
define('APP_URL', getenv('APP_URL') ?: 'http://localhost:8080');
define('DB_HOST', getenv('DB_HOST') ?: 'localhost');
define('DB_PORT', getenv('DB_PORT') ?: '3306');
define('DB_NAME', getenv('DB_NAME') ?: 'music_app_v2');
define('DB_USER', getenv('DB_USER') ?: 'root');
define('DB_PASS', getenv('DB_PASS') ?: '');
define('ADMIN_JWT_SECRET', getenv('ADMIN_JWT_SECRET') ?: 'CHANGE_ME_TO_A_LONG_RANDOM_SECRET');
define('ADMIN_EMAIL', getenv('ADMIN_EMAIL') ?: 'admin@example.com');
define('ADMIN_PASSWORD_HASH', getenv('ADMIN_PASSWORD_HASH') ?: '');
define('CORS_ORIGIN', getenv('CORS_ORIGIN') ?: '*');
