-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 12, 2026 at 04:35 PM
-- Server version: 11.4.10-MariaDB-cll-lve-log
-- PHP Version: 8.2.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pgsucxjmhosting_hotel_booking_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `amenities`
--

CREATE TABLE `amenities` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `icon` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `amenities`
--

INSERT INTO `amenities` (`id`, `name`, `icon`) VALUES
(1, 'Wifi miễn phí', NULL),
(2, 'Điều hòa', NULL),
(3, 'Tivi', NULL),
(4, 'Tủ lạnh', NULL),
(5, 'Bồn tắm', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `total_price` int(11) NOT NULL,
  `status` enum('pending','confirmed','cancelled','completed') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `room_id`, `check_in_date`, `check_out_date`, `total_price`, `status`, `created_at`) VALUES
(2, 2, 2, '2026-04-05', '2026-04-06', 800000, 'completed', '2026-04-05 05:19:24'),
(3, 2, 3, '2026-04-05', '2026-04-06', 1500000, 'completed', '2026-04-05 05:19:46'),
(4, 2, 10, '2026-04-08', '2026-04-09', 6950000, 'confirmed', '2026-04-08 11:35:44'),
(5, 2, 3, '2026-04-08', '2026-04-09', 900000, 'cancelled', '2026-04-08 11:58:35'),
(6, 2, 7, '2026-04-08', '2026-04-09', 400000, 'cancelled', '2026-04-08 12:13:40'),
(7, 2, 4, '2026-04-09', '2026-04-11', 3000000, 'pending', '2026-04-09 15:35:54');

-- --------------------------------------------------------

--
-- Table structure for table `booking_services`
--

CREATE TABLE `booking_services` (
  `id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT 1,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `booking_services`
--

INSERT INTO `booking_services` (`id`, `booking_id`, `service_id`, `quantity`, `price`) VALUES
(2, 4, 1, 1, 150000),
(3, 4, 2, 1, 500000),
(4, 4, 3, 1, 300000);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `payment_method` enum('cash','credit_card','bank_transfer') DEFAULT 'cash',
  `payment_status` enum('pending','success','failed') DEFAULT 'pending',
  `transaction_id` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `booking_id`, `amount`, `payment_method`, `payment_status`, `transaction_id`, `created_at`) VALUES
(1, 2, 800000, 'cash', 'pending', NULL, '2026-04-05 05:19:24'),
(2, 3, 1500000, 'cash', 'success', NULL, '2026-04-05 05:19:46'),
(3, 4, 6950000, 'bank_transfer', 'success', NULL, '2026-04-08 11:35:44'),
(4, 5, 900000, 'cash', 'pending', NULL, '2026-04-08 11:58:35'),
(5, 6, 400000, 'bank_transfer', 'pending', NULL, '2026-04-08 12:13:40'),
(6, 7, 3000000, 'cash', 'pending', NULL, '2026-04-09 15:35:54');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `user_id`, `room_id`, `rating`, `comment`, `created_at`) VALUES
(1, 2, 2, 5, 'The room was very clean and well-equipped. I was particularly impressed with the sea view from the balcony. The reception staff were enthusiastic, and the check-in process was quick. I will definitely return!', '2026-04-08 11:38:03');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` int(11) NOT NULL,
  `image_url` varchar(255) DEFAULT 'https://via.placeholder.com/300x200',
  `status` enum('available','booked') DEFAULT 'available',
  `capacity` int(11) DEFAULT 2,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `room_type` enum('standard','medium','premium') DEFAULT 'standard'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `name`, `description`, `price`, `image_url`, `status`, `capacity`, `created_at`, `room_type`) VALUES
