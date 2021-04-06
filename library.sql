-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 06 Nis 2021, 15:07:26
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
-- Veritabanı: `library`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kategori`
--

CREATE TABLE `kategori` (
  `kategori_id` int(11) NOT NULL,
  `kategori_isim` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kitaplar`
--

CREATE TABLE `kitaplar` (
  `kitap_id` int(11) NOT NULL,
  `kitapismi` varchar(50) NOT NULL,
  `tur` varchar(50) NOT NULL,
  `yıl` date NOT NULL,
  `fiyat` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `kitaplar`
--

INSERT INTO `kitaplar` (`kitap_id`, `kitapismi`, `tur`, `yıl`, `fiyat`) VALUES
(12, 'Fareler ve İnsanlar', 'Dünya Klasikleri', '2018-08-23', 24),
(13, 'Körlük', 'Dünya Klasikleri', '2019-10-22', 36),
(14, 'Cesur Yeni Dünya', 'Dünya Klasikleri', '2016-08-06', 18),
(15, 'Fahrenheit 451', 'Roman', '2019-06-08', 26),
(16, 'Hayvan Çiftliği', 'Dünya Klasikleri', '2011-02-09', 8),
(17, 'Sineklerin Tanrısı', 'Dünya Klasikleri', '2019-04-14', 12),
(18, 'Simyacı', 'Dünya Klasikleri', '2018-10-01', 16),
(19, 'Kızıl Veba', 'Dünya Klasikleri', '2020-04-07', 8),
(20, 'Ben,Kirke', 'Roman', '2020-07-07', 84),
(21, 'Akhilleus’un Şarkısı', 'Roman', '2020-05-08', 120),
(22, 'Zeytindağı', 'Hikaye', '2019-04-14', 12),
(23, 'Küllerin Günü', 'Roman', '2018-08-09', 64),
(25, 'Göğe Bakma Durağı', 'Şiir', '1984-04-12', 18),
(26, 'Altıncı Koğuş', 'Hikaye', '2019-04-14', 24),
(27, 'Satranç', 'Hikaye', '2016-01-06', 6),
(28, 'Doğu Ekspresinde Cinayet', 'Roman', '2004-08-08', 19),
(29, 'Uğultu Tepeler', 'Roman', '2018-04-13', 100),
(30, 'Dönüşüm', 'Roman', '2016-07-01', 48);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kitaplar_kategoriler`
--

CREATE TABLE `kitaplar_kategoriler` (
  `kitap_id` int(11) NOT NULL,
  `kategori_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kitaplar_yazarlar`
--

CREATE TABLE `kitaplar_yazarlar` (
  `kitap_id` int(11) NOT NULL,
  `yazar_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `kitaplar_yazarlar`
--

INSERT INTO `kitaplar_yazarlar` (`kitap_id`, `yazar_id`) VALUES
(19, 19);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kutuphane`
--

CREATE TABLE `kutuphane` (
  `kutuphane_id` int(11) NOT NULL,
  `adres` varchar(50) NOT NULL,
  `telefon` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `kutuphane`
--

INSERT INTO `kutuphane` (`kutuphane_id`, `adres`, `telefon`) VALUES
(1, 'AAAA', '444');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kutuphane_kitaplar`
--

CREATE TABLE `kutuphane_kitaplar` (
  `kutuphane_id` int(11) NOT NULL,
  `kitap_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `kutuphane_kitaplar`
--

INSERT INTO `kutuphane_kitaplar` (`kutuphane_id`, `kitap_id`) VALUES
(1, 12),
(1, 13);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kutuphane_uyeler`
--

CREATE TABLE `kutuphane_uyeler` (
  `kutuphane_id` int(11) NOT NULL,
  `uye_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `uyeler`
--

CREATE TABLE `uyeler` (
  `uye_id` int(11) NOT NULL,
  `ad` varchar(50) NOT NULL,
  `dogumtarihi` date NOT NULL,
  `cinsiyet` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yazarlar`
--

CREATE TABLE `yazarlar` (
  `yazar_id` int(11) NOT NULL,
  `yazarisim` varchar(50) NOT NULL,
  `dogumtarihi` date NOT NULL,
  `cinsiyet` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `yazarlar`
--

INSERT INTO `yazarlar` (`yazar_id`, `yazarisim`, `dogumtarihi`, `cinsiyet`) VALUES
(12, 'John Steinbeck', '2016-11-09', 'Erkek'),
(13, 'Jose Saramago', '1955-10-04', 'Erkek'),
(14, 'Aldous Huxley ', '1987-05-15', 'Erkek'),
(15, 'Ray Bradbury', '1990-06-14', 'Erkek'),
(17, 'William Golding', '1945-07-22', 'Erkek'),
(18, 'Paulo Coelho', '1959-04-20', 'Erkek'),
(19, 'Jack London', '1932-04-07', 'Erkek'),
(20, 'Madeline Miller', '1996-02-04', 'Kadın'),
(21, 'Madeline Miller', '1996-02-04', 'Kadın'),
(22, 'Falih Rıfkı Atay', '1926-04-05', 'Erkek'),
(23, 'Jean Christophe Grange', '1975-08-09', 'Erkek'),
(25, 'Turgut Uyar', '1950-08-10', 'Erkek'),
(26, 'Anton Çehov', '1884-06-23', 'Erkek'),
(27, 'Stefan Zweig', '1894-06-23', 'Erkek'),
(28, 'Agatha Christie ', '1905-06-19', 'Kadın'),
(29, 'Emily Bronte', '1818-11-14', ''),
(30, 'Franz Kafka', '1902-06-06', 'Erkek');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`kategori_id`);

--
-- Tablo için indeksler `kitaplar`
--
ALTER TABLE `kitaplar`
  ADD PRIMARY KEY (`kitap_id`);

--
-- Tablo için indeksler `kitaplar_kategoriler`
--
ALTER TABLE `kitaplar_kategoriler`
  ADD PRIMARY KEY (`kitap_id`,`kategori_id`),
  ADD KEY `kategori_id` (`kategori_id`);

--
-- Tablo için indeksler `kitaplar_yazarlar`
--
ALTER TABLE `kitaplar_yazarlar`
  ADD PRIMARY KEY (`kitap_id`,`yazar_id`),
  ADD KEY `yazar_id` (`yazar_id`);

--
-- Tablo için indeksler `kutuphane`
--
ALTER TABLE `kutuphane`
  ADD PRIMARY KEY (`kutuphane_id`);

--
-- Tablo için indeksler `kutuphane_kitaplar`
--
ALTER TABLE `kutuphane_kitaplar`
  ADD PRIMARY KEY (`kutuphane_id`,`kitap_id`),
  ADD KEY `kitap_id` (`kitap_id`);

--
-- Tablo için indeksler `kutuphane_uyeler`
--
ALTER TABLE `kutuphane_uyeler`
  ADD PRIMARY KEY (`kutuphane_id`,`uye_id`),
  ADD KEY `uye_id` (`uye_id`);

--
-- Tablo için indeksler `uyeler`
--
ALTER TABLE `uyeler`
  ADD PRIMARY KEY (`uye_id`);

--
-- Tablo için indeksler `yazarlar`
--
ALTER TABLE `yazarlar`
  ADD PRIMARY KEY (`yazar_id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `kategori`
--
ALTER TABLE `kategori`
  MODIFY `kategori_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `kitaplar`
--
ALTER TABLE `kitaplar`
  MODIFY `kitap_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- Tablo için AUTO_INCREMENT değeri `kutuphane`
--
ALTER TABLE `kutuphane`
  MODIFY `kutuphane_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `uyeler`
--
ALTER TABLE `uyeler`
  MODIFY `uye_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `yazarlar`
--
ALTER TABLE `yazarlar`
  MODIFY `yazar_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `kitaplar_kategoriler`
--
ALTER TABLE `kitaplar_kategoriler`
  ADD CONSTRAINT `kitaplar_kategoriler_ibfk_1` FOREIGN KEY (`kategori_id`) REFERENCES `kategori` (`kategori_id`),
  ADD CONSTRAINT `kitaplar_kategoriler_ibfk_2` FOREIGN KEY (`kitap_id`) REFERENCES `kitaplar` (`kitap_id`);

--
-- Tablo kısıtlamaları `kitaplar_yazarlar`
--
ALTER TABLE `kitaplar_yazarlar`
  ADD CONSTRAINT `kitaplar_yazarlar_ibfk_1` FOREIGN KEY (`kitap_id`) REFERENCES `kitaplar` (`kitap_id`),
  ADD CONSTRAINT `kitaplar_yazarlar_ibfk_2` FOREIGN KEY (`yazar_id`) REFERENCES `yazarlar` (`yazar_id`);

--
-- Tablo kısıtlamaları `kutuphane_kitaplar`
--
ALTER TABLE `kutuphane_kitaplar`
  ADD CONSTRAINT `kutuphane_kitaplar_ibfk_1` FOREIGN KEY (`kutuphane_id`) REFERENCES `kutuphane` (`kutuphane_id`),
  ADD CONSTRAINT `kutuphane_kitaplar_ibfk_2` FOREIGN KEY (`kitap_id`) REFERENCES `kitaplar` (`kitap_id`);

--
-- Tablo kısıtlamaları `kutuphane_uyeler`
--
ALTER TABLE `kutuphane_uyeler`
  ADD CONSTRAINT `kutuphane_uyeler_ibfk_1` FOREIGN KEY (`kutuphane_id`) REFERENCES `kutuphane` (`kutuphane_id`),
  ADD CONSTRAINT `kutuphane_uyeler_ibfk_2` FOREIGN KEY (`uye_id`) REFERENCES `uyeler` (`uye_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
