<?php
declare(strict_types=1);

namespace AdminApi\Services;

use AdminApi\Core\Env;
use RuntimeException;

final class CloudinaryService
{
    private const FOLDERS = [
        'album-cover' => 'albums',
        'artist-image' => 'artists',
        'song-cover' => 'cover',
        'audio' => 'music',
    ];

    public static function upload(array $file, string $type): array
    {
        if (!isset(self::FOLDERS[$type])) {
            throw new RuntimeException('Unsupported upload type.');
        }

        $cloudName = trim((string) Env::get('CLOUDINARY_CLOUD_NAME', ''));
        $apiKey = trim((string) Env::get('CLOUDINARY_API_KEY', ''));
        $apiSecret = trim((string) Env::get('CLOUDINARY_API_SECRET', ''));

        if ($cloudName === '' || $apiKey === '' || $apiSecret === '') {
            throw new RuntimeException('Cloudinary is not configured.');
        }

        if (!isset($file['tmp_name']) || !is_uploaded_file($file['tmp_name'])) {
            throw new RuntimeException('Invalid uploaded file.');
        }

        $resourceType = $type === 'audio' ? 'video' : 'image';
        $folder = self::FOLDERS[$type];
        $timestamp = time();

        // Keep both the public ID path and Media Library folder predictable.
        // This prevents new uploads from ending up in a single preset folder.
        $signParams = [
            'asset_folder' => $folder,
            'timestamp' => $timestamp,
        ];
        ksort($signParams);

        $pairs = [];
        foreach ($signParams as $key => $value) {
            $pairs[] = $key . '=' . $value;
        }

        $signature = sha1(implode('&', $pairs) . $apiSecret);

        $post = $signParams;
        $post['api_key'] = $apiKey;
        $post['signature'] = $signature;
        $post['file'] = new \CURLFile(
            $file['tmp_name'],
            (string)($file['type'] ?? 'application/octet-stream'),
            (string)($file['name'] ?? 'upload')
        );

        $url = 'https://api.cloudinary.com/v1_1/' . rawurlencode($cloudName) . '/' . $resourceType . '/upload';
        $ch = curl_init($url);

        curl_setopt_array($ch, [
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_POST => true,
            CURLOPT_POSTFIELDS => $post,
            CURLOPT_TIMEOUT => 180,
            CURLOPT_CONNECTTIMEOUT => 20,
            CURLOPT_SSL_VERIFYPEER => true,
            CURLOPT_SSL_VERIFYHOST => 2,
        ]);

        $raw = curl_exec($ch);
        $error = curl_error($ch);
        $status = (int) curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        if ($raw === false || $raw === '') {
            throw new RuntimeException('Cloudinary connection failed' . ($error !== '' ? ': ' . $error : '.'));
        }

        $data = json_decode($raw, true);
        if (!is_array($data)) {
            throw new RuntimeException('Cloudinary returned an invalid response.');
        }

        if ($status < 200 || $status >= 300 || isset($data['error'])) {
            $message = is_array($data['error'] ?? null)
                ? (string)($data['error']['message'] ?? 'Cloudinary upload failed.')
                : 'Cloudinary upload failed.';
            throw new RuntimeException($message);
        }

        $secureUrl = trim((string)($data['secure_url'] ?? ''));
        if ($secureUrl === '') {
            throw new RuntimeException('Cloudinary did not return a secure URL.');
        }

        return [
            'url' => $secureUrl,
            'secure_url' => $secureUrl,
            'public_id' => (string)($data['public_id'] ?? ''),
            'asset_folder' => $folder,
            'resource_type' => $resourceType,
            'format' => (string)($data['format'] ?? ''),
            'bytes' => (int)($data['bytes'] ?? 0),
        ];
    }

    public static function validate(array $file, string $type): void
    {
        if (!isset(self::FOLDERS[$type])) {
            throw new RuntimeException('Unsupported upload type.');
        }

        $error = (int)($file['error'] ?? UPLOAD_ERR_NO_FILE);
        if ($error !== UPLOAD_ERR_OK) {
            $messages = [
                UPLOAD_ERR_INI_SIZE => 'The uploaded file is too large for the server.',
                UPLOAD_ERR_FORM_SIZE => 'The uploaded file is too large.',
                UPLOAD_ERR_PARTIAL => 'The upload was interrupted. Please try again.',
                UPLOAD_ERR_NO_FILE => 'Please choose a file first.',
            ];
            throw new RuntimeException($messages[$error] ?? 'File upload failed.');
        }

        $size = (int)($file['size'] ?? 0);
        $maxBytes = $type === 'audio' ? 100 * 1024 * 1024 : 20 * 1024 * 1024;
        if ($size <= 0 || $size > $maxBytes) {
            throw new RuntimeException(
                $type === 'audio'
                    ? 'Audio must be between 1 byte and 100 MB.'
                    : 'Image must be between 1 byte and 20 MB.'
            );
        }

        if (!is_uploaded_file((string)($file['tmp_name'] ?? ''))) {
            throw new RuntimeException('Invalid uploaded file.');
        }

        if ($type !== 'audio') {
            $info = @getimagesize($file['tmp_name']);
            if ($info === false) {
                throw new RuntimeException('File is not a valid image.');
            }

            $allowed = [IMAGETYPE_JPEG, IMAGETYPE_PNG, IMAGETYPE_GIF, IMAGETYPE_WEBP];
            if (!in_array((int)$info[2], $allowed, true)) {
                throw new RuntimeException('Unsupported image type. Use JPG, PNG, GIF or WEBP.');
            }
            return;
        }

        $extension = strtolower(pathinfo((string)($file['name'] ?? ''), PATHINFO_EXTENSION));
        $allowedExtensions = ['mp3', 'm4a', 'aac', 'wav', 'ogg', 'oga', 'flac', 'webm'];
        if (!in_array($extension, $allowedExtensions, true)) {
            throw new RuntimeException('Unsupported audio type. Use MP3, M4A, AAC, WAV, OGG, FLAC or WEBM.');
        }
    }
}
