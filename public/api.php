<?php
require_once __DIR__.'/../app/bootstrap.php';
header('Content-Type: application/json; charset=utf-8');

$path=(string)($_GET['path']??'');
$method=strtoupper($_SERVER['REQUEST_METHOD']??'GET');

if($path==='' || $path[0]!=='/') { http_response_code(400); echo json_encode(['success'=>false,'message'=>'Invalid API path.']); exit; }
if(!logged_in()){ http_response_code(401); echo json_encode(['success'=>false,'message'=>'Session expired.']); exit; }

$allowedPrefixes=['/dashboard','/songs','/albums','/artists','/genres','/languages'];
$ok=false; foreach($allowedPrefixes as $prefix){ if($path===$prefix || str_starts_with($path,$prefix.'/') || str_starts_with($path,$prefix.'?')) {$ok=true;break;} }
if(!$ok){ http_response_code(403); echo json_encode(['success'=>false,'message'=>'Endpoint not allowed.']); exit; }

$body=null;
if(in_array($method,['POST','PUT','PATCH'],true)){
    $raw=file_get_contents('php://input')?:'';
    $body=json_decode($raw,true);
    if(!is_array($body)) $body=[];
}
$r=api_request($method,$path,$body);
http_response_code((int)($r['_status']??200));
unset($r['_status'],$r['_raw']);
echo json_encode($r,JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES);
