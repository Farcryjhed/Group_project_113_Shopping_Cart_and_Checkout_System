-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 23, 2024 at 04:18 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `it113`
--

-- --------------------------------------------------------

--
-- Table structure for table `cancel_orders`
--

CREATE TABLE `cancel_orders` (
  `cancel_order_id` int(11) NOT NULL,
  `order_id` char(36) DEFAULT NULL,
  `reason` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cancel_orders`
--

INSERT INTO `cancel_orders` (`cancel_order_id`, `order_id`, `reason`) VALUES
(3, 'f48e705d-7efe-11ef-8801-c01850599686', 'Customer changed mind'),
(4, 'f48ead79-7efe-11ef-8801-c01850599686', 'Item out of stock'),
(5, 'f48eaedf-7efe-11ef-8801-c01850599686', 'Shipping delays'),
(6, 'f48eaf4c-7efe-11ef-8801-c01850599686', 'Incorrect item ordered'),
(7, 'f48eafb8-7efe-11ef-8801-c01850599686', 'Payment issues'),
(8, 'f48eb018-7efe-11ef-8801-c01850599686', 'Order placed by mistake'),
(9, 'f48eb070-7efe-11ef-8801-c01850599686', 'Found a better price'),
(10, 'f48eb0c9-7efe-11ef-8801-c01850599686', 'Dissatisfied with product details'),
(11, 'f48eb128-7efe-11ef-8801-c01850599686', 'Technical issues with checkout'),
(12, 'f48eb17f-7efe-11ef-8801-c01850599686', 'Order took too long to process');

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `cart_id` int(11) NOT NULL,
  `user_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`cart_id`, `user_id`) VALUES
(9, '689b0080-a0b7-11ef-9304-0a0027000005');

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `cart_item_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `product_id` char(36) DEFAULT NULL,
  `cart_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart_items`
--

INSERT INTO `cart_items` (`cart_item_id`, `quantity`, `product_id`, `cart_id`) VALUES
(17, 2, '3498877d-7f00-11ef-8801-c01850599686', 1),
(18, 2, '34988936-7f00-11ef-8801-c01850599686', 1),
(19, 2, '3498651b-7f00-11ef-8801-c01850599686', 1),
(20, 2, '34988899-7f00-11ef-8801-c01850599686', 1),
(21, 2, '3498897e-7f00-11ef-8801-c01850599686', 1),
(23, 2, '3498897e-7f00-11ef-8801-c01850599686', 3),
(24, 2, '3498897e-7f00-11ef-8801-c01850599686', 3),
(25, 2, '3498897e-7f00-11ef-8801-c01850599686', 4),
(26, 2, '3498897e-7f00-11ef-8801-c01850599686', 4),
(27, 1, '3498897e-7f00-11ef-8801-c01850599686', 4),
(28, 1, '3498897e-7f00-11ef-8801-c01850599686', 4),
(29, 1, '3498897e-7f00-11ef-8801-c01850599686', 4),
(34, 6, '3498651b-7f00-11ef-8801-c01850599686', 4),
(35, 5, '3498651b-7f00-11ef-8801-c01850599686', 4),
(38, 6, '3498651b-7f00-11ef-8801-c01850599686', 5),
(39, 6, '3498651b-7f00-11ef-8801-c01850599686', 5),
(40, 5, '3498886c-7f00-11ef-8801-c01850599686', 5),
(41, 5, '3498886c-7f00-11ef-8801-c01850599686', 5),
(42, 5, '3498886c-7f00-11ef-8801-c01850599686', 8),
(43, 0, '3498886c-7f00-11ef-8801-c01850599686', 9),
(44, 0, '3498886c-7f00-11ef-8801-c01850599686', 9),
(45, 0, '3498886c-7f00-11ef-8801-c01850599686', 9),
(46, 0, '3498886c-7f00-11ef-8801-c01850599686', 9),
(47, 0, '3498886c-7f00-11ef-8801-c01850599686', 9),
(48, 0, '3498886c-7f00-11ef-8801-c01850599686', 9),
(49, 0, '3498886c-7f00-11ef-8801-c01850599686', 9),
(51, 5, '349888e6-7f00-11ef-8801-c01850599686', 9),
(52, 10, '349888e6-7f00-11ef-8801-c01850599686', 9);

-- --------------------------------------------------------

--
-- Table structure for table `checkouts`
--

CREATE TABLE `checkouts` (
  `checkout_id` char(36) NOT NULL DEFAULT uuid(),
  `cart_id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `shipping_address` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `discount_code` varchar(50) DEFAULT NULL,
  `discount_value` decimal(10,2) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `status` enum('processed','cancelled','delivered') DEFAULT 'processed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `checkouts`
--

