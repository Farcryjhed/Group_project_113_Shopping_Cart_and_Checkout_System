<?php
require_once __DIR__ . '/../models/CheckoutModel.php';

class CheckoutController {
    private $checkoutModel;

    public function __construct() {
        $this->checkoutModel = new CheckoutModel();
    }

    public function initiateCheckout($user_id, $cart_id, $shipping_address) {
        $items = $this->checkoutModel->getCartItems($cart_id);
        if (empty($items)) {
            return ["message" => "Cart is empty or not found."];
        }

        $checkout_id = $this->checkoutModel->createCheckout($user_id, $cart_id, $shipping_address);

        return [
            "message" => "Checkout initiated",
            "checkout_id" => $checkout_id,
            "user_id" => $user_id,
            "cart_id" => $cart_id,
            "items" => $items,
            "available_payment_methods" => ["credit", "debit", "COD", "GCash"]
        ];
    }

    public function applyDiscount($checkout_id, $discount_code) {
        return $this->checkoutModel->applyDiscount($checkout_id, $discount_code);
    }
    
    public function applyPayment($checkout_id, $payment_method) {
        return $this->checkoutModel->applyPayment($checkout_id, $payment_method);
    }
    
    public function getCheckoutDetails($user_id) {
        $checkout = $this->checkoutModel->getCheckoutByUserId($user_id);
        if (!$checkout) {
            return ["message" => "No checkout information found for this user."];
        }
    
        // Format the response
        $response = [
            "message" => "Checkout information retrieved successfully",
            "checkout_id" => $checkout['checkout_id'],
            "cart_id" => $checkout['cart_id'],
            "user_id" => $checkout['user_id'],
            "shipping_address" => json_decode($checkout['shipping_address'], true),
            "created_at" => $checkout['created_at'],
            "discount_code" => $checkout['discount_code'],
            "discount_value" => floatval($checkout['discount_value']),
            "payment_method" => $checkout['payment_method'],
            "items" => array_map(function($item) {
                return [
                    "product_id" => $item['product_id'],
                    "product_name" => $item['product_name'],
                    "quantity" => intval($item['quantity']),
                    "price" => $item['price']
                ];
            }, $checkout['items'])
        ];
    
        return $response;
    }
    
    public function confirmCheckout($checkout_id) {
        $checkout = $this->checkoutModel->getCheckoutById($checkout_id);
        if (!$checkout) {
            return ["message" => "Checkout not found"];
        }
    
        $order_id = $this->checkoutModel->createOrderFromCheckout($checkout);
    
        return [
            "message" => "Order confirmed",
            "order_id" => $order_id,
            "checkout_id" => $checkout_id,
            "user_id" => $checkout['user_id']
        ];
    }
    
    public function cancelCheckout($checkout_id) {
        $checkout = $this->checkoutModel->getCheckoutById($checkout_id);
        if (!$checkout) {
            return ["message" => "Checkout not found"];
        }

        $isCancelled = $this->checkoutModel->cancelCheckout($checkout_id);
        if ($isCancelled) {
            return [
                "message" => "Checkout cancelled successfully",
                "checkout_id" => $checkout_id
            ];
        } else {
            return ["message" => "Failed to cancel the checkout"];
        }
    }
    
    
}
?>
