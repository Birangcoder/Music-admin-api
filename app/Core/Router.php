<?php
declare(strict_types=1);

namespace AdminApi\Core;

use AdminApi\Helpers\Response;

final class Router
{
    /** @var array<string, array<int, array{path:string, action:callable|array}>> */
    private array $routes = [];

    public function get(string $path, callable|array $action): void { $this->add('GET', $path, $action); }
    public function post(string $path, callable|array $action): void { $this->add('POST', $path, $action); }
    public function put(string $path, callable|array $action): void { $this->add('PUT', $path, $action); }
    public function patch(string $path, callable|array $action): void { $this->add('PATCH', $path, $action); }
    public function delete(string $path, callable|array $action): void { $this->add('DELETE', $path, $action); }

    private function add(string $method, string $path, callable|array $action): void
    {
        $path = trim($path, '/');
        $this->routes[$method][] = ['path' => $path, 'action' => $action];
    }

    public function dispatch(string $method, string $path): void
    {
        $path = trim(rawurldecode($path), '/');

        foreach ($this->routes[$method] ?? [] as $route) {
            $paramNames = [];

            $pattern = preg_replace_callback(
                '/\{([a-zA-Z_][a-zA-Z0-9_]*)\}/',
                static function (array $m) use (&$paramNames): string {
                    $paramNames[] = $m[1];
                    return '([^/]+)';
                },
                $route['path']
            );

            if (preg_match('#^' . $pattern . '$#', $path, $matches) !== 1) {
                continue;
            }

            array_shift($matches);
            $action = $route['action'];

            if (is_array($action)) {
                $controller = new $action[0]();
                $controller->{$action[1]}(...array_map(
                    static fn(string $value): int|string => ctype_digit($value) ? (int) $value : $value,
                    $matches
                ));
            } else {
                $action(...$matches);
            }

            return;
        }

        $allowed = [];
        foreach ($this->routes as $routeMethod => $routes) {
            foreach ($routes as $route) {
                $pattern = preg_replace('/\{[^}]+\}/', '[^/]+', $route['path']);
                if (preg_match('#^' . $pattern . '$#', $path) === 1) {
                    $allowed[] = $routeMethod;
                    break;
                }
            }
        }

        if ($allowed !== []) {
            header('Allow: ' . implode(', ', $allowed));
            Response::error('Method not allowed.', 405);
        }

        Response::error('Route not found.', 404);
    }
}