INSERT INTO `checkouts` (`checkout_id`, `cart_id`, `user_id`, `shipping_address`, `created_at`, `discount_code`, `discount_value`, `payment_method`, `status`) VALUES
('673a0fb24051c3.63029459', '00000009-f514-6dae-d8af-0c826e81aad0', '689b0080-a0b7-11ef-9304-0a0027000005', '{\"street\":\"123 Main Street\",\"city\":\"Metro City\",\"state\":\"Metro State\",\"zip_code\":\"12345\",\"country\":\"Countryland\"}', '2024-11-17 15:45:54', 'SAVE20', 20.00, 'GCash', 'cancelled'),
('673d6e385ef044.95207442', '00000009-f514-6dae-d8af-0c826e81aad0', '689b0080-a0b7-11ef-9304-0a0027000005', '{\"street\":\"123 Main Street\",\"city\":\"Metro City\",\"state\":\"Metro State\",\"zip_code\":\"12345\",\"country\":\"Countryland\"}', '2024-11-20 05:06:00', NULL, 0.00, NULL, 'processed');

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `log_id` int(11) NOT NULL,
  `action` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_id` char(36) DEFAULT NULL,
  `order_id` char(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`log_id`, `action`, `timestamp`, `user_id`, `order_id`) VALUES
(21, 'INSERT', '2024-09-30 00:03:42', 'b3653202-7efd-11ef-8801-c01850599686', 'f48e705d-7efe-11ef-8801-c01850599686'),
(22, 'UPDATE', '2024-09-30 00:03:42', 'b3653b86-7efd-11ef-8801-c01850599686', 'f48ead79-7efe-11ef-8801-c01850599686'),
(23, 'DELETE', '2024-09-30 00:03:42', 'b3653c7a-7efd-11ef-8801-c01850599686', 'f48eaedf-7efe-11ef-8801-c01850599686'),
(24, 'INSERT', '2024-09-30 00:03:42', 'b3653d11-7efd-11ef-8801-c01850599686', 'f48eaf4c-7efe-11ef-8801-c01850599686'),
(25, 'UPDATE', '2024-09-30 00:03:42', 'b3653d90-7efd-11ef-8801-c01850599686', 'f48eafb8-7efe-11ef-8801-c01850599686'),
(26, 'DELETE', '2024-09-30 00:03:42', 'b3653e16-7efd-11ef-8801-c01850599686', 'f48eb018-7efe-11ef-8801-c01850599686'),
(27, 'INSERT', '2024-09-30 00:03:42', 'b3653ecc-7efd-11ef-8801-c01850599686', 'f48eb070-7efe-11ef-8801-c01850599686'),
(28, 'UPDATE', '2024-09-30 00:03:42', 'b3659c70-7efd-11ef-8801-c01850599686', 'f48eb0c9-7efe-11ef-8801-c01850599686'),
(29, 'DELETE', '2024-09-30 00:03:42', 'b3659d8b-7efd-11ef-8801-c01850599686', 'f48eb128-7efe-11ef-8801-c01850599686'),
(30, 'INSERT', '2024-09-30 00:03:42', 'b3659e27-7efd-11ef-8801-c01850599686', 'f48eb17f-7efe-11ef-8801-c01850599686');

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `media_id` int(11) NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `product_id` char(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `media`
--

INSERT INTO `media` (`media_id`, `file_name`, `product_id`) VALUES
(1, 'image1.jpg', '3498651b-7f00-11ef-8801-c01850599686'),
(2, 'image2.jpg', '3498877d-7f00-11ef-8801-c01850599686'),
(3, 'image3.jpg', '3498886c-7f00-11ef-8801-c01850599686'),
(4, 'image4.jpg', '34988899-7f00-11ef-8801-c01850599686'),
(5, 'image5.jpg', '349888c0-7f00-11ef-8801-c01850599686'),
(6, 'image6.jpg', '349888e6-7f00-11ef-8801-c01850599686'),
(7, 'image7.jpg', '34988910-7f00-11ef-8801-c01850599686'),
(8, 'image8.jpg', '34988936-7f00-11ef-8801-c01850599686'),
(9, 'image9.jpg', '3498895c-7f00-11ef-8801-c01850599686'),
(10, 'image10.jpg', '3498897e-7f00-11ef-8801-c01850599686');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` char(36) NOT NULL DEFAULT uuid(),
  `total_amount` decimal(10,2) DEFAULT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `shipping_address` text DEFAULT NULL,
  `expected_delivery_date` date DEFAULT NULL,
  `status` enum('processed','cancelled','delivered') DEFAULT NULL,
  `user_id` char(36) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `total_amount`, `order_date`, `shipping_address`, `expected_delivery_date`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
