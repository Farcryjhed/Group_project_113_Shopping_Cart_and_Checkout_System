<?php
require 'vendor/autoload.php'; 
require 'config/Database.php';
require 'controller/CartController.php';
require 'controller/UserController.php';
require 'core/Router.php';
require 'core/AuthMiddleware.php';  

use Dotenv\Dotenv;


$dotenv = Dotenv::createImmutable(__DIR__);
$dotenv->load();

$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$method = $_SERVER['REQUEST_METHOD'];
$data = json_decode(file_get_contents("php://input"), true);

$cartController = new CartController();
$userController = new UserController();
$router = new Router();

// Routes without authorization
$router->addRoute('POST', '/api/signup', fn($params, $data) => 
    $userController->signUp($data)
);

$router->addRoute('POST', '/api/login', fn($params, $data) => 
    $userController->login($data)
);

// Routes with authorization
$router->addRoute('GET', '/api/cart', function($params, $data) use ($cartController) {
    $auth = AuthMiddleware::authorize();
    return $cartController->viewCart($auth->user_id);
});

$router->addRoute('POST', '/api/cart_items', function($params, $data) use ($cartController) {
    $auth = AuthMiddleware::authorize();
    return $cartController->addItemToCart($auth->user_id, $data['product_id'], $data['quantity']);
});

$router->addRoute('PUT', '/api/cart/items/update/{product_id}', function($params, $data) use ($cartController) {
    $auth = AuthMiddleware::authorize();
    return $cartController->updateItemQuantity($auth->user_id, $params['product_id'], $data['quantity']);
});

$router->addRoute('DELETE', '/api/cart/items/{product_id}', function($params, $data) use ($cartController) {
    $auth = AuthMiddleware::authorize();
    return $cartController->removeItemFromCart($auth->user_id, $params['product_id']);
});

$router->addRoute('DELETE', '/api/cart/delete', function($params, $data) use ($cartController) {
    $auth = AuthMiddleware::authorize();
    return $cartController->clearCart($auth->user_id);
});

$response = $router->handleRequest($path, $method, $data);
header('Content-Type: application/json');
echo json_encode($response);
?>
