<?php
require_once __DIR__ . '/../config/Database.php';

class CartModel {
    private $conn;

    public function __construct() {
        $database = new Database();
        $this->conn = $database->getConnection();
    }

    // Get cart by user ID
    public function getCartByUserId($user_id) {
        $query = "SELECT cart.cart_id, 
                         cart_item.product_id, 
                         product.product_name, 
                         SUM(cart_item.quantity) AS quantity, 
                         product.price
                  FROM cart_items AS cart_item
                  JOIN products AS product ON cart_item.product_id = product.product_id
                  JOIN (SELECT cart_id FROM carts WHERE user_id = ?) AS cart ON cart_item.cart_id = cart.cart_id
                  GROUP BY cart_item.product_id";
        
        $stmt = $this->conn->prepare($query);
        $stmt->execute([$user_id]);
        
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Create a cart if it doesn't already exist
    public function createCartIfNotExist($user_id) {
        // Check if a cart exists for the user
        $stmt = $this->conn->prepare("SELECT cart_id FROM carts WHERE user_id = ?");
        $stmt->execute([$user_id]);
        $cart = $stmt->fetch(PDO::FETCH_ASSOC);
    
        if (!$cart) {
            // Generate a unique cart_id (UUID)
            $cart_id = uniqid('', true); // You can replace this with a better UUID generation method
    
            // Insert a new cart with the generated cart_id
            $stmt = $this->conn->prepare("INSERT INTO carts (cart_id, user_id) VALUES (?, ?)");
            $stmt->execute([$cart_id, $user_id]);
            return $cart_id;
        }
        return $cart['cart_id'];
    }

    // Get cart ID by user ID
    public function getCartIdByUserId($user_id) {
        $stmt = $this->conn->prepare("SELECT cart_id FROM carts WHERE user_id = ?");
        $stmt->execute([$user_id]);
        $cart = $stmt->fetch(PDO::FETCH_ASSOC);
        
        return $cart ? $cart['cart_id'] : null;
    }

    // Add item to the cart (or update quantity if the item already exists)
    public function addItemToCart($cart_id, $product_id, $quantity) {
        $stmt = $this->conn->prepare("INSERT INTO cart_items (cart_id, product_id, quantity) 
                                      VALUES (?, ?, ?) 
                                      ON DUPLICATE KEY UPDATE quantity = quantity + ?");
        $stmt->execute([$cart_id, $product_id, $quantity, $quantity]);
    }

    // Update item quantity in the cart
    public function updateItemQuantity($cart_id, $product_id, $quantity) {
        $stmt = $this->conn->prepare("UPDATE cart_items SET quantity = ? WHERE cart_id = ? AND product_id = ?");
        $stmt->execute([$quantity, $cart_id, $product_id]);
        return $stmt->rowCount();
    }

    // Remove item from the cart
    public function removeItemFromCart($cart_id, $product_id) {
        $stmt = $this->conn->prepare("DELETE FROM cart_items WHERE cart_id = ? AND product_id = ?");
        $stmt->execute([$cart_id, $product_id]);
        return $stmt->rowCount();
    }

    // Clear all items in the cart
    public function clearCart($cart_id) {
        $stmt = $this->conn->prepare("DELETE FROM cart_items WHERE cart_id = ?");
        $stmt->execute([$cart_id]);
    }
}
?>
