-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 06 Nis 2021, 16:22:45
-- Sunucu sürümü: 10.4.14-MariaDB
-- PHP Sürümü: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `satıs`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `companies`
--

CREATE TABLE `companies` (
  `company_id` int(11) NOT NULL,
  `phone` bigint(20) NOT NULL,
  `company_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `companies`
--

INSERT INTO `companies` (`company_id`, `phone`, `company_name`) VALUES
(1, 5555555555, 'Company A'),
(2, 5555555554, 'Company B'),
(3, 5555555556, 'Company C'),
(4, 5555555559, 'Company D');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `customers`
--

INSERT INTO `customers` (`customer_id`, `name`, `email`) VALUES
(1, 'Ali Tekin', 'ali@yandex.com'),
(2, 'Tekin Ali', 'tekin@yandex.com'),
(3, 'Matthew K. Atwood', ' MatthewKAtwood@rhyta.com'),
(4, 'Shane W. Barnes', 'ShaneWBarnes@dayrep.com'),
(5, 'Mary D. Swanson', 'MaryDSwanson@armyspy.com'),
(6, 'Amanda S. Harwood', 'AmandaSHarwood@rhyta.com'),
(7, 'Sue K. Dick', 'SueKDick@teleworm.us'),
(8, 'Craig D. Ries', 'CraigDRies@rhyta.com'),
(9, 'Trevor J. Pate', 'TrevorJPate@armyspy.com'),
(10, 'Sarah J. Rodrigues', 'SarahJRodrigues@rhyta.com');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `items`
--

CREATE TABLE `items` (
  `item_code` int(11) NOT NULL,
  `item` varchar(50) NOT NULL,
  `item_price` int(11) NOT NULL,
  `company_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `items`
--

INSERT INTO `items` (`item_code`, `item`, `item_price`, `company_id`) VALUES
(1, 'Desk', 480, 1),
(2, 'Lamb', 500, 1),
(3, 'Pencil', 64, 2),
(4, 'Perfume', 100, 3),
(5, 'Cotton', 1560, 2),
(6, 'Book', 75, 3),
(7, 'Milk', 8, 4),
(8, 'Juice', 14, 4),
(9, 'Cheese', 46, 4),
(10, 'Piano', 12254, 3);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `sales`
--

CREATE TABLE `sales` (
  `purchase_number` int(11) NOT NULL,
  `date_of_purchase` date NOT NULL,
  `customer_id` int(11) NOT NULL,
  `item_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `sales`
--

INSERT INTO `sales` (`purchase_number`, `date_of_purchase`, `customer_id`, `item_code`) VALUES
(1, '2021-04-01', 1, 1),
(2, '2021-04-13', 3, 3),
(3, '2021-04-01', 3, 3),
(4, '2021-05-13', 7, 10),
(5, '2021-04-04', 9, 5),
(6, '2021-05-24', 3, 2),
(7, '2020-12-15', 8, 7),
(8, '2020-03-17', 1, 7),
(9, '2018-12-04', 9, 8),
(10, '2020-07-01', 3, 4);

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`company_id`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Tablo için indeksler `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Tablo için indeksler `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`item_code`),
  ADD KEY `company_id` (`company_id`);

--
-- Tablo için indeksler `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`purchase_number`),
  ADD KEY `customer_id` (`customer_id`,`item_code`),
  ADD KEY `item_code` (`item_code`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `sales`
--
ALTER TABLE `sales`
  MODIFY `purchase_number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`);

--
-- Tablo kısıtlamaları `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`item_code`) REFERENCES `items` (`item_code`),
  ADD CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
