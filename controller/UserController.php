<?php
require_once __DIR__ . '/../models/UserModel.php';

class UserController {
    private $userModel;

    public function __construct() {
        $this->userModel = new UserModel();
    }

    // Sign-up user (Create new user)
    public function signUp($data) {
        return $this->userModel->signUp(
            $data['first_name'],
            $data['last_name'],
            $data['email'],
            $data['password'],
            $data['phone_num'],
            $data['address'],
            $data['lang_profile'],
            $data['role_id']
        );
    }

    // Log in user (Generate JWT token)
    public function login($data) {
        return $this->userModel->login($data['email'], $data['password']);
    }
}
?>
