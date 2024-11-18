<?php
require_once __DIR__ . '/../config/Database.php';

class CheckoutModel {
    private $conn;

    public function __construct() {
        $database = new Database();
        $this->conn = $database->getConnection();
    }

    public function createCheckout($user_id, $cart_id, $shipping_address, $discount_code = null, $discount_value = 0) {
        $checkout_id = uniqid('', true);
    
        $query = "INSERT INTO checkouts (checkout_id, user_id, cart_id, shipping_address, discount_code, discount_value) 
                  VALUES (?, ?, ?, ?, ?, ?)";
    
        $stmt = $this->conn->prepare($query);
        $stmt->execute([$checkout_id, $user_id, $cart_id, json_encode($shipping_address), $discount_code, $discount_value]);
        return $checkout_id;
    }
    
    

    public function getCartItems($cart_id) {
        $query = "SELECT cart_item.cart_id, cart_item.product_id, product.product_name, 
                         cart_item.quantity, product.price
                  FROM cart_items AS cart_item
                  JOIN products AS product ON cart_item.product_id = product.product_id
                  WHERE cart_item.cart_id = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->execute([$cart_id]);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function applyDiscount($checkout_id, $discount_code) {
        $valid_codes = ["SAVE10", "SAVE20", "FREESHIP"];
        $discounts = ["SAVE10" => 10, "SAVE20" => 20, "FREESHIP" => 0]; 
    
        if (in_array($discount_code, $valid_codes)) {
            $discount_value = $discounts[$discount_code];
            
            $query = "UPDATE checkouts SET discount_code = ?, discount_value = ? WHERE checkout_id = ?";
            $stmt = $this->conn->prepare($query);
            $stmt->execute([$discount_code, $discount_value, $checkout_id]);
    
            return [
                "message" => "Discount applied successfully",
                "checkout_id" => $checkout_id,
                "discount_code" => $discount_code,
                "discount_value" => $discount_value
            ];
        } else {
            return ["message" => "Invalid discount code"];
        }
    }
    

    public function applyPayment($checkout_id, $payment_method) {
        $valid_methods = ['credit', 'debit', 'COD', 'GCash'];
    
        // Check if the provided payment method is valid
        if (in_array($payment_method, $valid_methods)) {
            $query = "UPDATE checkouts SET payment_method = ? WHERE checkout_id = ?";
            $stmt = $this->conn->prepare($query);
            $stmt->execute([$payment_method, $checkout_id]);
    
            return [
                "message" => "Payment method applied successfully",
                "checkout_id" => $checkout_id,
                "payment_method" => $payment_method
            ];
        } else {
            return ["message" => "Invalid payment method"];
        }
    }

    
    public function getCheckoutByUserId($user_id) {
        $query = "SELECT * FROM checkouts WHERE user_id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->execute([$user_id]);
        $checkout = $stmt->fetch(PDO::FETCH_ASSOC);
    
        if ($checkout) {
            $cartItems = $this->getCartItems($checkout['cart_id']);
            $checkout['items'] = $cartItems;
            return $checkout;
        }
    
        return null;
    }
    
    public function getCheckoutById($checkout_id) {
        $query = "SELECT * FROM checkouts WHERE checkout_id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->execute([$checkout_id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
    
    public function createOrderFromCheckout($checkout) {
        $order_id = uniqid('', true);
        $query = "INSERT INTO orders (order_id, total_amount, shipping_address, user_id) VALUES (?, ?, ?, ?)";
        $stmt = $this->conn->prepare($query);
        $stmt->execute([
            $order_id,
            $this->calculateTotalAmount($checkout['cart_id']),
            $checkout['shipping_address'],
            $checkout['user_id']
        ]);
    
        return $order_id;
    }
    
    private function calculateTotalAmount($cart_id) {
        $items = $this->getCartItems($cart_id);
        $total = 0;
        foreach ($items as $item) {
            $total += $item['price'] * $item['quantity'];
        }
        return $total;
    }
    public function cancelCheckout($checkout_id) {
        $query = "UPDATE checkouts SET status = 'cancelled' WHERE checkout_id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->execute([$checkout_id]);

        return $stmt->rowCount() > 0;  
    }

}
?>
