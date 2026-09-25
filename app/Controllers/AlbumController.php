<?php
declare(strict_types=1);

namespace AdminApi\Controllers;

use AdminApi\Helpers\Request;
use AdminApi\Helpers\Response;

final class AlbumController extends CrudController
{
    protected string $table = 'albums';
    protected array $required = ['title'];
    protected array $fields = [
        'title' => 's', 'slug' => 's', 'description' => 's', 'cover_url' => 's',
        'release_date' => 's', 'album_type' => 's', 'copyright' => 's', 'label' => 's',
    ];

    public function index(): void
    {
        $page=max(1,Request::int('page',1)); $limit=min(100,max(1,Request::int('limit',25))); $search=Request::string('search');
        $includeTotal=Request::bool(Request::string('include_total','1'),true);
        $where='a.deleted_at IS NULL'; $params=[]; $types='';
        if($search!==''){ $where.=' AND a.title LIKE ?'; $params[]='%'.$search.'%'; $types.='s'; }
        $total=null;
        if($includeTotal){$st=$this->db->prepare("SELECT COUNT(*) total FROM albums a WHERE {$where}"); if($params)$st->bind_param($types,...$params); $st->execute(); $total=(int)$st->get_result()->fetch_assoc()['total'];}
        $offset=($page-1)*$limit; $qp=[...$params,$limit,$offset]; $qt=$types.'ii';
        $st=$this->db->prepare("SELECT a.id,a.title,a.slug,a.description,a.cover_url,a.release_date,a.album_type,a.copyright,a.label,COUNT(sa.song_id) AS total_tracks,a.created_at,a.updated_at,a.deleted_at FROM albums a LEFT JOIN song_albums sa ON sa.album_id=a.id WHERE {$where} GROUP BY a.id,a.title,a.slug,a.description,a.cover_url,a.release_date,a.album_type,a.copyright,a.label,a.created_at,a.updated_at,a.deleted_at ORDER BY a.id DESC LIMIT ? OFFSET ?");
        $st->bind_param($qt,...$qp); $st->execute(); $items=$st->get_result()->fetch_all(MYSQLI_ASSOC);
        Response::success(['items'=>$items,'pagination'=>['page'=>$page,'limit'=>$limit,'total'=>$total,'pages'=>$total===null?null:($total===0?0:(int)ceil($total/$limit))]]);
    }

    public function tracks(int $id): void
    {
        $stmt=$this->db->prepare("SELECT s.id,s.title,s.slug,s.audio_url,s.cover_url,s.duration_seconds,s.language,s.release_date,sa.track_number,sa.disc_number FROM song_albums sa INNER JOIN songs s ON s.id=sa.song_id WHERE sa.album_id=? AND s.deleted_at IS NULL ORDER BY sa.disc_number,sa.track_number,s.id");
        $stmt->bind_param('i',$id); $stmt->execute(); Response::success(['album_id'=>$id,'tracks'=>$stmt->get_result()->fetch_all(MYSQLI_ASSOC)]);
    }
    protected function afterUpdate(int $id,array $data):void { $this->refreshCount($id); }
    protected function afterDelete(int $id):void { $st=$this->db->prepare('DELETE FROM song_albums WHERE album_id=?'); $st->bind_param('i',$id); $st->execute(); }
    private function refreshCount(int $id):void { $st=$this->db->prepare('UPDATE albums SET total_tracks=(SELECT COUNT(*) FROM song_albums WHERE album_id=?) WHERE id=?'); $st->bind_param('ii',$id,$id); $st->execute(); }
}
