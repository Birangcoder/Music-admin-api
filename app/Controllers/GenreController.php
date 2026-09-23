<?php
declare(strict_types=1);

namespace AdminApi\Controllers;

final class GenreController extends CrudController
{
    protected string $table = 'genres';
    protected bool $softDelete = false;
    protected string $searchColumn = 'name';

    protected array $required = ['name'];

    protected array $fields = [
        'name' => 's',
        'slug' => 's',
    ];

    protected function afterDelete(int $id): void
    {
        $stmt = $this->db->prepare('DELETE FROM song_genres WHERE genre_id=?');
        $stmt->bind_param('i', $id);
        $stmt->execute();
    }
}
