<?php
require_once __DIR__ . '/../config/Database.php';
use \Firebase\JWT\JWT;
use \Firebase\JWT\Key;
use Dotenv\Dotenv;

class UserModel {
    private $conn;
    private $table = 'users';

    public function __construct() {
        $database = new Database();
        $this->conn = $database->getConnection();
    }

    // Sign up user (Create a new user)
    public function signUp($first_name, $last_name, $email, $password, $phone_num, $address, $lang_profile, $role_id) {
        // Hash the password
        $hashed_password = password_hash($password, PASSWORD_BCRYPT);

        $query = "INSERT INTO " . $this->table . " (first_name, last_name, email, password, phone_num, address, lang_profile, role_id)
                  VALUES (:first_name, :last_name, :email, :password, :phone_num, :address, :lang_profile, :role_id)";

        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':first_name', $first_name);
        $stmt->bindParam(':last_name', $last_name);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':password', $hashed_password);
        $stmt->bindParam(':phone_num', $phone_num);
        $stmt->bindParam(':address', $address);
        $stmt->bindParam(':lang_profile', $lang_profile);
        $stmt->bindParam(':role_id', $role_id);

        if ($stmt->execute()) {
            return ['message' => 'User registered successfully'];
        }
        return ['message' => 'Error registering user'];
    }

    // Log in user (Validate credentials and generate token)
    public function login($email, $password) {
        $query = "SELECT * FROM " . $this->table . " WHERE email = :email";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':email', $email);
        $stmt->execute();

        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user && password_verify($password, $user['password'])) {
            // Load environment variables
            $dotenv = Dotenv::createImmutable(__DIR__ . '/../');
            $dotenv->load();

            // Generate JWT token
            $key = $_ENV['JWT_SECRET'];  // Use the secret from .env
            $issued_at = time();
            $expiration_time = $issued_at + (2 * 24 * 60 * 60);   // 2 days expiration time
            $payload = [
                'user_id' => $user['user_id'],
                'email' => $user['email'],
                'exp' => $expiration_time
            ];
            $jwt = JWT::encode($payload, $key, 'HS256');
            return ['message' => 'Login successful', 'token' => $jwt];
        }
        return ['message' => 'Invalid email or password'];
    }
}
?>