('127e9991-a4f4-11ef-a7da-0a0027000005', NULL, '2024-11-17 14:56:06', 'null', NULL, 'processed', '689b0080-a0b7-11ef-9304-0a0027000005', '2024-11-17 14:56:06', '2024-11-17 14:56:06'),
('2512801c-a3d1-11ef-9e47-0a0027000005', NULL, '2024-11-16 04:13:33', 'null', NULL, 'processed', '689b0080-a0b7-11ef-9304-0a0027000005', '2024-11-16 04:13:33', '2024-11-16 04:13:33'),
('673a0bedbc5df5.61727668', 0.00, '2024-11-17 15:29:49', '{\"street\":\"123 Main Street\",\"city\":\"Metro City\",\"state\":\"Metro State\",\"zip_code\":\"12345\",\"country\":\"Countryland\"}', NULL, 'processed', '689b0080-a0b7-11ef-9304-0a0027000005', '2024-11-17 15:29:49', '2024-11-17 15:29:49'),
('673a8a03ae4f59.59724407', 579.71, '2024-11-18 00:27:47', '{\"street\":\"123 Main Street\",\"city\":\"Metro City\",\"state\":\"Metro State\",\"zip_code\":\"12345\",\"country\":\"Countryland\"}', '2024-10-05', 'processed', '689b0080-a0b7-11ef-9304-0a0027000005', '2024-11-18 00:27:47', '2024-11-19 15:35:14'),
('673d6eca07c678.04458620', 1054.51, '2024-11-20 05:08:26', '{\"street\":\"123 Main Street\",\"city\":\"Metro City\",\"state\":\"Metro State\",\"zip_code\":\"12345\",\"country\":\"Countryland\"}', NULL, NULL, '689b0080-a0b7-11ef-9304-0a0027000005', '2024-11-20 05:08:26', '2024-11-20 05:08:26'),
('673d6ee0a24201.23005102', 1054.51, '2024-11-20 05:08:48', '{\"street\":\"123 Main Street\",\"city\":\"Metro City\",\"state\":\"Metro State\",\"zip_code\":\"12345\",\"country\":\"Countryland\"}', NULL, NULL, '689b0080-a0b7-11ef-9304-0a0027000005', '2024-11-20 05:08:48', '2024-11-20 05:08:48'),
('673d6ef86edf65.36666771', 1054.51, '2024-11-20 05:09:12', '{\"street\":\"123 Main Street\",\"city\":\"Metro City\",\"state\":\"Metro State\",\"zip_code\":\"12345\",\"country\":\"Countryland\"}', NULL, NULL, '689b0080-a0b7-11ef-9304-0a0027000005', '2024-11-20 05:09:12', '2024-11-20 05:09:12'),
('673d6f07213f49.16721993', 1054.51, '2024-11-20 05:09:27', '{\"street\":\"123 Main Street\",\"city\":\"Metro City\",\"state\":\"Metro State\",\"zip_code\":\"12345\",\"country\":\"Countryland\"}', NULL, NULL, '689b0080-a0b7-11ef-9304-0a0027000005', '2024-11-20 05:09:27', '2024-11-20 05:09:27'),
('c599c3d0-a4f5-11ef-a7da-0a0027000005', NULL, '2024-11-17 15:08:16', 'null', NULL, 'processed', '689b0080-a0b7-11ef-9304-0a0027000005', '2024-11-17 15:08:16', '2024-11-17 15:08:16'),
('f48e705d-7efe-11ef-8801-c01850599686', 100.50, '2024-09-29 23:38:16', '123 Main St, City A', '2024-10-05', 'processed', 'b3653202-7efd-11ef-8801-c01850599686', '2024-09-29 23:38:16', '2024-09-29 23:38:16'),
('f48ead79-7efe-11ef-8801-c01850599686', 200.00, '2024-09-29 23:38:16', '456 Elm St, City B', '2024-10-06', 'delivered', 'b3653b86-7efd-11ef-8801-c01850599686', '2024-09-29 23:38:16', '2024-09-29 23:38:16'),
('f48eaedf-7efe-11ef-8801-c01850599686', 150.75, '2024-09-29 23:38:16', '789 Pine St, City C', '2024-10-07', 'cancelled', 'b3653c7a-7efd-11ef-8801-c01850599686', '2024-09-29 23:38:16', '2024-09-29 23:38:16'),
('f48eaf4c-7efe-11ef-8801-c01850599686', 300.00, '2024-09-29 23:38:16', '101 Maple St, City D', '2024-10-08', 'processed', 'b3653d11-7efd-11ef-8801-c01850599686', '2024-09-29 23:38:16', '2024-09-29 23:38:16'),
('f48eafb8-7efe-11ef-8801-c01850599686', 250.25, '2024-09-29 23:38:16', '202 Oak St, City E', '2024-10-09', 'delivered', 'b3653d90-7efd-11ef-8801-c01850599686', '2024-09-29 23:38:16', '2024-09-29 23:38:16'),
('f48eb018-7efe-11ef-8801-c01850599686', 400.00, '2024-09-29 23:38:16', '303 Birch St, City F', '2024-10-10', 'processed', 'b3653e16-7efd-11ef-8801-c01850599686', '2024-09-29 23:38:16', '2024-09-29 23:38:16'),
('f48eb070-7efe-11ef-8801-c01850599686', 175.50, '2024-09-29 23:38:16', '404 Cedar St, City G', '2024-10-11', 'cancelled', 'b3653ecc-7efd-11ef-8801-c01850599686', '2024-09-29 23:38:16', '2024-09-29 23:38:16'),
('f48eb0c9-7efe-11ef-8801-c01850599686', 90.00, '2024-09-29 23:38:16', '505 Willow St, City H', '2024-10-12', 'delivered', 'b3659c70-7efd-11ef-8801-c01850599686', '2024-09-29 23:38:16', '2024-09-29 23:38:16'),
('f48eb128-7efe-11ef-8801-c01850599686', 120.00, '2024-09-29 23:38:16', '606 Cherry St, City I', '2024-10-13', 'processed', 'b3659d8b-7efd-11ef-8801-c01850599686', '2024-09-29 23:38:16', '2024-09-29 23:38:16'),
('f48eb17f-7efe-11ef-8801-c01850599686', 250.50, '2024-09-29 23:38:16', '707 Walnut St, City J', '2024-10-14', 'delivered', 'b3659e27-7efd-11ef-8801-c01850599686', '2024-09-29 23:38:16', '2024-09-29 23:38:16');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `product_id` char(36) DEFAULT NULL,
  `order_id` char(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `quantity`, `price`, `product_id`, `order_id`) VALUES
