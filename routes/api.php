<?php
declare(strict_types=1);

use AdminApi\Controllers\AlbumController;
use AdminApi\Controllers\ArtistController;
use AdminApi\Controllers\AuthController;
use AdminApi\Controllers\DashboardController;
use AdminApi\Controllers\GenreController;
use AdminApi\Controllers\LanguageController;
use AdminApi\Controllers\SongController;
use AdminApi\Controllers\UploadController;
use AdminApi\Helpers\Response;

/*
|--------------------------------------------------------------------------
| Public health / authentication
|--------------------------------------------------------------------------
*/
$router->get('/', static function (): void {
    Response::success([
        'name' => 'Music Admin API',
        'status' => 'ok',
        'version' => '1.0.0',
    ]);
});

$router->get('/health', static function (): void {
    Response::success([
        'status' => 'ok',
    ]);
});

/*
|--------------------------------------------------------------------------
| Authentication
|--------------------------------------------------------------------------
*/
$router->post('/auth/login', [AuthController::class, 'login']);

/*
|--------------------------------------------------------------------------
| Dashboard
|--------------------------------------------------------------------------
*/
$router->get('/dashboard', [DashboardController::class, 'index']);

/*
|--------------------------------------------------------------------------
| Songs
|--------------------------------------------------------------------------
*/
$router->get('/songs', [SongController::class, 'index']);
$router->post('/songs', [SongController::class, 'create']);
$router->get('/songs/{id}', [SongController::class, 'show']);
$router->put('/songs/{id}', [SongController::class, 'update']);
$router->patch('/songs/{id}', [SongController::class, 'update']);
$router->delete('/songs/{id}', [SongController::class, 'delete']);

/*
|--------------------------------------------------------------------------
| Cloudinary uploads
|--------------------------------------------------------------------------
| All uploads are authenticated and handled by the API. The panel never
| receives or stores the Cloudinary API secret.
*/
$router->post('/uploads/{type}', [UploadController::class, 'upload']);

/*
|--------------------------------------------------------------------------
| Albums
|--------------------------------------------------------------------------
*/
$router->get('/albums', [AlbumController::class, 'index']);
$router->post('/albums', [AlbumController::class, 'create']);
$router->get('/albums/{id}', [AlbumController::class, 'show']);
$router->put('/albums/{id}', [AlbumController::class, 'update']);
$router->patch('/albums/{id}', [AlbumController::class, 'update']);
$router->delete('/albums/{id}', [AlbumController::class, 'delete']);
$router->get('/albums/{id}/tracks', [AlbumController::class, 'tracks']);

/*
|--------------------------------------------------------------------------
| Artists
|--------------------------------------------------------------------------
*/
$router->get('/artists', [ArtistController::class, 'index']);
$router->post('/artists', [ArtistController::class, 'create']);
$router->get('/artists/{id}', [ArtistController::class, 'show']);
$router->put('/artists/{id}', [ArtistController::class, 'update']);
$router->patch('/artists/{id}', [ArtistController::class, 'update']);
$router->delete('/artists/{id}', [ArtistController::class, 'delete']);

/*
|--------------------------------------------------------------------------
| Genres
|--------------------------------------------------------------------------
*/
$router->get('/genres', [GenreController::class, 'index']);
$router->post('/genres', [GenreController::class, 'create']);
$router->get('/genres/{id}', [GenreController::class, 'show']);
$router->put('/genres/{id}', [GenreController::class, 'update']);
$router->patch('/genres/{id}', [GenreController::class, 'update']);
$router->delete('/genres/{id}', [GenreController::class, 'delete']);

/*
|--------------------------------------------------------------------------
| Languages
|--------------------------------------------------------------------------
*/
$router->get('/languages', [LanguageController::class, 'index']);
$router->post('/languages/rename', [LanguageController::class, 'rename']);
