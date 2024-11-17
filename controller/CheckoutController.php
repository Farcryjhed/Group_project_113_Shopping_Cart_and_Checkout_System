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
    
  
    
}
?>
