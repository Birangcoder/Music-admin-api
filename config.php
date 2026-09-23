<?php
declare(strict_types=1);

return [
    'api_base_url' => getenv('MUSIC_ADMIN_API_URL') ?: 'https://music-admin-api.onrender.com',
    'session_name' => 'music_admin_panel',
];
