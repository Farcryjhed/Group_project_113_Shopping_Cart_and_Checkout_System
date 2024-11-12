<?php
class Router {
    private $routes = [];

    public function addRoute($method, $route, $action) {
        $this->routes[strtoupper($method)][$route] = $action;
    }

    public function handleRequest($path, $method, $data) {
        foreach ($this->routes[$method] ?? [] as $route => $action) {
            $routeRegex = preg_replace('#\{([^}]+)\}#', '([^/]+)', $route);
            if (preg_match('#^' . $routeRegex . '$#', $path, $matches)) {
                array_shift($matches);
                preg_match_all('#\{([^}]+)\}#', $route, $paramNames);
                $params = array_combine($paramNames[1], $matches);
                return $action($params, $data);
            }
        }
        http_response_code(404);
        return ["message" => "Endpoint not found"];
    }
}
?>
