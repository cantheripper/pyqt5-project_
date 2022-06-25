-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 20 Haz 2022, 20:18:54
-- Sunucu sürümü: 10.4.24-MariaDB
-- PHP Sürümü: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `kutuphane`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kitap`
--

CREATE TABLE `kitap` (
  `Id` int(11) NOT NULL,
  `adi` varchar(100) COLLATE utf8mb4_turkish_ci NOT NULL,
  `yazar` varchar(100) COLLATE utf8mb4_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `kitap`
--

INSERT INTO `kitap` (`Id`, `adi`, `yazar`) VALUES
(2, 'a', 'a');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kullanici`
--

CREATE TABLE `kullanici` (
  `Id` int(11) NOT NULL,
  `k_adi` varchar(100) NOT NULL,
  `sifre` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `kullanici`
--

INSERT INTO `kullanici` (`Id`, `k_adi`, `sifre`) VALUES
(1, 'yazilim', 'vektorel16');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `odunc`
--

CREATE TABLE `odunc` (
  `Id` int(11) NOT NULL,
  `kitap_Id` int(11) NOT NULL,
  `ogrenci_Id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ogrenci`
--

CREATE TABLE `ogrenci` (
  `Id` int(11) NOT NULL,
  `adi` varchar(100) COLLATE utf8mb4_turkish_ci NOT NULL,
  `soyadi` varchar(100) COLLATE utf8mb4_turkish_ci NOT NULL,
  `sehir_Id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `ogrenci`
--

INSERT INTO `ogrenci` (`Id`, `adi`, `soyadi`, `sehir_Id`) VALUES
(1, 'can', 'can', 1),
(2, 'james', 'hetfield', 1),
(3, 'james ', 'hetfield', 1);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `sehir`
--

CREATE TABLE `sehir` (
  `Id` int(11) NOT NULL,
  `adi` varchar(100) COLLATE utf8mb4_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `sehir`
--

INSERT INTO `sehir` (`Id`, `adi`) VALUES
(1, 'Ankara\r\n'),
(2, 'Aydın'),
(3, 'Malatya'),
(4, 'çankırı'),
(5, 'elazığ'),
(6, 'sivas');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `kitap`
--
ALTER TABLE `kitap`
  ADD PRIMARY KEY (`Id`);

--
-- Tablo için indeksler `kullanici`
--
ALTER TABLE `kullanici`
  ADD PRIMARY KEY (`Id`);

--
-- Tablo için indeksler `odunc`
--
ALTER TABLE `odunc`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `kitap_Id` (`kitap_Id`,`ogrenci_Id`),
  ADD KEY `ogrenci_Id` (`ogrenci_Id`);

--
-- Tablo için indeksler `ogrenci`
--
ALTER TABLE `ogrenci`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `sehir_Id` (`sehir_Id`);

--
-- Tablo için indeksler `sehir`
--
ALTER TABLE `sehir`
  ADD PRIMARY KEY (`Id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `kitap`
--
ALTER TABLE `kitap`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tablo için AUTO_INCREMENT değeri `kullanici`
--
ALTER TABLE `kullanici`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `odunc`
--
ALTER TABLE `odunc`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `ogrenci`
--
ALTER TABLE `ogrenci`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `sehir`
--
ALTER TABLE `sehir`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `odunc`
--
ALTER TABLE `odunc`
  ADD CONSTRAINT `odunc_ibfk_1` FOREIGN KEY (`ogrenci_Id`) REFERENCES `ogrenci` (`Id`),
  ADD CONSTRAINT `odunc_ibfk_2` FOREIGN KEY (`kitap_Id`) REFERENCES `kitap` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `ogrenci`
--
ALTER TABLE `ogrenci`
  ADD CONSTRAINT `ogrenci_ibfk_1` FOREIGN KEY (`sehir_Id`) REFERENCES `sehir` (`Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
