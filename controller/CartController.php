<?php
require_once __DIR__ . '/../models/CartModel.php';

class CartController {
    private $cartModel;

    public function __construct() {
        $this->cartModel = new CartModel();
    }

    // View cart by user ID
    public function viewCart($user_id) {
        $cartItems = $this->cartModel->getCartByUserId($user_id);
        
        $cart = [
            "cart_id" => null,
            "user_id" => $user_id,
            "items" => [],
            "total_items" => 0,
            "total_price" => 0,
        ];

        foreach ($cartItems as $row) {
            $row['total'] = number_format($row['quantity'] * $row['price'], 2, '.', '');
     
            $cart['items'][] = [
                "product_id" => $row['product_id'],
                "product_name" => $row['product_name'],
                "quantity" => (int)$row['quantity'], 
                "price" => number_format((float)$row['price'], 2, '.', ''),
                "total" => $row['total']
            ];
            
            $cart['total_items'] += $row['quantity'];
            $cart['total_price'] += (float)$row['total'];
            $cart["cart_id"] = $row["cart_id"]; 
        }
    
        $cart['total_price'] = number_format($cart['total_price'], 2, '.', '');
        return $cart;
    }

    // Add item to cart
    public function addItemToCart($user_id, $product_id, $quantity) {
        $cart_id = $this->cartModel->createCartIfNotExist($user_id);
        $this->cartModel->addItemToCart($cart_id, $product_id, $quantity);

        return [
            "message" => "Cart item saved",
            "user_id" => $user_id,
            "product_id" => $product_id,
            "quantity" => $quantity
        ];
    }

    // Update item quantity in the cart
    public function updateItemQuantity($user_id, $product_id, $quantity) {
        $cart_id = $this->cartModel->getCartIdByUserId($user_id);
        if ($cart_id) {
            $rowsUpdated = $this->cartModel->updateItemQuantity($cart_id, $product_id, $quantity);
            if ($rowsUpdated > 0) {
                return $this->viewCart($user_id);
            }
        }

        return ["message" => "Product not found or quantity not updated."];
    }

    // Remove item from the cart
    public function removeItemFromCart($user_id, $product_id) {
        $cart_id = $this->cartModel->getCartIdByUserId($user_id);
        if ($cart_id) {
            $this->cartModel->removeItemFromCart($cart_id, $product_id);
            return ["message" => "Item removed from cart."];
        }
        return ["message" => "Cart not found."];
    }

    // Clear all items in the cart
    public function clearCart($user_id) {
        $cart_id = $this->cartModel->getCartIdByUserId($user_id);
        if ($cart_id) {
            $this->cartModel->clearCart($cart_id);
            return ["message" => "Cart cleared."];
        }
        return ["message" => "Cart not found."];
    }
}
?>
