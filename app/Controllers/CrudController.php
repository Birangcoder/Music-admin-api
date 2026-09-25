<?php
declare(strict_types=1);

namespace AdminApi\Controllers;

use AdminApi\Core\Database;
use AdminApi\Core\Env;
use AdminApi\Helpers\Request;
use AdminApi\Helpers\Response;
use AdminApi\Helpers\Slug;
use mysqli;

abstract class CrudController extends BaseController
{
    protected mysqli $db;
    protected string $table;
    protected array $fields = [];
    protected array $required = [];
    protected bool $softDelete = true;
    protected string $searchColumn = 'title';

    public function __construct()
    {
        parent::__construct();
        $this->db = Database::get();
    }

    public function index(): void
    {
        $page = max(1, Request::int('page', 1));
        $limit = min(100, max(1, Request::int('limit', 25)));
        $search = Request::string('search');
        $includeTotal = Request::bool(Request::string('include_total', '1'), true);

        $where = $this->softDelete ? 'deleted_at IS NULL' : '1=1';
        $params = [];
        $types = '';

        if ($search !== '') {
            $where .= " AND {$this->searchColumn} LIKE ?";
            $params[] = '%' . $search . '%';
            $types .= 's';
        }

        $total = null;
        if ($includeTotal) {
            $countStmt = $this->db->prepare("SELECT COUNT(*) AS total FROM {$this->table} WHERE {$where}");
            if ($params) {
                $countStmt->bind_param($types, ...$params);
            }
            $countStmt->execute();
            $total = (int) $countStmt->get_result()->fetch_assoc()['total'];
        }

        $offset = ($page - 1) * $limit;
        $queryParams = [...$params, $limit, $offset];
        $queryTypes = $types . 'ii';

        $stmt = $this->db->prepare(
            "SELECT * FROM {$this->table}
             WHERE {$where}
             ORDER BY id DESC
             LIMIT ? OFFSET ?"
        );
        $stmt->bind_param($queryTypes, ...$queryParams);
        $stmt->execute();

        Response::success([
            'items' => $stmt->get_result()->fetch_all(MYSQLI_ASSOC),
            'pagination' => [
                'page' => $page,
                'limit' => $limit,
                'total' => $total,
                'pages' => $total === null ? null : ($total === 0 ? 0 : (int) ceil($total / $limit)),
            ],
        ]);
    }

    public function show(int $id): void
    {
        $where = 'id=?' . ($this->softDelete ? ' AND deleted_at IS NULL' : '');
        $stmt = $this->db->prepare("SELECT * FROM {$this->table} WHERE {$where} LIMIT 1");
        $stmt->bind_param('i', $id);
        $stmt->execute();

        $row = $stmt->get_result()->fetch_assoc();

        if (!$row) {
            Response::error(ucfirst(rtrim($this->table, 's')) . ' not found.', 404);
        }

        Response::success($row);
    }

    public function create(): void
    {
        $data = Request::json();

        foreach ($this->required as $field) {
            if (!array_key_exists($field, $data) || trim((string) $data[$field]) === '') {
                Response::error("Missing field: {$field}", 422);
            }
        }

        $data = $this->prepareData($data, null);

        try {
            $this->db->begin_transaction();

            $id = $this->insert($data);
            $this->afterCreate($id, $data);

            $this->db->commit();

            $this->show($id);
        } catch (\Throwable $e) {
            $this->db->rollback();
            $this->handleDatabaseError($e);
        }
    }

    public function update(int $id): void
    {
        $data = Request::json();

        if ($data === []) {
            Response::error('No fields to update.', 422);
        }

        try {
            $this->db->begin_transaction();

            if (!$this->exists($id)) {
                $this->db->rollback();
                Response::error('Resource not found.', 404);
            }

            $data = $this->prepareData($data, $id);
            $this->updateRow($id, $data);
            $this->afterUpdate($id, $data);

            $this->db->commit();

            $this->show($id);
        } catch (\Throwable $e) {
            $this->db->rollback();
            $this->handleDatabaseError($e);
        }
    }

