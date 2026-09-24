<?php
declare(strict_types=1);

namespace AdminApi\Controllers;

use AdminApi\Helpers\Response;
use AdminApi\Services\CloudinaryService;

final class UploadController extends BaseController
{
    public function upload(string $type): void
    {
        try {
            $file = $_FILES['file'] ?? [];
            CloudinaryService::validate($file, $type);
            $result = CloudinaryService::upload($file, $type);

            Response::success($result, 'File uploaded successfully.');
        } catch (\Throwable $e) {
            error_log((string)$e);
            $status = str_contains(strtolower($e->getMessage()), 'too large') ? 413 : 422;
            Response::error($e->getMessage(), $status);
        }
    }
}
