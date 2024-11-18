<?php
require 'vendor/autoload.php'; 
require 'config/Database.php';
require 'controller/CartController.php';
require 'controller/UserController.php';
require 'controller/CheckoutController.php';
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
$checkoutController = new CheckoutController();
$router = new Router();

// Routes without authorization
$router->addRoute('POST', '/api/signup', fn($params, $data) => 
    $userController->signUp($data)
);

$router->addRoute('POST', '/api/login', fn($params, $data) => 
    $userController->login($data)
);

// Routes with authorization in Cart
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

// Routes with authorization in Checkout

$router->addRoute('POST', '/api/checkout/initiate', function($params, $data) use ($checkoutController) {
    $auth = AuthMiddleware::authorize();
    return $checkoutController->initiateCheckout($auth->user_id, $data['cart_id'], $data['shipping_address']);
});

$router->addRoute('POST', '/api/checkout/discount', function($params, $data) use ($checkoutController) {
    $auth = AuthMiddleware::authorize();
    return $checkoutController->applyDiscount($data['checkout_id'], $data['discount_code']);
});

$router->addRoute('POST', '/api/checkout/payment', function($params, $data) use ($checkoutController) {
    $auth = AuthMiddleware::authorize();
    return $checkoutController->applyPayment($data['checkout_id'], $data['payment_method']);
});

$router->addRoute('GET', '/api/checkout', function($params, $data) use ($checkoutController) {
    $auth = AuthMiddleware::authorize();
    return $checkoutController->getCheckoutDetails($auth->user_id);
});

$router->addRoute('POST', '/api/checkout/confirm', function($params, $data) use ($checkoutController) {
    $auth = AuthMiddleware::authorize();
    return $checkoutController->confirmCheckout($data['checkout_id']);
});

$router->addRoute('POST', '/api/checkout/cancel', function($params, $data) use ($checkoutController) {
    $auth = AuthMiddleware::authorize();
    return $checkoutController->cancelCheckout($data['checkout_id']);
});


$response = $router->handleRequest($path, $method, $data);
header('Content-Type: application/json');
echo json_encode($response);
?>
