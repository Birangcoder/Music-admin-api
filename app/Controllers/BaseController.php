<?php
declare(strict_types=1);

namespace AdminApi\Controllers;

use AdminApi\Middleware\Auth;

abstract class BaseController
{
    public function __construct()
    {
        Auth::require();
    }
}
