-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Aug 14, 2026 at 09:59 AM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `music_app_v2`
--

-- --------------------------------------------------------

--
-- Table structure for table `albums`
--

DROP TABLE IF EXISTS `albums`;
CREATE TABLE IF NOT EXISTS `albums` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `description` text,
  `cover_url` text,
  `release_date` date DEFAULT NULL,
  `album_type` enum('Album','Single','EP','Compilation') DEFAULT 'Album',
  `copyright` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `total_tracks` int UNSIGNED DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_album_title` (`title`(250)),
  KEY `idx_album_slug` (`slug`),
  KEY `idx_album_release` (`release_date`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `albums`
--

INSERT INTO `albums` (`id`, `title`, `slug`, `description`, `cover_url`, `release_date`, `album_type`, `copyright`, `label`, `total_tracks`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Kantara: Chapter 1', 'kantara-chapter-1', 'Original Motion Picture Soundtrack of Kantara: Chapter 1', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786638621/kantara_chepter_1_ybhyai.jpg', '2025-10-11', 'Album', NULL, 'Hombale Films', 5, '2026-08-13 16:10:32', '2026-08-13 16:31:57', NULL),
(2, 'Dhurandhar', 'dhurandhar', 'Original Motion Picture Soundtrack of Dhurandhar', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786638619/Dhurandhar_lsgr1l.jpg', '2025-12-05', 'Album', NULL, 'T-Series', 5, '2026-08-13 16:10:32', '2026-08-13 16:31:47', NULL),
(3, 'Dhurandhar: The Revenge', 'dhurandhar-the-revenge', 'Original Motion Picture Soundtrack of Dhurandhar: The Revenge', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786638626/dhuraundhar_the_revenge_zhc4zx.jpg', '2026-03-19', 'Album', NULL, 'T-Series', 5, '2026-08-13 16:10:32', '2026-08-13 16:30:55', NULL),
(4, 'Peddi', 'peddi', 'Original Motion Picture Soundtrack of Peddi', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786638617/peddi_itq6l4.jpg', '2026-05-23', 'Album', NULL, 'Mythri Movie Makers', 4, '2026-08-13 16:10:32', '2026-08-14 02:24:22', NULL),
(5, 'Hellaro', 'hellaro', 'Original Motion Picture Soundtrack of Hellaro', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786638624/hellaro_th9uqz.jpg', '2019-11-08', 'EP', NULL, 'Harfanmaula Films', 4, '2026-08-13 16:10:32', '2026-08-13 16:31:23', NULL),
(6, 'Chaal Jeevi Laiye!', 'chaal-jeevi-laiye', 'Original Motion Picture Soundtrack of Chaal Jeevi Laiye!', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786638623/chal_jeevi_laiye_rjmjrd.jpg', '2019-11-01', 'EP', NULL, 'Coconut Media Box LLP', 3, '2026-08-13 16:17:44', '2026-08-14 02:23:13', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `artists`
--

DROP TABLE IF EXISTS `artists`;
CREATE TABLE IF NOT EXISTS `artists` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `bio` text,
  `country` varchar(100) DEFAULT NULL,
  `image_url` text,
  `verified` tinyint(1) DEFAULT '0',
  `monthly_listeners` bigint UNSIGNED DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_artist_name` (`name`),
  KEY `idx_artist_slug` (`slug`),
  KEY `idx_artist_verified` (`verified`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `artists`
--

INSERT INTO `artists` (`id`, `name`, `slug`, `bio`, `country`, `image_url`, `verified`, `monthly_listeners`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Arijit Singh', 'arijit-singh', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786071384/arijit_singh_yutjxh.jpg', 1, 0, '2026-08-07 03:00:47', '2026-08-07 03:00:57', NULL),
(2, 'Alka Yagnik', 'alka-yagnik', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786071384/alka_yagnik_dxrabx.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(3, 'Karan Aujla', 'karan-aujla', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108480/Karan_Aujla_mtszgw.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(4, 'Tanveer Evan', 'tanveer-evan', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108488/Tanveer_Evan_h7oack.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(5, 'Mustafa Zahid', 'mustafa-zahid', NULL, 'Pakistan', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108480/Mustafa_Zahid_hhrjyk.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(6, 'Hansraj Raghuwanshi', 'hansraj-raghuwanshi', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108484/Hansraj_Raghuwanshi_fb4pdh.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(7, 'Arudhan Batra', 'arudhan-batra', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108489/Arudhan_Batra_x04cv9.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(8, 'Kailash Kher', 'kailash-kher', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108481/Kailash_Kher_lkwwwv.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(9, 'M. G. Sreekumar', 'm-g-sreekumar', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108480/M._G._Sreekumar_q1gvar.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(10, 'Mujtaba Aziz Naza', 'mujtaba-aziz-naza', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108479/Mujtaba_Aziz_Naza_a9wfix.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(11, 'Shilpa Rao', 'shilpa-rao', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108478/Shilpa_Rao_fzayxz.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(12, 'Osman Mir', 'osman-mir', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108478/Osman_Mir_d4zl3p.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(13, 'Bhoomi Trivedi', 'bhoomi-trivedi', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108490/Bhoomi_Trivedi_mjr8fx.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(14, 'Himanshu Chauhan', 'himanshu-chauhan', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108482/Himanshu_Chauhan_fytldz.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(15, 'Shruti Pathak', 'shruti-pathak', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108488/Shruti_Pathak_msjblg.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(16, 'Vandana Gadhvi', 'vandana-gadhvi', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108492/Vandana_Gadhvi_ynvivu.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(17, 'Nisha Upadhyay', 'nisha-upadhyay', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108479/Nisha_Upadhyay_qyjrr0.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(18, 'Diljit Dosanjh', 'diljit-dosanjh', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108485/Diljit_Dosanjh_aydjre.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(19, 'Venkatesh DC', 'venkatesh-dc', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108487/Venkatesh_DC_bzlngk.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(20, 'Kavita Krishnamurti', 'kavita-krishnamurti', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108480/Kavita_Krishnamurti_w0sjb3.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(21, 'Hemlata', 'hemlata', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108483/Hemlata_mumsq3.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(22, 'Ravindra Jain', 'ravindra-jain', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108479/Ravindra_Jain_qpjvyr.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(23, 'Sanjith Hegde', 'sanjith-hegde', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108478/Sanjith_Hegde_tapxuh.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(24, 'Vijay Prakash', 'vijay-prakash', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108486/Vijay_Prakash_bfftmn.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(25, 'Aditya Gadhvi', 'aditya-gadhvi', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108486/Aditya_Gadhvi_sdn1br.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(26, 'Parthiv Gohil', 'parthiv-gohil', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108478/Parthiv_Gohil_x2exm9.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(27, 'Tanvi Sanjaliya', 'tanvi-sanjaliya', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108487/Tanvi_Sanjaliya_sx1rzm.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(28, 'Hanumankind', 'hanumankind', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108484/Hanumankind_gnujty.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(29, 'Kalmi', 'kalmi', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108480/Kalmi_ntq5u2.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(30, 'A. R. Rahman', 'a-r-rahman', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108486/A._R._Rahman_uo5bo9.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(31, 'Madhubanti Bagchi', 'madhubanti-bagchi', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108480/Madhubanti_Bagchi_s3pj4x.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(32, 'Divya Kumar', 'divya-kumar', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108485/Divya_Kumar_pv6gzw.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(33, 'Sachin-Jigar', 'sachin-jigar', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108478/Sachin-Jigar_ukqwwn.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(34, 'Badshah', 'badshah', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786071385/badshah_hyzgv7.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(35, 'Aastha Gill', 'aastha-gill', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108486/Aastha_Gill_fabfh6.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(36, 'Kinjal Dave', 'kinjal-dave', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786108480/Kinjal_Dave_fhpnz0.jpg', 1, 0, '2026-08-07 16:35:44', '2026-08-07 16:35:44', NULL),
(37, 'Altamash Faridi', 'altamash-faridi', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786426154/Altamash_Faridi_ihbchv.jpg', 1, 0, '2026-08-11 05:29:51', '2026-08-11 05:29:51', NULL),
(38, 'Harshika Devanath', 'harshika-devanath', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634798/Harshika_Devanath_m11gov.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:33:29', NULL),
(39, 'Heer', 'heer', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634794/Heer_xhvut3.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:33:41', NULL),
(40, 'Shashwat Sachdev', 'shashwat-sachdev', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634797/Shashwat_Sachdev_nz7m1k.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:33:51', NULL),
(41, 'Shahzad Ali', 'shahzad-ali', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634793/Shahzad_Ali_q3qcun.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:34:00', NULL),
(42, 'Subhadeep Das Chowdhury', 'subhadeep-das-chowdhury', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634790/Subhadeep_Das_Chowdhury_qaxtm1.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:34:12', NULL),
(43, 'Armaan Khan', 'armaan-khan', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634848/Armaan_Khan_decyab.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:34:46', NULL),
(44, 'Mohit Chauhan', 'mohit-chauhan', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634789/Mohit_Chauhan_ycvjac.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:35:09', NULL),
(45, 'Rajbha Gadhavi', 'rajbha-gadhavi', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634786/Rajbha_Gadhavi_bzfnay.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:35:18', NULL),
(46, 'Amit Trivedi', 'amit-trivedi', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634783/Amit_Trivedi_gztb2r.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:35:26', NULL),
(47, 'Nakash Aziz', 'nakash-aziz', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634851/Nakash_Aziz_nce8bl.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:35:53', NULL),
(48, 'Jigardan Gadhavi', 'jigardan-gadhavi', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634801/Jigardan_Gadhavi_mjydyb.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:36:13', NULL),
(49, 'Tanishkaa Sanghvi', 'tanishkaa-sanghvi', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634802/Tanishkaa_Sanghvi_okkece.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:36:28', NULL),
(50, 'Simran Choudhary', 'simran-choudhary', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634805/Simran_Choudhary_quavbt.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:36:37', NULL),
(51, 'Nitesh Aher', 'nitesh-aher', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634807/Nitesh_Aher_itu3kf.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:36:45', NULL),
(52, 'Jasmine Sandlas', 'jasmine-sandlas', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634810/Jasmine_Sandlas_sscjgm.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:36:59', NULL),
(53, 'Sudhir Yaduvanshi', 'sudhir-yaduvanshi', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634811/Sudhir_Yaduvanshi_cjrjcr.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:37:14', NULL),
(54, 'Mohd. Sadiq', 'mohd-sadiq', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786635724/Mohd._Sadiq_mmvinv.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:42:13', NULL),
(55, 'Ranjit Kaur', 'ranjit-kaur', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634814/Ranjit_Kaur_swufeo.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:42:40', NULL),
(56, 'Sonu Nigam', 'sonu-nigam', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634815/Sonu_Nigam_iuns9c.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:42:56', NULL),
(57, 'Reble', 'reble', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634818/Reble_na5iet.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:43:06', NULL),
(58, 'Satinder Sartaaj', 'satinder-sartaaj', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634819/Satinder_Sartaaj_aqjbd7.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:43:17', NULL),
(59, 'Sai Vignesh', 'sai-vignesh', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634822/Sai_Vignesh_mqq9cd.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:43:24', NULL),
(60, 'Keerthi Sagathia', 'keerthi-sagathia', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634823/Keerthi_Sagathia_l9ofmz.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:43:34', NULL),
(61, 'Aishwarya Majmudar', 'aishwarya-majmudar', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634826/Aishwarya_Majmudar_itpsay.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:43:44', NULL),
(62, 'Mooralala Marwada', 'mooralala-marwada', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634827/Mooralala_Marwada_qinoii.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:43:52', NULL),
(63, 'Prafull Dave', 'prafull-dave', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634830/Prafull_Dave_aqgdpl.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:44:00', NULL),
(64, 'Ishani Dave', 'ishani-dave', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634831/Ishani_Dave_a624nc.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:44:10', NULL),
(65, 'Afsana Khan', 'afsana-khan', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634834/Afsana_Khan_kawskk.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:44:21', NULL),
(66, 'Amit Kumar', 'amit-kumar', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634838/Amit_Kumar_lwzevx.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:44:29', NULL),
(67, 'Nabil El Houri', 'nabil-el-houri', NULL, 'Morocco', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634835/Nabil_El_Houri_gu2q6l.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:44:36', NULL),
(68, 'Sons of Yusuf', 'sons-of-yusuf', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634839/Sons_of_Yusuf_vt5qyt.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:44:45', NULL),
(69, 'Abby V', 'abby-v', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634842/Abby_V_y5w8b4.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:44:51', NULL),
(70, 'Navtej Singh Rehal', 'navtej-singh-rehal', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634843/Navtej_Singh_Rehal_qzuumr.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:44:59', NULL),
(71, 'Khan Saab', 'khan-saab', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634846/Khan_Saab_ytadws.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:45:05', NULL),
(72, 'Token', 'token', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634778/Token_gee0gf.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:45:23', NULL),
(73, 'Anuradha Paudwal', 'anuradha-paudwal', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634778/Anuradha_Paudwal_r87r5o.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:45:32', NULL),
(74, 'Udit Narayan', 'udit-narayan', NULL, 'India', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634782/Udit_Narayan_bpkmgh.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:45:39', NULL),
(75, 'Qveen Herby', 'qveen-herby', NULL, 'United States', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786634778/Qveen_Herby_yl0jkb.jpg', 0, 0, '2026-08-13 13:54:10', '2026-08-13 15:45:45', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `artist_follows`
--

DROP TABLE IF EXISTS `artist_follows`;
CREATE TABLE IF NOT EXISTS `artist_follows` (
  `user_id` int UNSIGNED NOT NULL,
  `artist_id` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`artist_id`),
  KEY `fk_follow_artist` (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `artist_follows`
--

INSERT INTO `artist_follows` (`user_id`, `artist_id`, `created_at`) VALUES
(1, 1, '2026-08-08 06:28:03'),
(1, 6, '2026-08-08 06:28:03'),
(1, 8, '2026-08-08 06:28:03'),
(1, 25, '2026-08-08 06:28:03'),
(1, 28, '2026-08-08 06:28:03'),
(1, 34, '2026-08-08 06:28:03'),
(1, 36, '2026-08-08 06:28:03');

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
CREATE TABLE IF NOT EXISTS `favorites` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `song_id` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_favorite` (`user_id`,`song_id`),
  KEY `fk_favorite_song` (`song_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `favorites`
--

INSERT INTO `favorites` (`id`, `user_id`, `song_id`, `created_at`) VALUES
(1, 1, 1, '2026-08-08 06:28:27'),
(2, 1, 2, '2026-08-08 06:28:27'),
(3, 1, 7, '2026-08-08 06:28:27'),
(4, 1, 11, '2026-08-08 06:28:27'),
(5, 1, 14, '2026-08-08 06:28:27'),
(6, 1, 18, '2026-08-08 06:28:27'),
(7, 1, 26, '2026-08-08 06:28:27');

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
CREATE TABLE IF NOT EXISTS `genres` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_genre_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `genres`
--

INSERT INTO `genres` (`id`, `name`, `slug`, `created_at`) VALUES
(1, 'Pop', 'pop', '2026-08-06 18:09:38'),
(2, 'Rock', 'rock', '2026-08-06 18:09:38'),
(3, 'Hip Hop', 'hip-hop', '2026-08-06 18:09:38'),
(4, 'Rap', 'rap', '2026-08-06 18:09:38'),
(5, 'R&B', 'r-and-b', '2026-08-06 18:09:38'),
(6, 'Jazz', 'jazz', '2026-08-06 18:09:38'),
(7, 'Blues', 'blues', '2026-08-06 18:09:38'),
(8, 'Classical', 'classical', '2026-08-06 18:09:38'),
(9, 'Country', 'country', '2026-08-06 18:09:38'),
(10, 'Electronic', 'electronic', '2026-08-06 18:09:38'),
(11, 'Dance', 'dance', '2026-08-06 18:09:38'),
(12, 'EDM', 'edm', '2026-08-06 18:09:38'),
(13, 'Lo-fi', 'lo-fi', '2026-08-06 18:09:38'),
(14, 'Instrumental', 'instrumental', '2026-08-06 18:09:38'),
(15, 'Folk', 'folk', '2026-08-06 18:09:38'),
(16, 'Romantic', 'romantic', '2026-08-06 18:09:38'),
(17, 'Devotional', 'devotional', '2026-08-06 18:09:38'),
(18, 'Punjabi', 'punjabi', '2026-08-06 18:09:38'),
(19, 'Hindi', 'hindi', '2026-08-06 18:09:38'),
(20, 'Tamil', 'tamil', '2026-08-06 18:09:38'),
(21, 'Telugu', 'telugu', '2026-08-06 18:09:38'),
(22, 'Malayalam', 'malayalam', '2026-08-06 18:09:38'),
(45, 'Gujarati', 'gujarati', '2026-08-08 02:11:03'),
(46, 'Bollywood', 'bollywood', '2026-08-08 02:16:47'),
(47, 'Sufi', 'sufi', '2026-08-08 02:16:47'),
(48, 'Ghazal', 'ghazal', '2026-08-08 02:16:47'),
(49, 'Bhajan', 'bhajan', '2026-08-08 02:16:47'),
(50, 'Aarti', 'aarti', '2026-08-08 02:16:47'),
(51, 'Garba', 'garba', '2026-08-08 02:16:47'),
(52, 'Patriotic', 'patriotic', '2026-08-08 02:16:47'),
(53, 'Indie', 'indie', '2026-08-08 02:16:47'),
(54, 'Alternative', 'alternative', '2026-08-08 02:16:47'),
(55, 'Metal', 'metal', '2026-08-08 02:16:47'),
(56, 'Punk', 'punk', '2026-08-08 02:16:47'),
(57, 'Reggae', 'reggae', '2026-08-08 02:16:47'),
(58, 'Soul', 'soul', '2026-08-08 02:16:47'),
(59, 'Disco', 'disco', '2026-08-08 02:16:47'),
(60, 'Funk', 'funk', '2026-08-08 02:16:47'),
(61, 'Trap', 'trap', '2026-08-08 02:16:47'),
(62, 'K-Pop', 'k-pop', '2026-08-08 02:16:47'),
(63, 'J-Pop', 'j-pop', '2026-08-08 02:16:47'),
(64, 'Latin', 'latin', '2026-08-08 02:16:47'),
(65, 'Reggaeton', 'reggaeton', '2026-08-08 02:16:47'),
(66, 'Ambient', 'ambient', '2026-08-08 02:16:47'),
(67, 'Chillout', 'chillout', '2026-08-08 02:16:47'),
(68, 'Soundtrack', 'soundtrack', '2026-08-08 02:16:47'),
(69, 'New Age', 'new-age', '2026-08-08 02:16:47'),
(70, 'Gospel', 'gospel', '2026-08-08 02:16:47'),
(71, 'Ska', 'ska', '2026-08-08 02:16:47'),
(72, 'House', 'house', '2026-08-08 02:16:47'),
(73, 'Techno', 'techno', '2026-08-08 02:16:47'),
(74, 'Trance', 'trance', '2026-08-08 02:16:47'),
(75, 'Dubstep', 'dubstep', '2026-08-08 02:16:47'),
(76, 'Drum & Bass', 'drum-and-bass', '2026-08-08 02:16:47'),
(77, 'Acoustic', 'acoustic', '2026-08-08 02:16:47'),
(78, 'Singer-Songwriter', 'singer-songwriter', '2026-08-08 02:16:47'),
(79, 'Children', 'children', '2026-08-08 02:16:47'),
(80, 'Christmas', 'christmas', '2026-08-08 02:16:47'),
(81, 'Qawwali', 'qawwali', '2026-08-08 02:16:47'),
(82, 'Bhangra', 'bhangra', '2026-08-08 02:16:47'),
(83, 'Desi Hip Hop', 'desi-hip-hop', '2026-08-08 02:16:47'),
(84, 'Indian Classical', 'indian-classical', '2026-08-08 02:16:47'),
(85, 'Indian Folk', 'indian-folk', '2026-08-08 02:16:47'),
(86, 'Indian Fusion', 'indian-fusion', '2026-08-08 02:16:47');

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
CREATE TABLE IF NOT EXISTS `history` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `song_id` int UNSIGNED NOT NULL,
  `played_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `play_duration` int UNSIGNED DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `device` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_history_user` (`user_id`),
  KEY `idx_history_song` (`song_id`),
  KEY `idx_history_played` (`played_at`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`id`, `user_id`, `song_id`, `played_at`, `play_duration`, `completed`, `device`) VALUES
(1, 1, 1, '2026-08-08 06:23:44', 250, 1, 'Android'),
(2, 1, 2, '2026-08-08 06:08:44', 180, 0, 'Android'),
(3, 1, 14, '2026-08-08 05:28:44', 195, 1, 'Android'),
(4, 1, 18, '2026-08-08 03:28:44', 210, 1, 'Web'),
(5, 1, 26, '2026-08-07 06:28:44', 190, 1, 'Android'),
(6, 1, 7, '2026-08-06 06:28:44', 180, 0, 'Web'),
(7, 1, 11, '2026-08-05 06:28:44', 240, 1, 'Android'),
(8, 1, 17, '2026-08-03 06:28:44', 200, 1, 'Android');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `type` enum('general','artist','playlist','album','system') DEFAULT 'general',
  `reference_id` int UNSIGNED DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_notification_user` (`user_id`),
  KEY `idx_notification_read` (`is_read`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `title`, `message`, `type`, `reference_id`, `is_read`, `created_at`) VALUES
(1, 1, 'New Song Added', 'Agar Tum Saath Ho is now available in your music library.', 'general', 1, 1, '2026-08-08 06:30:13'),
(2, 1, 'Artist Update', 'New music from Arijit Singh is available.', 'artist', 1, 0, '2026-08-08 06:30:13'),
(3, 1, 'Playlist Created', 'Your playlist My Favorites Mix is ready.', 'playlist', 1, 0, '2026-08-08 06:30:13'),
(4, 1, 'Welcome', 'Welcome to Music App. Start listening to your favorite songs!', 'system', NULL, 1, '2026-08-08 06:30:13');

-- --------------------------------------------------------

--
-- Table structure for table `playlists`
--

DROP TABLE IF EXISTS `playlists`;
CREATE TABLE IF NOT EXISTS `playlists` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `cover_url` text,
  `is_public` tinyint(1) DEFAULT '1',
  `total_songs` int UNSIGNED DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_playlist_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `playlists`
--

INSERT INTO `playlists` (`id`, `user_id`, `title`, `description`, `cover_url`, `is_public`, `total_songs`, `created_at`, `updated_at`) VALUES
(1, 1, 'My Updated Playlist', 'Updated description', '', 1, 6, '2026-08-08 06:29:25', '2026-08-13 16:41:48');

-- --------------------------------------------------------

--
-- Table structure for table `playlist_songs`
--

DROP TABLE IF EXISTS `playlist_songs`;
CREATE TABLE IF NOT EXISTS `playlist_songs` (
  `playlist_id` int UNSIGNED NOT NULL,
  `song_id` int UNSIGNED NOT NULL,
  `position` int UNSIGNED NOT NULL,
  `added_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`playlist_id`,`song_id`),
  UNIQUE KEY `uk_playlist_position` (`playlist_id`,`position`),
  KEY `fk_playlist_song_song` (`song_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `playlist_songs`
--

INSERT INTO `playlist_songs` (`playlist_id`, `song_id`, `position`, `added_at`) VALUES
(1, 1, 1, '2026-08-08 06:29:42'),
(1, 2, 2, '2026-08-08 06:29:42'),
(1, 7, 3, '2026-08-08 06:29:42'),
(1, 14, 4, '2026-08-08 06:29:42'),
(1, 18, 5, '2026-08-08 06:29:42'),
(1, 26, 6, '2026-08-08 06:29:42');

--
-- Triggers `playlist_songs`
--
DROP TRIGGER IF EXISTS `tr_playlist_song_delete`;
DELIMITER $$
CREATE TRIGGER `tr_playlist_song_delete` AFTER DELETE ON `playlist_songs` FOR EACH ROW BEGIN
    UPDATE playlists
    SET total_songs = GREATEST(total_songs - 1,0)
    WHERE id = OLD.playlist_id;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `tr_playlist_song_insert`;
DELIMITER $$
CREATE TRIGGER `tr_playlist_song_insert` AFTER INSERT ON `playlist_songs` FOR EACH ROW BEGIN
    UPDATE playlists
    SET total_songs = total_songs + 1
    WHERE id = NEW.playlist_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `search_history`
--

DROP TABLE IF EXISTS `search_history`;
CREATE TABLE IF NOT EXISTS `search_history` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `keyword` varchar(255) NOT NULL,
  `searched_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_search_user` (`user_id`),
  KEY `idx_keyword` (`keyword`(250)),
  KEY `idx_searched` (`searched_at`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `search_history`
--

INSERT INTO `search_history` (`id`, `user_id`, `keyword`, `searched_at`) VALUES
(1, 1, 'Arijit Singh', '2026-08-08 06:29:56'),
(2, 1, 'Agar Tum Saath Ho', '2026-08-08 06:29:56'),
(3, 1, 'Hanumankind', '2026-08-08 06:29:56'),
(4, 1, 'Big Dawgs', '2026-08-08 06:29:56'),
(5, 1, 'Gujarati', '2026-08-08 06:29:56'),
(6, 1, 'Aditya Gadhvi', '2026-08-08 06:29:56'),
(7, 1, 'Devotional', '2026-08-08 06:29:56');

-- --------------------------------------------------------

--
-- Table structure for table `songs`
--

DROP TABLE IF EXISTS `songs`;
CREATE TABLE IF NOT EXISTS `songs` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `description` text,
  `lyrics` longtext,
  `audio_url` text NOT NULL,
  `cover_url` text,
  `duration_seconds` int UNSIGNED NOT NULL,
  `language` varchar(50) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `play_count` bigint UNSIGNED DEFAULT '0',
  `like_count` bigint UNSIGNED DEFAULT '0',
  `download_count` bigint UNSIGNED DEFAULT '0',
  `is_explicit` tinyint(1) DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_song_title` (`title`(250)),
  KEY `idx_song_slug` (`slug`),
  KEY `idx_song_release` (`release_date`),
  KEY `idx_song_play_count` (`play_count`),
  KEY `idx_song_like_count` (`like_count`),
  KEY `idx_song_download_count` (`download_count`),
  KEY `idx_song_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `songs`
--

INSERT INTO `songs` (`id`, `title`, `slug`, `description`, `lyrics`, `audio_url`, `cover_url`, `duration_seconds`, `language`, `release_date`, `play_count`, `like_count`, `download_count`, `is_explicit`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Agar Tum Saath Ho', 'agar-tum-saath-ho', 'The song \"Agar Tum Saath Ho\" is from the movie Tamasha (2015), starring Ranbir Kapoor and Deepika Padukone. It is sung by Alka Yagnik and Arijit Singh, with music composed by A.R. Rahman and lyrics written by Irshad Kamil. The song expresses themes of love, longing, and the emotional depth of companionship, making it one of the most beloved tracks in Bollywood.', NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786069412/Agar-Tum-Saath-Ho-FULL-AUDIO-Son_sak9oz.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786069825/agar_tum_sath_ho_o0ztzm.jpg', 322, 'Hindi', '2015-09-15', 1, 1, 0, 0, 1, '2026-08-07 03:08:18', '2026-08-08 06:30:56', NULL),
(2, 'Channa Mereya', 'channa-mereya', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786069415/Channa-Mereya-Lyric-Video-Ae-Dil_wr3fwd.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786069910/channa_mereya_tgjuab.jpg', 325, 'Hindi', '2016-10-28', 1, 1, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-08 06:30:56', NULL),
(3, 'Humari Adhuri Kahani', 'humari-adhuri-kahani', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786069411/Arijit-Singh-Humari-Adhuri-Kahan_ykl8cn.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786069911/Hamari-Adhuri-Kahani-Hindi-2015-500x500_loomze.jpg', 325, 'Hindi', '2015-05-12', 0, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-07 17:59:17', NULL),
(4, 'Banke Hawa Mein Bezubaan', 'banke-hawa-mein-bezubaan', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786069410/Banke-Hawa-Mein-Bezubaan-Mein-Of_hto8wk.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786426491/Banke_Hawa_Mein_Bezubaan_Mein_intqtp.jpg', 202, 'Hindi', '2014-07-18', 0, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-11 05:35:51', NULL),
(5, 'Maine Royaa', 'maine-royaa', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786069406/Maine-Royaa-1_ilcjxj.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786069913/mai_royaa_ccodvv.jpg', 315, 'Hindi', '2021-01-01', 0, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-07 18:02:18', NULL),
(6, 'Bhula Dena', 'bhula-dena', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786069404/Bhula-Dena-Mujhe-Video-Song-Aash_b42zaq.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786069828/bhula_dena_muje_qmxlie.jpg', 120, 'Hindi', '2013-04-26', 0, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-07 18:01:16', NULL),
(7, 'Jai Shree Ram', 'jai-shree-ram', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786069331/Jai-Shree-Ram-Hansraj-Raghuwansh_vjlicm.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786070333/Jai-Shree-Ram-Hindi-2023-20231215230942-500x500_y93o7x.jpg', 326, 'Hindi', '2023-01-01', 1, 1, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-08 06:30:56', NULL),
(8, 'Hanuman Chalisa - Super Fast Music', 'hanuman-chalisa-super-fast-music', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786069325/Hanuman-Chalisa-Super-Fast-Music_umrrjv.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786070335/Shree-Hanuman-Chalisa-Hanuman-Ashtak-Hindi-1992-20230904173628-500x500_gsaucc.jpg', 258, 'Hindi', '2023-01-01', 0, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-07 18:02:59', NULL),
(9, 'Kaun Hain Voh', 'kaun-hain-voh', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786069325/Kaun-Hain-Voh-Full-Video-Baahuba_ehttrs.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786070334/Kaun-Hain-Voh-Full-Video-Baahuba_bhakti_song_v8d9bo.jpg', 214, 'Hindi', '2015-07-10', 0, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-07 18:04:01', NULL),
(10, 'Maa Apne Dware Bula Le Mujhe', 'maa-apne-dware-bula-le-mujhe', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786069324/Maa-Apne-Dware-Bula-Le-Mujhe-Ful_z3xd7i.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786070335/Maa-Apne-Dware-Bula-Le-Mujhe-Hindi-2024-20240923191045-500x500_srytqc.jpg', 183, 'Hindi', '2023-01-01', 0, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-07 18:04:26', NULL),
(11, 'Vishvambhari Stuti', 'vishvambhari-stuti', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786069319/Vishvambhari-Stuti-Kinjal-Dave-K_qihsus.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786109732/Vishvambhari_Stuti_qc471o.jpg', 377, 'Gujarati', '2020-01-01', 1, 1, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-08 06:30:56', NULL),
(12, 'Vande Mataram', 'vande-mataram', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786069177/vani_matram_ij5d0l.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786109732/Vande_Mataram_owkluf.jpg', 369, 'Hindi', '1997-01-01', 0, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-07 18:08:51', NULL),
(13, 'Tauba Tauba', 'tauba-tauba', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786069175/husan_tera_tuba_tuba_gjxufl.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786109733/Tauba_Tauba_kyrur4.jpg', 203, 'Hindi', '2024-06-03', 0, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-07 18:07:13', NULL),
(14, 'Big Dawgs', 'big-dawgs', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786069175/hanuman_kind_x5pjim.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786109730/Big_Dawgs_yta2bo.jpg', 210, 'English', '2024-07-09', 1, 1, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-08 06:30:56', NULL),
(15, 'O Desh Mere', 'o-desh-mere', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786069169/o_dash_mari_vh8tgw.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786109736/O_Desh_Mere_gpnaja.jpg', 183, 'Hindi', '2021-08-06', 0, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-07 18:08:19', NULL),
(16, 'DJ Waley Babu', 'dj-waley-babu', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786069165/dj_vali_babu_m2pejp.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786109730/DJ_Waley_Babu_bbqri9.jpg', 141, 'Hindi', '2015-07-17', 0, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-07 18:06:15', NULL),
(17, 'Aaj Ki Raat', 'aaj-ki-raat', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786069165/aj_ki_rat_uvvgfd.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786109731/Aaj_Ki_Raat_oyvpvo.jpg', 180, 'Hindi', '2024-07-24', 1, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-08 06:30:39', NULL),
(18, 'Ramzat - 3 Nonstop Garba 2019', 'ramzat-3-nonstop-garba-2019', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786113825/Makrane_Bethi_Mari_Mavadi_-_%E0%AA%86%E0%AA%B6_%E0%AA%AA%E0%AB%82%E0%AA%B0%E0%AB%80_%E0%AA%95%E0%AA%B0%E0%AB%87_%E0%AA%AE%E0%AA%BE%E0%AA%B0%E0%AB%80_%E0%AA%AE%E0%AA%BE%E0%AA%B5%E0%AA%A1%E0%AB%80_-_Ramzat_3_%E0%AA%B0%E0%AA%AE%E0%AA%9D%E0%AA%9F_3_Nonstop_Garba_2026_-_Osman_Mir_tu2Ru0Q5NIw_ldnkzf.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786109734/Ramzat_3_Nonstop_Garba_2019_un2tii.jpg', 124, 'Gujarati', '2019-01-01', 1, 1, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-08 06:30:56', NULL),
(19, 'Patan Na Patrani', 'patan-na-patrani', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786113998/Patan_na_Patrani_GX6ERxYtfo4_qycnhp.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786109735/Patan_Na_Patrani_nvr4vh.jpg', 259, 'Gujarati', '2022-01-01', 0, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-07 18:13:27', NULL),
(20, 'Jai Khodiyar Mata - Aarti', 'jai-khodiyar-mata-aarti', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786114039/Aarti_-_Jay_Khodiyar_Mata_%E0%AA%9C%E0%AA%AF_%E0%AA%96%E0%AB%8B%E0%AA%A1%E0%AA%BF%E0%AA%AF%E0%AA%BE%E0%AA%B0_%E0%AA%AE%E0%AA%BE%E0%AA%A4%E0%AA%BE_Singer_Nisha_Upadhyay_Music_Gaurang_Vyas_DiOZJt6YVe8_f01pu3.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786109729/Jai_Khodiyar_Mata_Aarti_qlhklb.jpg', 392, 'Gujarati', '2020-01-01', 0, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-07 18:10:09', NULL),
(21, 'Rebel', 'rebel', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786113979/Rebel_Lyrical_Song_Hindi_-_Kantara_Chapter_1_Rishab_Shetty_Diljit_Dosanjh_Hombale_Films_KlWmhyaVsSU_kyejgc.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786109734/Rebel_jb0tjf.jpg', 241, 'Hindi', '2025-09-28', 0, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-07 18:13:50', NULL),
(22, 'Karma', 'karma', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786113922/Karma_Video_Song_Hindi_-_Kantara_Chapter_1_Rishab_Shetty_Rukmini_Hombale_Films_lue4nserWek_dd6uji.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786109728/Karma_pxk0by.jpg', 246, 'Hindi', '2025-01-01', 0, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-07 18:11:48', NULL),
(23, 'Hum Katha Sunate Ram Sakal Gun Dham Ki', 'hum-katha-sunate-ram-sakal-gun-dham-ki', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786113996/%E0%A4%B9%E0%A4%AE_%E0%A4%95%E0%A4%A5%E0%A4%BE_%E0%A4%B8%E0%A5%81%E0%A4%A8%E0%A4%BE%E0%A4%A4%E0%A5%87_%E0%A4%B0%E0%A4%BE%E0%A4%AE_%E0%A4%B8%E0%A4%95%E0%A4%B2_%E0%A4%97%E0%A5%81%E0%A4%A3_%E0%A4%A7%E0%A4%BE%E0%A4%AE_%E0%A4%95%E0%A5%80_-_Hum_Katha_Sunate_-_Lyrical_Video_Tilak_Bhajanavali_YClyaRTDNOQ_ngpcq6.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786109729/Hum_Katha_Sunate_Ram_Sakal_Gun_Dham_Ki_bigz9m.jpg', 870, 'Hindi', '1987-01-25', 0, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-07 18:14:16', NULL),
(24, 'Om Namo Bhagavate Vasudevaya', 'om-namo-bhagavate-vasudevaya', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786113860/Om_Namo_Bhagavate_Vasudevaya_Mahavtar_Narsimha_2yhvCgpNJiA_nw4aow.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786109737/Om_Namo_Bhagavate_Vasudevaya_eb8ttz.jpg', 194, 'Sanskrit', '2025-10-03', 0, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-07 18:13:05', NULL),
(25, 'Bhada Na Makan Ma', 'bhada-na-makan-ma', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786113951/Bhada_Na_Makan_Ma_Ventilator_2018_Aditya_Gadhavi_Parth_B_Thakkar_Niren_Bhatt_Parthiv_Gohil_he1Xdg3Iegw_iknsnj.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786417568/Bhada_Na_Makan_Ma_mzhdoi.jpg', 326, 'Gujarati', '2018-01-01', 0, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-11 03:07:10', NULL),
(26, 'Gir Gajavti Aavi Sihn', 'gir-gajavti-aavi-sinh', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786113884/Gir_Gajavti_Aavi_Sinhan_Parimal_Nathwani_W11Uif3gsNQ_dz4jlg.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786109738/Gir_Gajavti_Aavi_Sinh_mzf8pm.jpg', 186, 'Gujarati', '2020-01-01', 1, 1, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-10 15:30:47', NULL),
(27, 'Kashi Vishwanath Ki Mahima', 'kashi-vishwanath-ki-mahima', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786114036/Kashi_Vishwanath_Ki_Mahima_-_Tanvi_Senjaliya_Yhv--PA7nfU_a2nexp.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786109728/Kashi_Vishwanath_Ki_Mahima_aidabj.jpg', 450, 'Hindi', '2024-01-01', 0, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-07 18:12:16', NULL),
(28, 'Millionaire', 'millionaire', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786069169/millonre_jbfmrv.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786123560/millionaire_v7ufuf.jpg', 195, 'Hindi', '2024-08-26', 0, 0, 0, 0, 1, '2026-08-07 16:58:12', '2026-08-07 18:07:37', NULL),
(29, 'Mann Mohini', 'mann-mohini', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786588613/Mann_Mohini_Hindi_Video_Song_-_Kantara_Chapter_1_Rishab_Shetty_Rukmini_Vasanth_Hombale_Films_TcqAnluKZ6M_y8nl8m.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623341/Mann_Mohini_e8lmnx.jpg', 205, 'Hindi', '2025-10-09', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 12:57:18', NULL),
(30, 'Hellallallo', 'hellallallo', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786589107/PEDDI_Hellallallo_Song_Hindi_Ram_Charan_Buchi_Babu_Shruthi_Haasan_Janhvi_Kapoor_AR_Rahman_bqJPbn7l3Lg_noh7ff.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623340/Hellallallo_kw0ky6.jpg', 213, 'Hindi', '2026-05-23', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 12:58:49', NULL),
(31, 'Ishq Jalakar - Karvaan', 'ishq-jalakar-karvaan', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786588648/Ishq_Jalakar_-_Karvaan_Dhurandhar_Ranveer_Singh_Shashwat_Sachdev_Aditya_Dhar_8qCVXCFREkQ_nlvsju.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623341/Ishq_Jalakar_-_Karvaan_w34lls.jpg', 144, 'Hindi', '2025-11-25', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 16:19:59', NULL),
(32, 'Chikiri Chikiri', 'chikiri-chikiri', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786589108/Full_Video_Chikiri_Chikiri_Peddi_Ram_Charan_Janhvi_Buchi_Babu_AR_Rahman_Mohit_Chauhan_RyzPweJKJ9M_xuksw9.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623340/Chikiri_Chikiri_biqvk4.jpg', 262, 'Hindi', '2025-11-07', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:01:34', NULL),
(33, 'Gokul Ma Raas Rame Bhagwan', 'gokul-ma-raas-rame-bhagwan', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786590896/Gokul_Ma_Raas_Rame_Bhagwan_Rajbha_Gadhavi_%E0%AA%97%E0%AB%8B%E0%AA%95%E0%AB%81%E0%AA%B2_%E0%AA%AE%E0%AA%BE%E0%AA%82_%E0%AA%B0%E0%AA%BE%E0%AA%B8_%E0%AA%B0%E0%AA%AE%E0%AB%87_%E0%AA%AD%E0%AA%97%E0%AA%B5%E0%AA%BE%E0%AA%A8_Krishna_Raas_Garba_2026_Ms9HEqlkURY_r5njsv.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623340/Gokul_Ma_Raas_Rame_Bhagwan_ivvtav.jpg', 142, 'Gujarati', '2024-08-07', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:02:36', NULL),
(34, 'Moti Veraana', 'moti-veraana', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786590984/Moti_Veraana_New_Navratri_Song_2020_Songs_of_Faith_Amit_Trivedi_feat._Osman_Mir_AT_Azaad_Jv8KRwF1zQs_e1nkwu.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623344/Moti_Veraana_lwtpfg.jpg', 214, 'Gujarati', '2020-04-01', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:03:25', NULL),
(35, 'Rai Rai raa raa', 'rai-rai-raa-raa', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786589065/PEDDI_Rai_Rai_Raa_Raa_Song_Full_Video_Hindi_Ram_Charan_Janhvi_Kapoor_Buchi_Babu_AR_Rahman_hpTlEXaR_I0_jwb3cf.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623340/Rai_Rai_raa_raa_eufurk.jpg', 265, 'Hindi', '2026-03-02', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:04:18', NULL),
(36, 'Chaand Ne Kaho', 'chaand-ne-kaho', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786588577/Chaand_Ne_Kaho_Sachin-Jigar_Jigardan_Yash_Soni_Aarohi_Gujarati_Song_Chaal_Jeevi_Laiye__N-A7PIUy2Y_cfx1is.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623341/Chaand_Ne_Kaho_ji8qe5.jpg', 183, 'Gujarati', '2019-01-11', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:05:12', NULL),
(37, 'Bhajan Vina Mari Bhukh Na Bhaje', 'bhajan-vina-mari-bhukh-na-bhaje', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786589133/%E0%AA%AD%E0%AA%9C%E0%AA%A8_%E0%AA%B5%E0%AA%BF%E0%AA%A8%E0%AA%BE_%E0%AA%AE%E0%AA%BE%E0%AA%B0%E0%AB%80_%E0%AA%AD%E0%AB%82%E0%AA%96_%E0%AA%A8%E0%AA%88_%E0%AA%AD%E0%AA%BE%E0%AA%82%E0%AA%97%E0%AB%87_Aditya_Gadhvi_Superhit_Gujarati_Bhajan_Bhajan_Vina_Mari_Bhukh_Nai_llZu57g7v_g_tacaxr.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623341/Bhajan_Vina_Mari_Bhukh_Na_Bhaje_yh8rcg.jpg', 247, 'Gujarati', '2021-12-05', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:06:07', NULL),
(38, 'Nagar Nandji Ne Lal', 'nagar-nandji-ne-lal', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786589182/Naagar_Nandji_Na_Laal_Aditya_Gadhvi_Ft._Kinjal_Rajpriya_iraezTzB938_pinbri.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623341/Nagar_Nandji_Ne_Lal_kmsa0z.jpg', 309, 'Gujarati', '2022-12-07', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:08:53', NULL),
(39, 'Lutt Le Gaya', 'lutt-le-gaya', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786588539/Lutt_Le_Gaya_Dhurandhar_Ranveer_Singh_Akshaye_Khanna_Shashwat_Sachdev_Simran_Choudhary_VWCBZpvjZfc_uu7lwv.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623341/Lutt_Le_Gaya_ypcghn.jpg', 122, 'Hindi', '2025-12-05', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:10:01', NULL),
(40, 'Massa Massa', 'massa-massa', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786589036/PEDDI_Massa_Massa_Full_Video_Hindi_Ram_Charan_Janhvi_Kapoor_AR_Rahman_Nitesh_Aher_zrdjFCC9WuY_m8sok7.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623340/Massa_Massa_piihd7.jpg', 253, 'Hindi', '2026-05-28', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:10:56', NULL),
(41, 'Dhurandhar - Title Track', 'dhurandhar-title-track', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786588579/Dhurandhar_-_Title_Track_Video_Ranveer_Singh_Shashwat_Sachdev_Hanumankind_Jasmine_Sandlas_7IBDa53IsvI_i7ume5.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623341/Dhurandhar_-_Title_Track_csilvs.jpg', 75, 'Hindi/Punjabi', '2025-10-15', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:12:11', NULL),
(42, 'Shararat', 'shararat', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786588661/Shararat_-_Lyrical_Dhurandhar_Ranveer_Singh_Shashwat_S_Jasmine_Madhubanti_Ayesha_Krystle_467x0puJtBg_gwgp09.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623342/Shararat_er6kwa.jpg', 207, 'Hindi', '2025-12-01', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:13:20', NULL),
(43, 'Vaagyo Re Dhol', 'vaagyo-re-dhol', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786588535/Vaagyo_Re_Dhol_-_Hellaro_Song_Promo_Bhoomi_Trivedi_Mehul_Surti_Saumya_Joshi_sDZA54sTqwQ_ynrtg7.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786625244/Vaagyo_Re_Dhol_dkvipz.jpg', 191, 'Gujarati', '2019-10-29', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:14:29', NULL),
(44, 'Talvaar Raas', 'talvaar-raas', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786588562/Talvaar_Raas_Hellaro_Song_Promo_Aditya_Gadhavi_Mehul_Surti_SN6FedFnC04_qs5nij.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623342/Talvaar_Raas_vst2rs.jpg', 60, 'Gujarati', '2019-11-07', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:15:50', NULL),
(45, 'Asvaar', 'asvaar', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786590944/Asvaar_-_Hellaro_Song_Promo_Aishwarya_Majmudar_Mooralala_Marwada_Mehul_Surti_1ZrZeA8j15w_xqh0w2.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623342/Asvaar_qyd2ha.jpg', 150, 'Gujarati', '2019-10-24', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:16:42', NULL),
(46, 'Bheliyo', 'bheliyo', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786589090/Bheliyo_Ishani_Dave_Prafull_Dave_Gujarati_Song_Folk_UtCoPWdmYmQ_ojyyzy.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623344/Bheliyo_wactbu.jpg', 252, 'Gujarati', '2025-04-01', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:18:05', NULL),
(47, 'Move Yeh Ishq Ishq', 'move-yeh-ishq-ishq', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786588966/Move_-_Yeh_Ishq_Ishq_Dhurandhar_Ranveer_Singh_Shashwat_Sachdev_Sonu_Nigam_Reble_RabtYMTE_2U_tntbsd.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623344/Move_Yeh_Ishq_Ishq_iy1z4p.jpg', 147, 'Hindi', '2025-12-05', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:19:10', NULL),
(48, 'Sapna Vinani Raat', 'sapna-vinani-raat', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786589164/Sapna_Vinani_Raat_3nPNNJX-PyY_zf6klo.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623342/Sapna_Vinani_Raat_fvo7p0.jpg', 322, 'Gujarati', '2023-08-09', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:19:39', NULL),
(49, 'Haiyaa', 'haiyaa', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786589137/Haiyaa_Official_Video_Hellaro_Full_Song_Shruti_Pathak_Mehul_Surti_Saumya_Joshi_cqof4tlkEp0_geevqy.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623342/Haiyaa_xrmsz3.jpg', 303, 'Gujarati', '2019-10-24', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:20:27', NULL),
(50, 'Jaiye Sajana', 'jaiye-sajana', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786588606/Jaiye_Sajana_Lyrical_Dhurandhar_The_Revenge_Ranveer_Singh_Shashwat_Sachdev_Jasmine_S_Satinder_S_xV1-V1E5ZlQ_gt0kew.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623343/Jaiye_Sajana_tiggzx.jpg', 192, 'Hindi', '2026-03-17', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:23:04', NULL),
(51, 'Varaha Roopam', 'varaha-roopam', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786588991/Varaha_Roopam_Video_Song-_Kantara_Chapter_1_Rishab_Shetty_Ajaneesh_Loknath_Hombale_Films_aes4j2OSXIU_lb9o7p.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623342/Varaha_Roopam_hvrpbd.jpg', 148, 'Hindi/Sanskrit', '2022-10-10', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:23:51', NULL),
(52, 'Ghanu Jeevo', 'ghanu-jeevo', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786588614/Ghanu_Jeevo_Sachin-Jigar_Bhoomi_Trivedi_Aarohi_Gujarati_Song_Chaal_Jeevi_Laiye_J6pDspsbIuE_dluuyc.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786625165/ghanu_jeevo_hnhqc5.jpg', 153, 'Gujarati', '2019-01-11', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:24:44', NULL),
(53, 'Rang De Lal', 'rang-de-lal', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786588638/Rang_De_Lal_Oye_Oye_Lyrical_Dhurandhar_The_Revenge_Shashwat_Sachdev_Kalyanji-Anandji_Jasmine_1Pu6hWkvVI8_dq9kfb.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786625059/rang_de_lal_mww5lv.jpg', 204, 'Hindi', '2026-03-19', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:25:29', NULL),
(54, 'Didi (Sher-E-Baloch)', 'didi-sher-e-baloch', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786588614/DIDI_SHER-E-BALOCH_Full_Video_Dhurandhar_The_Revenge_Ranveer_Singh_Shashwat_Sachdev_Khaled_hnEGQH4LP2c_rnh8jc.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623342/Didi_Sher-E-Baloch_f0bsdr.jpg', 134, 'Hindi', '2026-03-19', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:26:13', NULL),
(55, 'Brahmakalasha', 'brahmakalasha', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786589176/Brahmakalasha_Hindi_Video_Song_-_Kantara_Chapter_1_Rishab_Shetty_Rukmini_Vasanth_Hombale_Films_ZCzWNZlwmD0_vckjcc.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623344/Brahmakalasha_eaz2uh.jpg', 312, 'Hindi', '2025-09-27', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:27:11', NULL),
(56, 'Aari Aari', 'aari-aari', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786588980/Dhurandhar_The_Revenge_-_AARI_AARI_Video_Ranveer_Singh_Shashwat_Sachdev_Bombay_Rockers_Aditya_D_dESIGVxSSCE_x2etxk.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623344/aari_aari_ligoad.jpg', 145, 'Hindi/Punjabi', '2026-03-12', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:27:54', NULL),
(57, 'Pa Pa Pagli', 'pa-pa-pagli', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786588639/Pa_Pa_Pagli_Siddharth_Randeria_Yash_Soni_Sonu_Nigam_Sachin-Jigar_Chaal_Jeevi_Laiye_9EaO9BHqDjc_f2mmwq.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786623340/Pa_Pa_Pagli_gudtnr.jpg', 187, 'Gujarati', '2019-01-11', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:28:50', NULL),
(58, 'Hum Pyaar Karne Wale', 'hum-pyaar-karne-wale', NULL, NULL, 'https://res.cloudinary.com/xrwvu9pm/video/upload/v1786588649/Hum_Pyaar_Karne_Wale_Lyrical_Dhurandhar_The_Revenge_Shashwat_Sachdev_Anuradha_P_Udit_N_Qveen_Th2Op6uvNXw_ykopjz.mp3', 'https://res.cloudinary.com/xrwvu9pm/image/upload/v1786624939/hum_pyar_karne_vale_vkivfs.jpg', 208, 'Hindi', '2026-03-19', 0, 0, 0, 0, 1, '2026-08-12 17:13:01', '2026-08-13 13:29:41', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `song_albums`
--

DROP TABLE IF EXISTS `song_albums`;
CREATE TABLE IF NOT EXISTS `song_albums` (
  `song_id` int UNSIGNED NOT NULL,
  `album_id` int UNSIGNED NOT NULL,
  `track_number` int UNSIGNED DEFAULT NULL,
  `disc_number` int UNSIGNED DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`song_id`,`album_id`),
  KEY `idx_song_album_album` (`album_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `song_albums`
--

INSERT INTO `song_albums` (`song_id`, `album_id`, `track_number`, `disc_number`, `created_at`) VALUES
(21, 1, 1, 1, '2026-08-13 16:11:55'),
(22, 1, 2, 1, '2026-08-13 16:11:55'),
(29, 1, 3, 1, '2026-08-13 16:11:55'),
(30, 4, 1, 1, '2026-08-13 16:11:55'),
(31, 2, 1, 1, '2026-08-13 16:11:55'),
(32, 4, 2, 1, '2026-08-13 16:11:55'),
(35, 4, 3, 1, '2026-08-13 16:11:55'),
(36, 6, 1, 1, '2026-08-13 16:18:11'),
(39, 2, 2, 1, '2026-08-13 16:11:55'),
(40, 4, 4, 1, '2026-08-13 16:11:55'),
(41, 2, 3, 1, '2026-08-13 16:11:55'),
(42, 2, 4, 1, '2026-08-13 16:11:55'),
(43, 5, 1, 1, '2026-08-13 16:11:55'),
(45, 5, 2, 1, '2026-08-13 16:11:55'),
(47, 2, 5, 1, '2026-08-13 16:11:55'),
(48, 5, 3, 1, '2026-08-13 16:11:55'),
(49, 5, 4, 1, '2026-08-13 16:11:55'),
(50, 3, 1, 1, '2026-08-13 16:11:55'),
(51, 1, 4, 1, '2026-08-13 16:11:55'),
(52, 6, 2, 1, '2026-08-13 16:18:11'),
(53, 3, 2, 1, '2026-08-13 16:11:55'),
(54, 3, 3, 1, '2026-08-13 16:11:55'),
(55, 1, 5, 1, '2026-08-13 16:11:55'),
(56, 3, 4, 1, '2026-08-13 16:11:55'),
(57, 6, 3, 1, '2026-08-13 16:18:11'),
(58, 3, 5, 1, '2026-08-13 16:11:55');

-- --------------------------------------------------------

--
-- Table structure for table `song_artists`
--

DROP TABLE IF EXISTS `song_artists`;
CREATE TABLE IF NOT EXISTS `song_artists` (
  `song_id` int UNSIGNED NOT NULL,
  `artist_id` int UNSIGNED NOT NULL,
  `role` enum('Main','Featured','Composer','Producer') NOT NULL DEFAULT 'Main',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`song_id`,`artist_id`,`role`),
  KEY `idx_song_artist_artist` (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `song_artists`
--

INSERT INTO `song_artists` (`song_id`, `artist_id`, `role`, `created_at`) VALUES
(1, 1, 'Main', '2026-08-07 03:11:36'),
(1, 2, 'Main', '2026-08-07 03:11:36'),
(2, 1, 'Main', '2026-08-08 02:02:57'),
(3, 1, 'Main', '2026-08-08 02:02:57'),
(4, 37, 'Main', '2026-08-08 02:02:57'),
(5, 4, 'Main', '2026-08-08 02:02:57'),
(6, 5, 'Main', '2026-08-08 02:02:57'),
(7, 6, 'Main', '2026-08-08 02:02:57'),
(8, 7, 'Main', '2026-08-08 02:02:57'),
(8, 8, 'Main', '2026-08-08 02:02:57'),
(9, 8, 'Main', '2026-08-08 02:02:57'),
(9, 9, 'Main', '2026-08-08 02:02:57'),
(10, 6, 'Main', '2026-08-08 02:02:57'),
(11, 36, 'Main', '2026-08-08 02:02:57'),
(12, 30, 'Main', '2026-08-08 02:02:57'),
(13, 3, 'Main', '2026-08-08 02:02:57'),
(14, 28, 'Main', '2026-08-08 02:02:57'),
(14, 29, 'Producer', '2026-08-08 02:02:57'),
(15, 1, 'Main', '2026-08-08 02:02:57'),
(16, 34, 'Main', '2026-08-08 02:02:57'),
(16, 35, 'Main', '2026-08-08 02:02:57'),
(17, 31, 'Main', '2026-08-08 02:02:57'),
(17, 32, 'Main', '2026-08-08 02:02:57'),
(17, 33, 'Main', '2026-08-08 02:02:57'),
(18, 12, 'Main', '2026-08-08 02:02:57'),
(18, 13, 'Main', '2026-08-08 02:02:57'),
(18, 14, 'Main', '2026-08-08 02:02:57'),
(19, 15, 'Main', '2026-08-08 02:02:57'),
(19, 16, 'Main', '2026-08-08 02:02:57'),
(20, 17, 'Main', '2026-08-08 02:02:57'),
(21, 18, 'Main', '2026-08-08 02:02:57'),
(22, 19, 'Main', '2026-08-08 02:02:57'),
(23, 20, 'Main', '2026-08-08 02:02:57'),
(23, 21, 'Main', '2026-08-08 02:02:57'),
(23, 22, 'Main', '2026-08-08 02:02:57'),
(24, 23, 'Main', '2026-08-08 02:02:57'),
(24, 24, 'Main', '2026-08-08 02:02:57'),
(25, 25, 'Main', '2026-08-08 02:02:57'),
(25, 26, 'Main', '2026-08-08 02:02:57'),
(26, 25, 'Main', '2026-08-08 02:02:57'),
(27, 27, 'Main', '2026-08-08 02:02:57'),
(28, 30, 'Main', '2026-08-08 02:02:57'),
(29, 24, 'Main', '2026-08-13 15:49:40'),
(29, 38, 'Main', '2026-08-13 15:49:40'),
(30, 39, 'Main', '2026-08-13 15:49:40'),
(31, 40, 'Main', '2026-08-13 15:49:40'),
(31, 41, 'Main', '2026-08-13 15:49:40'),
(31, 42, 'Main', '2026-08-13 15:49:40'),
(31, 43, 'Main', '2026-08-13 15:49:40'),
(32, 44, 'Main', '2026-08-13 15:49:40'),
(33, 45, 'Main', '2026-08-13 15:49:40'),
(34, 12, 'Main', '2026-08-13 15:49:40'),
(34, 46, 'Main', '2026-08-13 15:49:40'),
(35, 47, 'Main', '2026-08-13 15:49:40'),
(36, 33, 'Main', '2026-08-13 15:49:40'),
(36, 48, 'Main', '2026-08-13 15:49:40'),
(36, 49, 'Main', '2026-08-13 15:49:40'),
(37, 25, 'Main', '2026-08-13 15:49:40'),
(38, 25, 'Main', '2026-08-13 15:49:40'),
(39, 50, 'Main', '2026-08-13 15:49:40'),
(40, 51, 'Main', '2026-08-13 15:49:40'),
(41, 28, 'Main', '2026-08-13 15:49:40'),
(41, 40, 'Main', '2026-08-13 15:49:40'),
(41, 52, 'Main', '2026-08-13 15:49:40'),
(41, 53, 'Main', '2026-08-13 15:49:40'),
(41, 54, 'Main', '2026-08-13 15:49:40'),
(41, 55, 'Main', '2026-08-13 15:49:40'),
(42, 31, 'Main', '2026-08-13 15:49:40'),
(42, 52, 'Main', '2026-08-13 15:49:40'),
(43, 13, 'Main', '2026-08-13 15:49:40'),
(44, 25, 'Main', '2026-08-13 15:49:40'),
(45, 61, 'Main', '2026-08-13 15:49:40'),
(45, 62, 'Main', '2026-08-13 15:49:40'),
(46, 63, 'Main', '2026-08-13 15:49:40'),
(46, 64, 'Main', '2026-08-13 15:49:40'),
(47, 40, 'Main', '2026-08-13 15:49:40'),
(47, 56, 'Main', '2026-08-13 15:49:40'),
(47, 57, 'Main', '2026-08-13 15:49:40'),
(48, 25, 'Main', '2026-08-13 15:49:40'),
(49, 15, 'Main', '2026-08-13 15:49:40'),
(50, 52, 'Main', '2026-08-13 15:49:40'),
(50, 58, 'Main', '2026-08-13 15:49:40'),
(51, 59, 'Main', '2026-08-13 15:49:40'),
(52, 13, 'Main', '2026-08-13 15:49:40'),
(52, 33, 'Main', '2026-08-13 15:49:40'),
(52, 60, 'Main', '2026-08-13 15:49:40'),
(53, 52, 'Main', '2026-08-13 15:49:40'),
(53, 57, 'Main', '2026-08-13 15:49:40'),
(53, 65, 'Main', '2026-08-13 15:49:40'),
(53, 66, 'Main', '2026-08-13 15:49:40'),
(54, 40, 'Main', '2026-08-13 15:49:40'),
(54, 67, 'Main', '2026-08-13 15:49:40'),
(54, 68, 'Main', '2026-08-13 15:49:40'),
(55, 69, 'Main', '2026-08-13 15:49:40'),
(56, 40, 'Main', '2026-08-13 15:49:40'),
(56, 52, 'Main', '2026-08-13 15:49:40'),
(56, 53, 'Main', '2026-08-13 15:49:40'),
(56, 57, 'Main', '2026-08-13 15:49:40'),
(56, 70, 'Main', '2026-08-13 15:49:40'),
(56, 71, 'Main', '2026-08-13 15:49:40'),
(56, 72, 'Main', '2026-08-13 15:49:40'),
(57, 56, 'Main', '2026-08-13 15:49:40'),
(58, 73, 'Main', '2026-08-13 15:49:40'),
(58, 74, 'Main', '2026-08-13 15:49:40'),
(58, 75, 'Main', '2026-08-13 15:49:40');

-- --------------------------------------------------------

--
-- Table structure for table `song_genres`
--

DROP TABLE IF EXISTS `song_genres`;
CREATE TABLE IF NOT EXISTS `song_genres` (
  `song_id` int UNSIGNED NOT NULL,
  `genre_id` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`song_id`,`genre_id`),
  KEY `idx_song_genre_genre` (`genre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `song_genres`
--

INSERT INTO `song_genres` (`song_id`, `genre_id`, `created_at`) VALUES
(1, 16, '2026-08-08 02:20:58'),
(2, 16, '2026-08-08 02:20:58'),
(2, 46, '2026-08-08 02:20:58'),
(3, 16, '2026-08-08 02:20:58'),
(3, 46, '2026-08-08 02:20:58'),
(4, 16, '2026-08-08 02:20:58'),
(4, 46, '2026-08-08 02:20:58'),
(5, 1, '2026-08-08 02:20:58'),
(5, 16, '2026-08-08 02:20:58'),
(6, 16, '2026-08-08 02:20:58'),
(6, 46, '2026-08-08 02:20:58'),
(7, 17, '2026-08-08 02:20:58'),
(7, 49, '2026-08-08 02:20:58'),
(8, 14, '2026-08-08 02:20:58'),
(8, 17, '2026-08-08 02:20:58'),
(8, 49, '2026-08-08 02:20:58'),
(9, 17, '2026-08-08 02:20:58'),
(9, 46, '2026-08-08 02:20:58'),
(10, 17, '2026-08-08 02:20:58'),
(10, 49, '2026-08-08 02:20:58'),
(11, 17, '2026-08-08 02:20:58'),
(11, 85, '2026-08-08 05:33:03'),
(12, 52, '2026-08-08 02:20:58'),
(13, 1, '2026-08-08 02:20:58'),
(13, 11, '2026-08-08 02:20:58'),
(13, 46, '2026-08-08 02:20:58'),
(14, 3, '2026-08-08 02:20:58'),
(14, 4, '2026-08-08 02:20:58'),
(14, 83, '2026-08-08 02:20:58'),
(15, 46, '2026-08-08 02:20:58'),
(15, 52, '2026-08-08 02:20:58'),
(16, 1, '2026-08-08 02:20:58'),
(16, 3, '2026-08-08 02:20:58'),
(16, 4, '2026-08-08 02:20:58'),
(17, 1, '2026-08-08 02:20:58'),
(17, 11, '2026-08-08 02:20:58'),
(17, 46, '2026-08-08 02:20:58'),
(18, 15, '2026-08-08 02:20:58'),
(18, 51, '2026-08-08 02:20:58'),
(18, 85, '2026-08-08 05:33:27'),
(19, 15, '2026-08-08 02:20:58'),
(19, 46, '2026-08-08 02:20:58'),
(19, 85, '2026-08-08 05:33:40'),
(20, 17, '2026-08-08 02:20:58'),
(20, 50, '2026-08-08 02:20:58'),
(21, 3, '2026-08-08 02:20:58'),
(21, 4, '2026-08-08 02:20:58'),
(21, 46, '2026-08-08 02:20:58'),
(22, 15, '2026-08-08 02:20:58'),
(22, 17, '2026-08-08 02:20:58'),
(23, 17, '2026-08-08 02:20:58'),
(23, 49, '2026-08-08 02:20:58'),
(24, 17, '2026-08-08 02:20:58'),
(24, 84, '2026-08-08 05:34:11'),
(25, 15, '2026-08-08 02:20:58'),
(25, 85, '2026-08-08 05:33:59'),
(26, 15, '2026-08-08 02:20:58'),
(26, 85, '2026-08-08 05:34:11'),
(27, 17, '2026-08-08 02:20:58'),
(27, 49, '2026-08-08 02:20:58'),
(28, 46, '2026-08-08 02:20:58'),
(28, 52, '2026-08-08 02:20:58'),
(29, 1, '2026-08-13 15:56:37'),
(29, 68, '2026-08-13 15:56:37'),
(30, 1, '2026-08-13 15:56:37'),
(30, 68, '2026-08-13 15:56:37'),
(31, 16, '2026-08-13 15:56:37'),
(31, 46, '2026-08-13 15:56:37'),
(31, 68, '2026-08-13 15:56:37'),
(32, 11, '2026-08-13 15:56:37'),
(32, 15, '2026-08-13 15:56:37'),
(32, 68, '2026-08-13 15:56:37'),
(33, 15, '2026-08-13 15:56:37'),
(33, 17, '2026-08-13 15:56:37'),
(33, 85, '2026-08-13 15:56:37'),
(34, 15, '2026-08-13 15:56:37'),
(34, 16, '2026-08-13 15:56:37'),
(34, 85, '2026-08-13 15:56:37'),
(35, 11, '2026-08-13 15:56:37'),
(35, 46, '2026-08-13 15:56:37'),
(35, 68, '2026-08-13 15:56:37'),
(36, 1, '2026-08-13 15:56:37'),
(36, 16, '2026-08-13 15:56:37'),
(37, 15, '2026-08-13 15:56:37'),
(37, 17, '2026-08-13 15:56:37'),
(37, 49, '2026-08-13 15:56:37'),
(37, 85, '2026-08-13 15:56:37'),
(38, 15, '2026-08-13 15:56:37'),
(38, 17, '2026-08-13 15:56:37'),
(38, 49, '2026-08-13 15:56:37'),
(38, 85, '2026-08-13 15:56:37'),
(39, 1, '2026-08-13 15:56:37'),
(39, 11, '2026-08-13 15:56:37'),
(39, 46, '2026-08-13 15:56:37'),
(40, 1, '2026-08-13 15:56:37'),
(40, 46, '2026-08-13 15:56:37'),
(40, 68, '2026-08-13 15:56:37'),
(41, 3, '2026-08-13 15:56:37'),
(41, 4, '2026-08-13 15:56:37'),
(41, 46, '2026-08-13 15:56:37'),
(41, 68, '2026-08-13 15:56:37'),
(41, 83, '2026-08-13 15:56:37'),
(42, 1, '2026-08-13 15:56:37'),
(42, 11, '2026-08-13 15:56:37'),
(42, 46, '2026-08-13 15:56:37'),
(43, 11, '2026-08-13 15:56:37'),
(43, 15, '2026-08-13 15:56:37'),
(43, 85, '2026-08-13 15:56:37'),
(44, 11, '2026-08-13 15:56:37'),
(44, 15, '2026-08-13 15:56:37'),
(44, 85, '2026-08-13 15:56:37'),
(45, 15, '2026-08-13 15:56:37'),
(45, 85, '2026-08-13 15:56:37'),
(46, 15, '2026-08-13 15:56:37'),
(46, 85, '2026-08-13 15:56:37'),
(47, 1, '2026-08-13 15:56:37'),
(47, 16, '2026-08-13 15:56:37'),
(47, 46, '2026-08-13 15:56:37'),
(47, 68, '2026-08-13 15:56:37'),
(48, 15, '2026-08-13 15:56:37'),
(48, 16, '2026-08-13 15:56:37'),
(48, 85, '2026-08-13 15:56:37'),
(49, 1, '2026-08-13 15:56:37'),
(49, 16, '2026-08-13 15:56:37'),
(50, 1, '2026-08-13 15:56:37'),
(50, 16, '2026-08-13 15:56:37'),
(50, 46, '2026-08-13 15:56:37'),
(51, 8, '2026-08-13 15:56:37'),
(51, 17, '2026-08-13 15:56:37'),
(51, 68, '2026-08-13 15:56:37'),
(51, 84, '2026-08-13 15:56:37'),
(52, 1, '2026-08-13 15:56:37'),
(52, 15, '2026-08-13 15:56:37'),
(52, 85, '2026-08-13 15:56:37'),
(53, 1, '2026-08-13 15:56:37'),
(53, 11, '2026-08-13 15:56:37'),
(53, 46, '2026-08-13 15:56:37'),
(53, 68, '2026-08-13 15:56:37'),
(54, 3, '2026-08-13 15:56:37'),
(54, 4, '2026-08-13 15:56:37'),
(54, 83, '2026-08-13 15:56:37'),
(55, 8, '2026-08-13 15:56:37'),
(55, 17, '2026-08-13 15:56:37'),
(55, 68, '2026-08-13 15:56:37'),
(55, 84, '2026-08-13 15:56:37'),
(56, 3, '2026-08-13 15:56:37'),
(56, 4, '2026-08-13 15:56:37'),
(56, 46, '2026-08-13 15:56:37'),
(56, 68, '2026-08-13 15:56:37'),
(56, 83, '2026-08-13 15:56:37'),
(57, 1, '2026-08-13 15:56:37'),
(57, 16, '2026-08-13 15:56:37'),
(58, 1, '2026-08-13 15:56:37'),
(58, 16, '2026-08-13 15:56:37'),
(58, 46, '2026-08-13 15:56:37'),
(58, 68, '2026-08-13 15:56:37');

-- --------------------------------------------------------

--
-- Table structure for table `song_views`
--

DROP TABLE IF EXISTS `song_views`;
CREATE TABLE IF NOT EXISTS `song_views` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `song_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED DEFAULT NULL,
  `viewed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ip_address` varchar(45) DEFAULT NULL,
  `device` varchar(100) DEFAULT NULL,
  `platform` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_song` (`song_id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_viewed` (`viewed_at`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `song_views`
--

INSERT INTO `song_views` (`id`, `song_id`, `user_id`, `viewed_at`, `ip_address`, `device`, `platform`) VALUES
(1, 1, 1, '2026-08-08 06:19:09', '127.0.0.1', 'Android', 'Flutter'),
(2, 1, 1, '2026-08-08 04:29:09', '127.0.0.1', 'Android', 'Flutter'),
(3, 2, 1, '2026-08-08 05:59:09', '127.0.0.1', 'Android', 'Flutter'),
(4, 7, 1, '2026-08-08 05:29:09', '127.0.0.1', 'Android', 'Flutter'),
(5, 14, 1, '2026-08-08 03:29:09', '127.0.0.1', 'Windows', 'Web'),
(6, 18, 1, '2026-08-07 06:29:09', '127.0.0.1', 'Android', 'Flutter'),
(7, 26, 1, '2026-08-06 06:29:09', '127.0.0.1', 'Android', 'Flutter'),
(8, 28, NULL, '2026-08-05 06:29:09', '127.0.0.1', 'Windows', 'Web');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `avatar_url` text,
  `country` varchar(100) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT 'other',
  `bio` text,
  `is_premium` tinyint(1) DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `avatar_url`, `country`, `birth_date`, `gender`, `bio`, `is_premium`, `status`, `last_login`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Birang', 'test@test.com', '$2y$10$dZdla/JwogUJc1a5kMBLvelW2nYFWK9I.aOmqjjS7H6dZZxMulFpm', '', 'India', '2003-11-28', 'male', 'Music lover', 0, 1, '2026-08-11 16:45:55', '2026-08-06 18:25:44', '2026-08-11 16:45:55', NULL),
(2, 'barot', 'test2@test.com', '$2y$10$mtYXpwDidWgiGFw8PwIq0uHCsbd7/P4xAI50PIB5c5anCij.RYIcq', NULL, NULL, NULL, 'other', NULL, 0, 1, '2026-08-11 16:32:44', '2026-08-08 12:08:40', '2026-08-11 16:32:44', NULL);

--
-- Triggers `users`
--
DROP TRIGGER IF EXISTS `tr_create_user_settings`;
DELIMITER $$
CREATE TRIGGER `tr_create_user_settings` AFTER INSERT ON `users` FOR EACH ROW BEGIN
    INSERT INTO user_settings(user_id)
    VALUES(NEW.id);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_settings`
--

DROP TABLE IF EXISTS `user_settings`;
CREATE TABLE IF NOT EXISTS `user_settings` (
  `user_id` int UNSIGNED NOT NULL,
  `theme` enum('light','dark','system') DEFAULT 'system',
  `language` varchar(10) DEFAULT 'en',
  `stream_quality` enum('low','medium','high','lossless') DEFAULT 'high',
  `download_quality` enum('low','medium','high','lossless') DEFAULT 'high',
  `autoplay` tinyint(1) DEFAULT '1',
  `crossfade_seconds` tinyint UNSIGNED DEFAULT '0',
  `normalize_volume` tinyint(1) DEFAULT '1',
  `explicit_content` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_settings`
--

INSERT INTO `user_settings` (`user_id`, `theme`, `language`, `stream_quality`, `download_quality`, `autoplay`, `crossfade_seconds`, `normalize_volume`, `explicit_content`, `created_at`, `updated_at`) VALUES
(1, 'system', 'en', 'high', 'high', 1, 0, 1, 1, '2026-08-06 18:25:44', '2026-08-06 18:25:44'),
(2, 'system', 'en', 'high', 'high', 1, 0, 1, 1, '2026-08-08 12:08:40', '2026-08-08 12:08:40');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
