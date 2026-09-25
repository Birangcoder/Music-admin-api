<?php
declare(strict_types=1);

namespace AdminApi\Controllers;

use AdminApi\Helpers\Request;
use AdminApi\Helpers\Response;

final class ArtistController extends CrudController
{
    protected string $table = 'artists';
    protected string $searchColumn = 'name';
    protected array $required = ['name'];
    protected array $fields = [
        'name' => 's', 'slug' => 's', 'bio' => 's', 'country' => 's',
        'image_url' => 's', 'verified' => 'i', 'monthly_listeners' => 'i',
    ];

    public function index(): void
    {
        $page = max(1, Request::int('page', 1));
        $limit = min(100, max(1, Request::int('limit', 25)));
        $search = Request::string('search');
        $includeTotal = Request::bool(Request::string('include_total', '1'), true);
        $where = 'a.deleted_at IS NULL'; $params=[]; $types='';
        if ($search !== '') { $where .= ' AND a.name LIKE ?'; $params[]='%'.$search.'%'; $types.='s'; }
        $total=null;
        if ($includeTotal) {
            $st=$this->db->prepare("SELECT COUNT(*) total FROM artists a WHERE {$where}");
            if($params)$st->bind_param($types,...$params); $st->execute(); $total=(int)$st->get_result()->fetch_assoc()['total'];
        }
        $offset=($page-1)*$limit; $qp=[...$params,$limit,$offset]; $qt=$types.'ii';
        $st=$this->db->prepare("SELECT a.id,a.name,a.slug,a.bio,a.country,a.image_url,a.verified,a.monthly_listeners,a.created_at,a.updated_at,a.deleted_at FROM artists a WHERE {$where} ORDER BY a.id DESC LIMIT ? OFFSET ?");
        $st->bind_param($qt,...$qp); $st->execute(); $items=$st->get_result()->fetch_all(MYSQLI_ASSOC);
        $payload=['items'=>$items,'pagination'=>['page'=>$page,'limit'=>$limit,'total'=>$total,'pages'=>$total===null?null:($total===0?0:(int)ceil($total/$limit))]];
        if (Request::bool(Request::string('check_metrics','0'), false)) {
            $m=$this->db->query("SELECT COUNT(*) total_artists, SUM(CASE WHEN COALESCE(monthly_listeners,0)>0 THEN 1 ELSE 0 END) non_zero, SUM(CASE WHEN COALESCE(monthly_listeners,0)=0 THEN 1 ELSE 0 END) zero FROM artists WHERE deleted_at IS NULL")->fetch_assoc();
            $payload['metrics_check']=['total_artists'=>(int)$m['total_artists'],'non_zero_monthly_listeners'=>(int)$m['non_zero'],'zero_monthly_listeners'=>(int)$m['zero'],'all_zero_monthly_listeners'=>((int)$m['total_artists']>0 && (int)$m['non_zero']===0)];
        }
        Response::success($payload);
    }
}
