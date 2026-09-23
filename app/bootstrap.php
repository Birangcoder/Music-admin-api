<?php
declare(strict_types=1);
$config = require __DIR__ . '/../config.php';
session_name($config['session_name']);
session_start();

function h(mixed $v): string { return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8'); }
function logged_in(): bool { return !empty($_SESSION['api_token']); }
function require_login(): void {
    if (!logged_in()) { header('Location: login.php'); exit; }
}
function api_request(string $method, string $path, ?array $body=null): array {
    global $config;
    $url = rtrim($config['api_base_url'], '/') . '/' . ltrim($path, '/');
    $headers = ['Accept: application/json'];
    if ($body !== null) $headers[] = 'Content-Type: application/json';
    if (!empty($_SESSION['api_token'])) $headers[] = 'Authorization: Bearer ' . $_SESSION['api_token'];

    $ch=curl_init($url);
    curl_setopt_array($ch,[
        CURLOPT_RETURNTRANSFER=>true,
        CURLOPT_CUSTOMREQUEST=>strtoupper($method),
        CURLOPT_HTTPHEADER=>$headers,
        CURLOPT_TIMEOUT=>30,
        CURLOPT_CONNECTTIMEOUT=>10,
        CURLOPT_FOLLOWLOCATION=>true,
    ]);
    if ($body !== null) curl_setopt($ch,CURLOPT_POSTFIELDS,json_encode($body,JSON_UNESCAPED_SLASHES|JSON_UNESCAPED_UNICODE));
    $raw=curl_exec($ch);
    $err=curl_error($ch);
    $status=(int)curl_getinfo($ch,CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($raw===false) return ['success'=>false,'message'=>'API connection failed: '.$err,'_status'=>0];
    $data=json_decode($raw,true);
    if (!is_array($data)) return ['success'=>false,'message'=>'API returned invalid JSON.','_status'=>$status,'_raw'=>$raw];
    $data['_status']=$status;
    return $data;
}