    public function delete(int $id): void
    {
        try {
            $this->db->begin_transaction();

            if (!$this->exists($id)) {
                $this->db->rollback();
                Response::error('Resource not found.', 404);
            }

            if ($this->softDelete) {
                $stmt = $this->db->prepare("UPDATE {$this->table} SET deleted_at=NOW() WHERE id=?");
                $stmt->bind_param('i', $id);
                $stmt->execute();
            } else {
                $stmt = $this->db->prepare("DELETE FROM {$this->table} WHERE id=?");
                $stmt->bind_param('i', $id);
                $stmt->execute();
            }

            $this->afterDelete($id);
            $this->db->commit();

            Response::success(['deleted' => true], 'Deleted successfully.');
        } catch (\Throwable $e) {
            $this->db->rollback();
            $this->handleDatabaseError($e);
        }
    }

    protected function prepareData(array $data, ?int $ignoreId): array
    {
        $allowed = array_keys($this->fields);
        $clean = [];

        foreach ($allowed as $field) {
            if (!array_key_exists($field, $data)) {
                continue;
            }

            $type = $this->fields[$field];

            $clean[$field] = match ($type) {
                'i' => (int) $data[$field],
                'd' => (float) $data[$field],
                default => $data[$field] === null ? null : trim((string) $data[$field]),
            };
        }

        $slugSource = array_key_exists('slug', $clean)
            ? (string) $clean['slug']
            : (string) ($data['title'] ?? $data['name'] ?? '');

        if (isset($this->fields['slug']) && $slugSource !== '') {
            $clean['slug'] = $this->uniqueSlug(Slug::make($slugSource), $ignoreId);
        }

        return $clean;
    }

    protected function insert(array $data): int
    {
        if ($data === []) {
            Response::error('No valid fields supplied.', 422);
        }

        $columns = array_keys($data);
        $values = array_values($data);
        $types = '';

        foreach ($columns as $column) {
            $types .= $this->fields[$column];
        }

        $placeholders = implode(',', array_fill(0, count($columns), '?'));
        $stmt = $this->db->prepare(
            "INSERT INTO {$this->table} (" . implode(',', $columns) . ") VALUES ({$placeholders})"
        );
        $stmt->bind_param($types, ...$values);
        $stmt->execute();

        return (int) $this->db->insert_id;
    }

    protected function updateRow(int $id, array $data): void
    {
        if ($data === []) {
            Response::error('No valid fields supplied.', 422);
        }

        $sets = [];
        $values = [];
        $types = '';

        foreach ($data as $field => $value) {
            $sets[] = "{$field}=?";
            $values[] = $value;
            $types .= $this->fields[$field];
        }

        $values[] = $id;
        $types .= 'i';

        $stmt = $this->db->prepare(
            "UPDATE {$this->table} SET " . implode(',', $sets) . " WHERE id=?"
        );
        $stmt->bind_param($types, ...$values);
        $stmt->execute();
    }

    protected function exists(int $id): bool
    {
        $where = 'id=?' . ($this->softDelete ? ' AND deleted_at IS NULL' : '');
        $stmt = $this->db->prepare("SELECT id FROM {$this->table} WHERE {$where} LIMIT 1");
        $stmt->bind_param('i', $id);
        $stmt->execute();

        return (bool) $stmt->get_result()->fetch_assoc();
    }

    protected function uniqueSlug(string $slug, ?int $ignoreId = null): string
    {
        $base = $slug;
        $suffix = 2;

        while (true) {
            $sql = "SELECT id FROM {$this->table} WHERE slug=?";
            if ($ignoreId !== null) {
                $sql .= " AND id<>?";
            }
            $sql .= " LIMIT 1";

            $stmt = $this->db->prepare($sql);

            if ($ignoreId !== null) {
                $stmt->bind_param('si', $slug, $ignoreId);
            } else {
                $stmt->bind_param('s', $slug);
            }

            $stmt->execute();

            if (!$stmt->get_result()->fetch_assoc()) {
                return $slug;
            }

            $slug = $base . '-' . $suffix++;
        }
    }

    protected function handleDatabaseError(\Throwable $e): never
    {
        error_log((string) $e);

        if ((int) $e->getCode() === 1062) {
            Response::error('A record with the same unique value already exists.', 409);
        }

        Response::error(
            Env::get('APP_ENV', 'production') === 'local'
                ? $e->getMessage()
                : 'Unable to complete the request.',
            422
        );
    }

    protected function afterCreate(int $id, array $data): void {}
    protected function afterUpdate(int $id, array $data): void {}
    protected function afterDelete(int $id): void {}
}
