<?php
require_once __DIR__ . '/../vendor/autoload.php'; 
use Dotenv\Dotenv;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class AuthMiddleware {
    public static function authorize() {
        $headers = getallheaders();
        if (isset($headers['Authorization'])) {
            $token = str_replace('Bearer ', '', $headers['Authorization']);
            // Environment variables are loaded in index.php
            $key = $_ENV['JWT_SECRET'];
            try {
                $decoded = JWT::decode($token, new Key($key, 'HS256'));
                return $decoded;
            } catch (Exception $e) {
                http_response_code(401);
                echo json_encode(["message" => "Unauthorized"]);
                exit();
            }
        } else {
            http_response_code(401);
            echo json_encode(["message" => "Authorization token not found"]);
            exit();
        }
    }
}
?>
