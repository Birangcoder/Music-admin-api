<?php
declare(strict_types=1);
namespace App\Core;
final class Jwt {
    private static function b64(string $v): string {return rtrim(strtr(base64_encode($v), '+/', '-_'), '=');}
    private static function ub64(string $v): string {return base64_decode(strtr($v, '-_', '+/').str_repeat('=', (4-strlen($v)%4)%4));}
    public static function make(array $payload): string {
        $header=self::b64(json_encode(['alg'=>'HS256','typ'=>'JWT'])); $body=self::b64(json_encode($payload));
        $sig=self::b64(hash_hmac('sha256',$header.'.'.$body,ADMIN_JWT_SECRET,true)); return "$header.$body.$sig";
    }
    public static function verify(string $token): ?array {
        $p=explode('.',$token); if(count($p)!==3)return null; [$h,$b,$s]=$p;
        $expected=self::b64(hash_hmac('sha256',$h.'.'.$b,ADMIN_JWT_SECRET,true)); if(!hash_equals($expected,$s))return null;
        $data=json_decode(self::ub64($b),true); if(!is_array($data))return null; if(isset($data['exp'])&&time()>$data['exp'])return null; return $data;
    }
}
