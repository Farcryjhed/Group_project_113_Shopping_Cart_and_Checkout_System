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
    
        if (!is_array($cartItems) || empty($cartItems)) {
            return [
                "cart_id" => null,
                "user_id" => $user_id,
                "items" => [],
                "total_items" => 0,
                "total_price" => "0.00",
                "message" => "Cart is empty or not found."
            ];
        }
    
        // Assuming cartItems[0] has the cart_id if not empty
        $formattedCartId = sprintf('%08x-%04x-%04x-%04x-%012x', $cartItems[0]['cart_id'], rand(0, 65535), rand(0, 65535), rand(0, 65535), rand(0, 281474976710655));
    
        $cart = [
            "cart_id" => $formattedCartId,
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
        }
    
        $cart['total_price'] = number_format($cart['total_price'], 2, '.', '');
        return $cart;
    }
    
    // Add item to cart
    public function addItemToCart($user_id, $product_id, $quantity) {
        if ($quantity <= 0 || $quantity > 10) {
            return [
                "message" => "Quantity must be greater than 0 and not exceed 10."
            ];
        }
    
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