(1, 2, 29.99, '3498651b-7f00-11ef-8801-c01850599686', 'f48e705d-7efe-11ef-8801-c01850599686'),
(2, 1, 19.99, '3498877d-7f00-11ef-8801-c01850599686', 'f48ead79-7efe-11ef-8801-c01850599686'),
(3, 3, 39.99, '3498886c-7f00-11ef-8801-c01850599686', 'f48eaedf-7efe-11ef-8801-c01850599686'),
(4, 5, 15.99, '34988899-7f00-11ef-8801-c01850599686', 'f48eaf4c-7efe-11ef-8801-c01850599686'),
(5, 2, 49.99, '349888c0-7f00-11ef-8801-c01850599686', 'f48eafb8-7efe-11ef-8801-c01850599686'),
(6, 4, 25.50, '349888e6-7f00-11ef-8801-c01850599686', 'f48eb018-7efe-11ef-8801-c01850599686'),
(7, 6, 59.99, '34988910-7f00-11ef-8801-c01850599686', 'f48eb070-7efe-11ef-8801-c01850599686'),
(8, 1, 10.99, '34988936-7f00-11ef-8801-c01850599686', 'f48eb0c9-7efe-11ef-8801-c01850599686'),
(9, 3, 20.00, '3498895c-7f00-11ef-8801-c01850599686', 'f48eb128-7efe-11ef-8801-c01850599686'),
(10, 2, 15.00, '3498897e-7f00-11ef-8801-c01850599686', 'f48eb17f-7efe-11ef-8801-c01850599686');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `mode` enum('credit','debit','COD','GCash') DEFAULT NULL,
  `status` enum('paid','to pay') DEFAULT NULL,
  `order_id` char(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `payment_date`, `mode`, `status`, `order_id`) VALUES
(1, '2024-09-30 00:08:19', 'credit', 'paid', 'f48e705d-7efe-11ef-8801-c01850599686'),
(2, '2024-09-30 00:08:19', 'debit', 'to pay', 'f48ead79-7efe-11ef-8801-c01850599686'),
(3, '2024-09-30 00:08:19', 'COD', 'paid', 'f48eaedf-7efe-11ef-8801-c01850599686'),
(4, '2024-09-30 00:08:19', 'GCash', 'paid', 'f48eaf4c-7efe-11ef-8801-c01850599686'),
(5, '2024-09-30 00:08:19', 'credit', 'to pay', 'f48eafb8-7efe-11ef-8801-c01850599686'),
(6, '2024-09-30 00:08:19', 'debit', 'paid', 'f48eb018-7efe-11ef-8801-c01850599686'),
(7, '2024-09-30 00:08:19', 'COD', 'to pay', 'f48eb070-7efe-11ef-8801-c01850599686'),
(8, '2024-09-30 00:08:19', 'GCash', 'paid', 'f48eb0c9-7efe-11ef-8801-c01850599686'),
(9, '2024-09-30 00:08:19', 'credit', 'paid', 'f48eb128-7efe-11ef-8801-c01850599686'),
(10, '2024-09-30 00:08:19', 'debit', 'to pay', 'f48eb17f-7efe-11ef-8801-c01850599686');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `permission_id` int(11) NOT NULL,
  `can_edit` tinyint(1) DEFAULT NULL,
  `can_delete` tinyint(1) DEFAULT NULL,
  `can_update` tinyint(1) DEFAULT NULL,
  `role_id` int(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`permission_id`, `can_edit`, `can_delete`, `can_update`, `role_id`) VALUES
(1, 1, 0, 1, 1),
(2, 0, 1, 0, 1),
(3, 1, 1, 1, 1),
(4, 0, 0, 0, 1),
(5, 1, 0, 1, 2),
(6, 0, 1, 0, 2),
(7, 1, 1, 0, 2),
(8, 0, 0, 1, 2),
(9, 1, 0, 0, 1),
(10, 0, 1, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` char(36) NOT NULL DEFAULT uuid(),
  `product_name` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock_quantity` int(11) DEFAULT NULL,
  `category` enum('shorts','pants','t-shirts','shoes','hats') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `description`, `price`, `stock_quantity`, `category`, `created_at`, `updated_at`) VALUES
