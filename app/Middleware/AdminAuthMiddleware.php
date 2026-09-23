<?php
declare(strict_types=1);
namespace App\Middleware;
use App\Core\Jwt;
use App\Core\Response;
final class AdminAuthMiddleware {
    public static function handle(): void {
        $header=$_SERVER['HTTP_AUTHORIZATION']??'';
        if(!preg_match('/^Bearer\s+(.+)$/i',$header,$m)) Response::error('Admin authentication required',401);
        $payload=Jwt::verify($m[1]); if(!$payload || ($payload['role']??'')!=='admin') Response::error('Invalid or expired admin token',401);
    }
}
