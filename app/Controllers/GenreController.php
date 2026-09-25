<?php
declare(strict_types=1);

namespace AdminApi\Controllers;

final class GenreController extends CrudController
{
    protected string $table = 'genres';
    protected bool $softDelete = false;
    protected string $searchColumn = 'name';
    protected array $required = ['name'];
    protected array $fields = ['name' => 's', 'slug' => 's'];
}