('3498651b-7f00-11ef-8801-c01850599686', 'Comfortable Shorts', 'Lightweight shorts for summer wear.', 29.99, 50, 'shorts', '2024-09-29 23:47:13', '2024-09-29 23:47:13'),
('3498877d-7f00-11ef-8801-c01850599686', 'Classic Blue Jeans', 'Denim jeans with a classic fit.', 49.99, 100, 'pants', '2024-09-29 23:47:13', '2024-09-29 23:47:13'),
('3498886c-7f00-11ef-8801-c01850599686', 'Graphic T-Shirt', '100% cotton t-shirt with a cool graphic design.', 19.99, 75, 't-shirts', '2024-09-29 23:47:13', '2024-09-29 23:47:13'),
('34988899-7f00-11ef-8801-c01850599686', 'Running Shoes', 'Lightweight and breathable running shoes.', 89.99, 30, 'shoes', '2024-09-29 23:47:13', '2024-09-29 23:47:13'),
('349888c0-7f00-11ef-8801-c01850599686', 'Baseball Cap', 'Stylish cap for sunny days.', 15.99, 60, 'hats', '2024-09-29 23:47:13', '2024-09-29 23:47:13'),
('349888e6-7f00-11ef-8801-c01850599686', 'Cargo Shorts', 'Practical shorts with multiple pockets.', 34.99, 40, 'shorts', '2024-09-29 23:47:13', '2024-09-29 23:47:13'),
('34988910-7f00-11ef-8801-c01850599686', 'Chino Pants', 'Versatile chinos suitable for casual and formal wear.', 54.99, 80, 'pants', '2024-09-29 23:47:13', '2024-09-29 23:47:13'),
('34988936-7f00-11ef-8801-c01850599686', 'Plain White T-Shirt', 'Essential white t-shirt for any wardrobe.', 14.99, 100, 't-shirts', '2024-09-29 23:47:13', '2024-09-29 23:47:13'),
('3498895c-7f00-11ef-8801-c01850599686', 'Basketball Shoes', 'High-performance shoes designed for basketball.', 99.99, 25, 'shoes', '2024-09-29 23:47:13', '2024-09-29 23:47:13'),
('3498897e-7f00-11ef-8801-c01850599686', 'Sun Hat', 'Wide-brimmed hat for protection against the sun.', 24.99, 45, 'hats', '2024-09-29 23:47:13', '2024-09-29 23:47:13');

-- --------------------------------------------------------

--
-- Table structure for table `product_specs`
--