(1, 'Phòng Standard', 'Phòng tiêu chuẩn với đầy đủ tiện nghi cơ bản, giường đôi, phù hợp cho 1-2 người.', 500000, 'https://images.unsplash.com/photo-1611892440504-42a792e24d32?w=500&auto=format&fit=crop', 'booked', 2, '2026-03-12 04:03:52', 'standard'),
(2, 'Phòng Superior', 'Không gian rộng rãi, thoáng mát, có ban công hướng phố và bồn tắm.', 800000, 'https://images.unsplash.com/photo-1566665797739-1674de7a421a?w=500&auto=format&fit=crop', 'available', 2, '2026-03-12 04:03:52', 'standard'),
(3, 'Phòng Deluxe View Biển', 'Phòng sang trọng với view nhìn thẳng ra biển tuyệt đẹp, nội thất tiện nghi.', 900000, 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=500&auto=format&fit=crop', 'available', 2, '2026-03-12 04:03:52', 'standard'),
(4, 'Phòng Suite (VIP)', 'Căn hộ khách sạn hoàng gia, có phòng khách riêng, minibar và nội thất hạng sang.', 1500000, 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=500&auto=format&fit=crop', 'booked', 2, '2026-03-12 04:03:52', 'medium'),
(6, 'Phòng VIP', 'Phòng ngắm cảnh thư giãn view biển', 1200000, 'https://ik.imagekit.io/tvlk/blog/2022/08/khach-san-view-bien-da-nang-2.jpg', 'available', 2, '2026-04-05 07:21:35', 'premium'),
(7, 'Phòng VIP Pro', 'Phòng có 2 giường nội thất sang trọng view cực đỉnh', 400000, 'https://d2e5ushqwiltxm.cloudfront.net/wp-content/uploads/sites/72/2025/09/12104206/executive-room-twin-beds-novotel-danang-premier-han-river.jpg', 'available', 2, '2026-04-05 07:24:45', 'premium'),
(8, 'Phòng VIP Promax', 'Phòng này ưu đãi đặc biệt có ban công ngắm cảnh', 2000000, 'https://khachsandep.vn/storage/files/0%200%20%20bi%20quyet%20thiet%20ke%20homestay%20dep/phong%20tong%20thong%20trong%20khach%20san/anh-bia-phong-tong-thong-trong-khach-san.jpg', 'booked', 4, '2026-04-05 07:30:21', 'premium'),
(9, 'Phòng Family', 'Phòng dành cho nhiều người', 1000000, 'https://malibumuineresort.com/Uploads/images/Phong/Family6Nguoi/p3-bn.jpg', 'available', 6, '2026-04-08 11:29:05', 'standard'),
(10, 'Phòng Bar', 'Phòng bar thư giãn', 6000000, 'https://avv.vn/image/catalog/Tin%20Tuc%20AV%20Viet%20Nam/noi%20that%20karaoke%20av%20viet%20nam/BAR-RUOU-TAY-12.jpg', 'booked', 20, '2026-04-08 11:32:00', 'premium');

-- --------------------------------------------------------

--
-- Table structure for table `room_amenities`
--

CREATE TABLE `room_amenities` (
  `room_id` int(11) NOT NULL,
  `amenity_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `room_amenities`
--

INSERT INTO `room_amenities` (`room_id`, `amenity_id`) VALUES
(7, 1),
(7, 2),
(7, 3),
(7, 4),
(7, 5);

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` int(11) NOT NULL,
  `icon` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `name`, `description`, `price`, `icon`) VALUES
(1, 'Bữa sáng', 'Bữa sáng buffet tại nhà hàng', 150000, NULL),
(2, 'Spa & Massage', 'Gói massage thư giãn 60 phút', 500000, NULL),
(3, 'Đưa đón sân bay', 'Xe đưa rước sân bay 4 chỗ', 300000, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `email`, `phone`, `created_at`) VALUES
(1, 'Thanh1311k6', '$2y$10$vjkzkdQVtq0bDWWSmdzlBeWPFhiCDaCb8av5LTzJtyHM.Qu.PtoJ6', 'admin', NULL, NULL, '2026-03-12 04:03:52'),
(2, 'Dinh Thanh', '$2y$12$3oiFXNs8YRZL.uCCueJNZelWcq03nFH2aUYDsoAPXyMAi4VWYZdEa', 'user', 'dinhthanh13112006@gmail.com', '', '2026-04-05 05:18:58'),
(3, 'conmika123', '$2y$12$wIOy2xEiA7RpOyutb8IFCOGp1JbiL6ubJbecALDsvqNhzjbJyouBS', 'user', '3conmika@gmail.com', '0837229635', '2026-04-18 15:09:42');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `amenities`
--
ALTER TABLE `amenities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `booking_services`
--
ALTER TABLE `booking_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_id` (`booking_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_amenities`
--
ALTER TABLE `room_amenities`
  ADD PRIMARY KEY (`room_id`,`amenity_id`),
  ADD KEY `amenity_id` (`amenity_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `amenities`
--
ALTER TABLE `amenities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `booking_services`
--
ALTER TABLE `booking_services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `booking_services`
--
ALTER TABLE `booking_services`
  ADD CONSTRAINT `booking_services_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `booking_services_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `room_amenities`
--
ALTER TABLE `room_amenities`
  ADD CONSTRAINT `room_amenities_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `room_amenities_ibfk_2` FOREIGN KEY (`amenity_id`) REFERENCES `amenities` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
