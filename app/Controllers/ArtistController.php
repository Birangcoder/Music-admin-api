<?php
declare(strict_types=1);

namespace AdminApi\Controllers;

final class ArtistController extends CrudController
{
    protected string $table = 'artists';
    protected string $searchColumn = 'name';

    protected array $required = ['name'];

    protected array $fields = [
        'name' => 's',
        'slug' => 's',
        'bio' => 's',
        'country' => 's',
        'image_url' => 's',
        'verified' => 'i',
        'monthly_listeners' => 'i',
    ];
}