CREATE TABLE `product_specs` (
  `spec_id` int(11) NOT NULL,
  `type_of_specs` varchar(100) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `product_id` char(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_specs`
--

INSERT INTO `product_specs` (`spec_id`, `type_of_specs`, `value`, `product_id`) VALUES
(1, 'Material', '100% Cotton', '3498651b-7f00-11ef-8801-c01850599686'),
(2, 'Fit', 'Regular', '3498877d-7f00-11ef-8801-c01850599686'),
(3, 'Wash', 'Machine Washable', '3498886c-7f00-11ef-8801-c01850599686'),
(4, 'Material', 'Denim', '34988899-7f00-11ef-8801-c01850599686'),
(5, 'Length', '34 inches', '349888c0-7f00-11ef-8801-c01850599686'),
(6, 'Design', 'Graphic Print', '349888e6-7f00-11ef-8801-c01850599686'),
(7, 'Insole', 'Cushioned', '34988910-7f00-11ef-8801-c01850599686'),
(8, 'Sole', 'Rubber', '34988936-7f00-11ef-8801-c01850599686'),
(9, 'Material', 'Cotton Blend', '3498895c-7f00-11ef-8801-c01850599686'),
(10, 'Size', 'One Size', '3498897e-7f00-11ef-8801-c01850599686');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL,
  `rating` int(11) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `review_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `product_id` char(36) DEFAULT NULL,
  `user_id` char(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`review_id`, `rating`, `comment`, `review_time`, `product_id`, `user_id`) VALUES
(1, 5, 'Excellent product!', '2024-09-30 00:10:43', '3498651b-7f00-11ef-8801-c01850599686', 'b3653202-7efd-11ef-8801-c01850599686'),
(2, 4, 'Very good, I am satisfied.', '2024-09-30 00:10:43', '3498877d-7f00-11ef-8801-c01850599686', 'b3653b86-7efd-11ef-8801-c01850599686'),
(3, 3, 'Average quality, not what I expected.', '2024-09-30 00:10:43', '3498886c-7f00-11ef-8801-c01850599686', 'b3653c7a-7efd-11ef-8801-c01850599686'),
(4, 2, 'Not worth the price.', '2024-09-30 00:10:43', '34988899-7f00-11ef-8801-c01850599686', 'b3653d11-7efd-11ef-8801-c01850599686'),
(5, 1, 'Terrible product, do not buy!', '2024-09-30 00:10:43', '349888c0-7f00-11ef-8801-c01850599686', 'b3653d90-7efd-11ef-8801-c01850599686'),
(6, 5, 'Absolutely love it! Highly recommend!', '2024-09-30 00:10:43', '349888e6-7f00-11ef-8801-c01850599686', 'b3653e16-7efd-11ef-8801-c01850599686'),
(7, 4, 'Good value for money.', '2024-09-30 00:10:43', '34988910-7f00-11ef-8801-c01850599686', 'b3653ecc-7efd-11ef-8801-c01850599686'),
(8, 3, 'Decent but has some issues.', '2024-09-30 00:10:43', '34988936-7f00-11ef-8801-c01850599686', 'b3659c70-7efd-11ef-8801-c01850599686'),
(9, 2, 'Not impressed, could be better.', '2024-09-30 00:10:43', '3498895c-7f00-11ef-8801-c01850599686', 'b3659d8b-7efd-11ef-8801-c01850599686'),
(10, 1, 'Hated it! Will not purchase again.', '2024-09-30 00:10:43', '3498897e-7f00-11ef-8801-c01850599686', 'b3659e27-7efd-11ef-8801-c01850599686');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` int(20) UNSIGNED NOT NULL,
  `role_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`) VALUES
(1, 'Seller'),
(2, 'Buyer');

-- --------------------------------------------------------

--
-- Table structure for table `session_tokens`
--

CREATE TABLE `session_tokens` (
  `token_id` int(11) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `expiration` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_id` char(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `session_tokens`
--

INSERT INTO `session_tokens` (`token_id`, `token`, `expiration`, `created_at`, `user_id`) VALUES
(1, '7b2f6a2d9e4d3a16d8c0c12e7685b4aa', '2024-09-30 01:12:15', '2024-09-30 00:12:15', 'b3653202-7efd-11ef-8801-c01850599686'),
(2, '2e7a3f9c1c2d75b10f5a2f3bce1a2c67', '2024-09-30 01:12:15', '2024-09-30 00:12:15', 'b3653b86-7efd-11ef-8801-c01850599686'),
(3, '9f2c3b7d1e2b4c2f10d9e6a1e7f3a8b4', '2024-09-30 01:12:15', '2024-09-30 00:12:15', 'b3653c7a-7efd-11ef-8801-c01850599686'),
(4, 'e1f4d5b6c7a8e0a2b3c2d1f0e9b8c7d', '2024-09-30 01:12:15', '2024-09-30 00:12:15', 'b3653d11-7efd-11ef-8801-c01850599686'),
(5, '3c1a8e5f9b7a4d6e2f3c1b0e8d7f6a5', '2024-09-30 01:12:15', '2024-09-30 00:12:15', 'b3653d90-7efd-11ef-8801-c01850599686'),
(6, '5f6b9c2d7e3b8a5d1f4e0a9b3c2d6f1', '2024-09-30 01:12:15', '2024-09-30 00:12:15', 'b3653e16-7efd-11ef-8801-c01850599686'),
(7, '1e4a3f5b9c6d8e2a0b7d3f1c2a4e6f0', '2024-09-30 01:12:15', '2024-09-30 00:12:15', 'b3653ecc-7efd-11ef-8801-c01850599686'),
(8, '6b8e1f3c2d4a9e5b0a2f7c8d6e1a5f4', '2024-09-30 01:12:15', '2024-09-30 00:12:15', 'b3659c70-7efd-11ef-8801-c01850599686'),
(9, '0f2c8e1b9d7f3a4b2c6a5e1b0d3f8e6', '2024-09-30 01:12:15', '2024-09-30 00:12:15', 'b3659d8b-7efd-11ef-8801-c01850599686'),
(10, '7e1c2d4a5b8f6e9d3c1b2a0f4e7c8b3', '2024-09-30 01:12:15', '2024-09-30 00:12:15', 'b3659e27-7efd-11ef-8801-c01850599686');

-- --------------------------------------------------------

--
-- Table structure for table `shopping_cart`
--

CREATE TABLE `shopping_cart` (
  `cart_id` int(11) NOT NULL,
  `user_id` char(36) DEFAULT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shopping_cart`
--

INSERT INTO `shopping_cart` (`cart_id`, `user_id`, `created_time`) VALUES
(1, 'b3653202-7efd-11ef-8801-c01850599686', '2024-09-29 23:52:21'),
(2, 'b3653b86-7efd-11ef-8801-c01850599686', '2024-09-29 23:52:21'),
(3, 'b3653c7a-7efd-11ef-8801-c01850599686', '2024-09-29 23:52:21'),
(4, 'b3653d11-7efd-11ef-8801-c01850599686', '2024-09-29 23:52:21'),
(5, 'b3653d90-7efd-11ef-8801-c01850599686', '2024-09-29 23:52:21'),
(6, 'b3653e16-7efd-11ef-8801-c01850599686', '2024-09-29 23:52:21'),
(7, 'b3653ecc-7efd-11ef-8801-c01850599686', '2024-09-29 23:52:21'),
(8, 'b3659c70-7efd-11ef-8801-c01850599686', '2024-09-29 23:52:21'),
(9, 'b3659d8b-7efd-11ef-8801-c01850599686', '2024-09-29 23:52:21'),
(10, 'b3659e27-7efd-11ef-8801-c01850599686', '2024-09-29 23:52:21');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` char(36) NOT NULL DEFAULT uuid(),
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` text DEFAULT NULL,
  `phone_num` bigint(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `lang_profile` text DEFAULT NULL,
  `role_id` int(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `email`, `password`, `phone_num`, `address`, `lang_profile`, `role_id`, `created_at`, `updated_at`) VALUES
('689b0080-a0b7-11ef-9304-0a0027000005', 'Charity', 'Eramis', 'charity@gmail.com', '$2y$10$UsP9L1GSYtsYLqtCgfwun.2u9pTxB6j.j5QiP/OiJTUbJ/hhtbf.W', 1234567890, '123 Main St', 'English', 1, '2024-11-12 05:31:46', '2024-11-12 05:31:46'),
('b3653202-7efd-11ef-8801-c01850599686', 'John', 'Doe', 'john.doe@example.com', 'bdef3ba6503cd0d481b3e3737f770fc5b72e308f5e7eb4bdbb84b42b1bde6348', 1234567890, '123 Main St, City A', 'English', 1, '2024-09-29 23:29:17', '2024-09-29 23:29:17'),
('b3653b86-7efd-11ef-8801-c01850599686', 'Jane', 'Smith', 'jane.smith@example.com', 'c189b2d696bc8808d9657f986d7ed31ff4e1eda13dcd242960457085990dab77', 2345678901, '456 Elm St, City B', 'Spanish', 2, '2024-09-29 23:29:17', '2024-09-29 23:29:17'),
('b3653c7a-7efd-11ef-8801-c01850599686', 'Alice', 'Johnson', 'alice.johnson@example.com', 'fe51c93cf68600dd2895fa7dfc18a82c8f031efdad679330f2307b8d62a38b79', 3456789012, '789 Pine St, City C', 'French', 1, '2024-09-29 23:29:17', '2024-09-29 23:29:17'),
('b3653d11-7efd-11ef-8801-c01850599686', 'Bob', 'Brown', 'bob.brown@example.com', 'bdf0b47a0ea6defcc150e1f31752fc37f2c5be7f6d520ccc47699acc1e1ea806', 4567890123, '101 Maple St, City D', 'German', 2, '2024-09-29 23:29:17', '2024-09-29 23:29:17'),
('b3653d90-7efd-11ef-8801-c01850599686', 'Charlie', 'Davis', 'charlie.davis@example.com', 'fc0aa08eb53f232f03ca51562ef09983dde0d24c6aea822130cc66624ce5d8f9', 5678901234, '202 Oak St, City E', 'English', 2, '2024-09-29 23:29:17', '2024-09-29 23:29:17'),
('b3653e16-7efd-11ef-8801-c01850599686', 'David', 'Wilson', 'david.wilson@example.com', '754d44d4e2d08a7b65a234caf2ba86649a236729903fa03dfc7727f6b7b4e09a', 6789012345, '303 Birch St, City F', 'Italian', 1, '2024-09-29 23:29:17', '2024-09-29 23:29:17'),
('b3653ecc-7efd-11ef-8801-c01850599686', 'Emma', 'Moore', 'emma.moore@example.com', '63d49e6c636c114632b3b9936c6b2bc585e79211f89af15143fb15f8e0ee763f', 7890123456, '404 Cedar St, City G', 'Chinese', 2, '2024-09-29 23:29:17', '2024-09-29 23:29:17'),
('b3659c70-7efd-11ef-8801-c01850599686', 'Frank', 'Taylor', 'frank.taylor@example.com', '84f427ff782c50652e2cd91c1911cff71614230507b45d54c310593a6ac80253', 8901234567, '505 Willow St, City H', 'Japanese', 1, '2024-09-29 23:29:17', '2024-09-29 23:29:17'),
('b3659d8b-7efd-11ef-8801-c01850599686', 'Grace', 'Anderson', 'grace.anderson@example.com', '47c74a3885a554dabb0c19f427c2cffcec60897a9b5c51e7239bfead63b404ef', 9012345678, '606 Cherry St, City I', 'Korean', 1, '2024-09-29 23:29:17', '2024-09-29 23:29:17'),
('b3659e27-7efd-11ef-8801-c01850599686', 'Hank', 'Thomas', 'hank.thomas@example.com', '938da00d79bbac7b8b5ea92a63319af39559f82640d35b0b32ae8f4cf31836a2', 1123456789, '707 Walnut St, City J', 'Russian', 2, '2024-09-29 23:29:17', '2024-09-29 23:29:17');

-- --------------------------------------------------------

--
-- Table structure for table `user_verifications`
--

CREATE TABLE `user_verifications` (
  `verification_id` char(36) NOT NULL DEFAULT uuid(),
  `user_id` char(36) DEFAULT NULL,
  `verification_code` varchar(6) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_verifications`
--

INSERT INTO `user_verifications` (`verification_id`, `user_id`, `verification_code`, `created_at`, `expires_at`) VALUES
('f473d59b-7f03-11ef-8801-c01850599686', 'b3653202-7efd-11ef-8801-c01850599686', 'A3F5G9', '2024-09-30 00:14:03', '2024-09-30 00:24:03'),
('f473f9c8-7f03-11ef-8801-c01850599686', 'b3653b86-7efd-11ef-8801-c01850599686', 'K2L8P1', '2024-09-30 00:14:03', '2024-09-30 00:24:03'),
('f473fadd-7f03-11ef-8801-c01850599686', 'b3653c7a-7efd-11ef-8801-c01850599686', 'Q6R4V2', '2024-09-30 00:14:03', '2024-09-30 00:24:03'),
('f473fb2c-7f03-11ef-8801-c01850599686', 'b3653d11-7efd-11ef-8801-c01850599686', 'M1N0S8', '2024-09-30 00:14:03', '2024-09-30 00:24:03'),
('f473fb6d-7f03-11ef-8801-c01850599686', 'b3653d90-7efd-11ef-8801-c01850599686', 'J7K3H5', '2024-09-30 00:14:03', '2024-09-30 00:24:03'),
('f473fbad-7f03-11ef-8801-c01850599686', 'b3653e16-7efd-11ef-8801-c01850599686', 'B4Z2X6', '2024-09-30 00:14:03', '2024-09-30 00:24:03'),
('f473fbeb-7f03-11ef-8801-c01850599686', 'b3653ecc-7efd-11ef-8801-c01850599686', 'E9W0T3', '2024-09-30 00:14:03', '2024-09-30 00:24:03'),
('f473fc28-7f03-11ef-8801-c01850599686', 'b3659c70-7efd-11ef-8801-c01850599686', 'C8V5F1', '2024-09-30 00:14:03', '2024-09-30 00:24:03'),
('f473fc6e-7f03-11ef-8801-c01850599686', 'b3659d8b-7efd-11ef-8801-c01850599686', 'X6Y4D0', '2024-09-30 00:14:03', '2024-09-30 00:24:03'),
('f473fcab-7f03-11ef-8801-c01850599686', 'b3659e27-7efd-11ef-8801-c01850599686', 'P2L7A9', '2024-09-30 00:14:03', '2024-09-30 00:24:03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cancel_orders`
--
ALTER TABLE `cancel_orders`
  ADD PRIMARY KEY (`cancel_order_id`),
  ADD KEY `fk_cancel_orders_order` (`order_id`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`cart_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`cart_item_id`);

--
-- Indexes for table `checkouts`
--
ALTER TABLE `checkouts`
  ADD PRIMARY KEY (`checkout_id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `fk_logs_user` (`user_id`),
  ADD KEY `fk_logs_order` (`order_id`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`media_id`),
  ADD KEY `fk_media_product` (`product_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `fk_orders_user` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `fk_order_items_product` (`product_id`),
  ADD KEY `fk_order_items_order` (`order_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `fk_payments_order` (`order_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`permission_id`),
  ADD KEY `fk_permissions_role` (`role_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `product_specs`
--
ALTER TABLE `product_specs`
  ADD PRIMARY KEY (`spec_id`),
  ADD KEY `fk_product_specs_product` (`product_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `fk_reviews_product` (`product_id`),
  ADD KEY `fk_reviews_user` (`user_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `session_tokens`
--
ALTER TABLE `session_tokens`
  ADD PRIMARY KEY (`token_id`),
  ADD KEY `fk_session_tokens_user` (`user_id`);

--
-- Indexes for table `shopping_cart`
--
ALTER TABLE `shopping_cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `fk_shopping_cart_user` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fk_users_role` (`role_id`);

--
-- Indexes for table `user_verifications`
--
ALTER TABLE `user_verifications`
  ADD PRIMARY KEY (`verification_id`),
  ADD KEY `fk_user_verifications_user` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cancel_orders`
--
ALTER TABLE `cancel_orders`
  MODIFY `cancel_order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `cart_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `media_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `permission_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `product_specs`
--
ALTER TABLE `product_specs`
  MODIFY `spec_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `session_tokens`
--
ALTER TABLE `session_tokens`
  MODIFY `token_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `shopping_cart`
--
ALTER TABLE `shopping_cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cancel_orders`
--
ALTER TABLE `cancel_orders`
  ADD CONSTRAINT `fk_cancel_orders_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `logs`
--
ALTER TABLE `logs`
  ADD CONSTRAINT `fk_logs_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `fk_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `media`
--
ALTER TABLE `media`
  ADD CONSTRAINT `fk_media_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `fk_order_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payments_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `permissions`
--
ALTER TABLE `permissions`
  ADD CONSTRAINT `fk_permissions_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`);

--
-- Constraints for table `product_specs`
--
ALTER TABLE `product_specs`
  ADD CONSTRAINT `fk_product_specs_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `fk_reviews_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `fk_reviews_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `session_tokens`
--
ALTER TABLE `session_tokens`
  ADD CONSTRAINT `fk_session_tokens_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `shopping_cart`
--
ALTER TABLE `shopping_cart`
  ADD CONSTRAINT `fk_shopping_cart_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`);

--
-- Constraints for table `user_verifications`
--
ALTER TABLE `user_verifications`
  ADD CONSTRAINT `fk_user_verifications_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
