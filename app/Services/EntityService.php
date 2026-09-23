<?php
declare(strict_types=1);
namespace AdminApi\Services;
use AdminApi\Core\Database; use AdminApi\Helpers\Slug; use mysqli;
class EntityService {
    private mysqli $db; public function __construct(){ $this->db=Database::get(); }
    public function list(string $table,array $cols,string $search='',int $page=1,int $limit=25):array {
        $allowed=['artists','albums','genres','songs']; if(!in_array($table,$allowed,true))throw new \InvalidArgumentException('Invalid table');
        $where=$table==='genres'?'1=1':'deleted_at IS NULL'; $params=[]; $types='';
        if($search!==''){ $where.=' AND title LIKE ?'; if($table!=='albums'&&$table!=='songs') $where=str_replace('title LIKE ?','name LIKE ?',$where); $params[]='%'.$search.'%';$types='s'; }
        $count=$this->db->query("SELECT COUNT(*) c FROM `$table` WHERE $where")->fetch_assoc()['c'];
        $offset=($page-1)*$limit; $sql="SELECT ".implode(',',$cols)." FROM `$table` WHERE $where ORDER BY id DESC LIMIT ? OFFSET ?"; $params[]=$limit;$params[]=$offset;$types.='ii';
        $st=$this->db->prepare($sql);$st->bind_param($types,...$params);$st->execute();$rows=$st->get_result()->fetch_all(MYSQLI_ASSOC); return ['items'=>$rows,'pagination'=>['page'=>$page,'limit'=>$limit,'total'=>(int)$count,'pages'=>(int)ceil($count/$limit)]];
    }
}
