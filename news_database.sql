-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 02, 2026 at 11:56 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `news_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `action` varchar(255) NOT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `ip`, `created_at`) VALUES
(1, 204, 'admin logged in', '127.0.0.1', '2026-02-28 00:28:35'),
(2, 205, 'user logged in', '127.0.0.1', '2026-02-28 00:54:52'),
(3, 205, 'user logged in', '127.0.0.1', '2026-02-28 02:58:11'),
(4, 205, 'user logged in', '127.0.0.1', '2026-02-28 02:59:16'),
(5, 205, 'user logged in', '127.0.0.1', '2026-02-28 03:05:18'),
(6, 205, 'user logged in', '127.0.0.1', '2026-03-02 01:01:53'),
(7, 204, 'admin logged in', '127.0.0.1', '2026-03-02 03:59:52'),
(8, 205, 'user logged in', '127.0.0.1', '2026-03-02 04:04:02'),
(9, 204, 'admin logged in', '127.0.0.1', '2026-03-02 04:04:40'),
(10, 205, 'user logged in', '127.0.0.1', '2026-03-02 04:05:18'),
(11, 204, 'admin logged in', '127.0.0.1', '2026-03-02 04:11:05'),
(12, 205, 'user logged in', '127.0.0.1', '2026-03-02 04:18:05'),
(13, 204, 'admin logged in', '127.0.0.1', '2026-03-02 04:18:18'),
(14, 203, 'editor logged in', '127.0.0.1', '2026-03-02 04:59:40'),
(15, 204, 'admin logged in', '127.0.0.1', '2026-03-02 05:24:27');

-- --------------------------------------------------------

--
-- Table structure for table `articles`
--

CREATE TABLE `articles` (
  `id` bigint(20) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `subcategory_id` bigint(20) DEFAULT NULL,
  `author_id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `short_description` text DEFAULT NULL,
  `full_content` longtext DEFAULT NULL,
  `language` varchar(20) DEFAULT NULL,
  `status` enum('draft','published','archived','pending') DEFAULT 'pending',
  `is_breaking` tinyint(1) DEFAULT 0,
  `is_trending` tinyint(1) DEFAULT 0,
  `views` bigint(20) DEFAULT 0,
  `published_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `articles`
--

INSERT INTO `articles` (`id`, `category_id`, `subcategory_id`, `author_id`, `title`, `slug`, `short_description`, `full_content`, `language`, `status`, `is_breaking`, `is_trending`, `views`, `published_at`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, 'Company News: Latest Developments in Business', 'company-news-1', 'Key updates from the company news segment in business.', 'The company news category has seen major developments. Experts believe these changes could have long-term impact on business.', 'en', 'published', 0, 0, 13010, '2026-02-09 04:45:45', '2025-01-01 04:40:00', '2026-03-02 04:07:35'),
(2, 2, 19, 3, 'Sensex / Nifty: Latest Developments in Markets', 'sensex-nifty-2', 'Key updates from the sensex / nifty segment in markets.', 'The sensex / nifty category has seen major developments. Experts believe these changes could have long-term impact on markets.', 'en', 'published', 0, 0, 13438, '2026-02-09 04:45:45', '2025-01-01 04:50:00', '2026-03-02 04:07:31'),
(3, 3, 36, 4, 'GDP: Latest Developments in Wealth', 'gdp-3', 'Key updates from the gdp segment in wealth.', 'The gdp category has seen major developments. Experts believe these changes could have long-term impact on wealth.', 'en', 'published', 0, 0, 12481, '2026-02-09 04:45:45', '2025-01-01 05:00:00', '2026-02-19 04:29:12'),
(4, 4, 49, 5, 'USA: Latest Developments in World / Global', 'usa-4', 'Key updates from the usa segment in world / global.', 'The usa category has seen major developments. Experts believe these changes could have long-term impact on world / global.', 'en', 'published', 0, 0, 7366, '2026-02-09 04:45:45', '2025-01-01 05:10:00', '2026-02-09 10:22:34'),
(5, 5, 61, 1, 'Savings Accounts: Latest Developments in Personal Finance', 'savings-accounts-5', 'Key updates from the savings accounts segment in personal finance.', 'The savings accounts category has seen major developments. Experts believe these changes could have long-term impact on personal finance.', 'en', 'published', 0, 0, 7115, '2026-02-09 04:45:45', '2025-01-01 05:20:00', '2026-02-09 10:22:34'),
(6, 6, 73, 2, 'Funding Rounds: Latest Developments in Startups & Tech', 'funding-rounds-6', 'Key updates from the funding rounds segment in startups & tech.', 'The funding rounds category has seen major developments. Experts believe these changes could have long-term impact on startups & tech.', 'en', 'published', 0, 0, 14067, '2026-02-09 04:45:45', '2025-01-01 05:30:00', '2026-02-09 10:22:34'),
(7, 7, 85, 3, 'Renewable: Latest Developments in Industry & Energy', 'renewable-7', 'Key updates from the renewable segment in industry & energy.', 'The renewable category has seen major developments. Experts believe these changes could have long-term impact on industry & energy.', 'en', 'published', 0, 0, 15237, '2026-02-09 04:45:45', '2025-01-01 05:40:00', '2026-02-09 10:22:34'),
(8, 8, 96, 4, 'Parliament: Latest Developments in Politics & Governance', 'parliament-8', 'Key updates from the parliament segment in politics & governance.', 'The parliament category has seen major developments. Experts believe these changes could have long-term impact on politics & governance.', 'en', 'published', 0, 0, 3066, '2026-02-09 04:45:45', '2025-01-01 05:50:00', '2026-02-09 10:22:34'),
(9, 9, 106, 5, 'Schools: Latest Developments in Education, Universities & Careers', 'schools-9', 'Key updates from the schools segment in education, universities & careers.', 'The schools category has seen major developments. Experts believe these changes could have long-term impact on education, universities & careers.', 'en', 'published', 0, 0, 12720, '2026-02-09 04:45:45', '2025-01-01 06:00:00', '2026-02-09 10:22:34'),
(10, 10, 122, 1, 'Public Health: Latest Developments in Health & Science', 'public-health-10', 'Key updates from the public health segment in health & science.', 'The public health category has seen major developments. Experts believe these changes could have long-term impact on health & science.', 'en', 'published', 0, 0, 3664, '2026-02-09 04:45:45', '2025-01-01 06:10:00', '2026-02-09 10:22:34'),
(11, 11, 130, 2, 'Housing Market: Latest Developments in Real Estate & Infrastructure', 'housing-market-11', 'Key updates from the housing market segment in real estate & infrastructure.', 'The housing market category has seen major developments. Experts believe these changes could have long-term impact on real estate & infrastructure.', 'en', 'published', 0, 0, 12948, '2026-02-09 04:45:45', '2025-01-01 06:20:00', '2026-02-09 10:22:34'),
(12, 12, 135, 3, 'Street Food: Latest Developments in Food, Travel & Lifestyle', 'street-food-12', 'Key updates from the street food segment in food, travel & lifestyle.', 'The street food category has seen major developments. Experts believe these changes could have long-term impact on food, travel & lifestyle.', 'en', 'published', 0, 0, 8995, '2026-02-09 04:45:45', '2025-01-01 06:30:00', '2026-02-09 10:22:34'),
(13, 13, 148, 4, 'Social Media Trends: Latest Developments in Digital & Media', 'social-media-trends-13', 'Key updates from the social media trends segment in digital & media.', 'The social media trends category has seen major developments. Experts believe these changes could have long-term impact on digital & media.', 'en', 'published', 0, 0, 7671, '2026-02-09 04:45:45', '2025-01-01 06:40:00', '2026-02-09 10:22:34'),
(14, 14, 153, 5, 'Editorials: Latest Developments in Opinion & Insights', 'editorials-14', 'Key updates from the editorials segment in opinion & insights.', 'The editorials category has seen major developments. Experts believe these changes could have long-term impact on opinion & insights.', 'en', 'published', 0, 0, 7522, '2026-02-09 04:45:45', '2025-01-01 06:50:00', '2026-02-09 10:22:34'),
(15, 15, 158, 1, 'Finance Basics: Latest Developments in Learning Hub', 'finance-basics-15', 'Key updates from the finance basics segment in learning hub.', 'The finance basics category has seen major developments. Experts believe these changes could have long-term impact on learning hub.', 'en', 'published', 0, 0, 12812, '2026-02-09 04:45:45', '2025-01-01 07:00:00', '2026-02-09 10:22:34'),
(16, 16, 163, 2, 'Calculators: Latest Developments in Data & Tools', 'calculators-16', 'Key updates from the calculators segment in data & tools.', 'The calculators category has seen major developments. Experts believe these changes could have long-term impact on data & tools.', 'en', 'published', 0, 0, 5477, '2026-02-09 04:45:45', '2025-01-01 07:10:00', '2026-02-09 10:22:34'),
(17, 17, 168, 3, 'Investigations: Latest Developments in Special Projects', 'investigations-17', 'Key updates from the investigations segment in special projects.', 'The investigations category has seen major developments. Experts believe these changes could have long-term impact on special projects.', 'en', 'published', 0, 0, 10147, '2026-02-09 04:45:45', '2025-01-01 07:20:00', '2026-02-09 10:22:34'),
(18, 18, 173, 4, 'Maharashtra: Latest Developments in Regional & State Hot Picks', 'maharashtra-18', 'Key updates from the maharashtra segment in regional & state hot picks.', 'The maharashtra category has seen major developments. Experts believe these changes could have long-term impact on regional & state hot picks.', 'en', 'published', 0, 0, 4963, '2026-02-09 04:45:45', '2025-01-01 07:30:00', '2026-02-09 10:22:34'),
(19, 19, 188, 5, 'Major Crimes: Latest Developments in Crime & Justice', 'major-crimes-19', 'Key updates from the major crimes segment in crime & justice.', 'The major crimes category has seen major developments. Experts believe these changes could have long-term impact on crime & justice.', 'en', 'published', 0, 0, 7660, '2026-02-09 04:45:45', '2025-01-01 07:40:00', '2026-02-09 10:22:34'),
(20, 20, 197, 1, 'Movie Releases: Latest Developments in Celebrities & Entertainment', 'movie-releases-20', 'Key updates from the movie releases segment in celebrities & entertainment.', 'The movie releases category has seen major developments. Experts believe these changes could have long-term impact on celebrities & entertainment.', 'en', 'published', 0, 0, 8160, '2026-02-09 04:45:45', '2025-01-01 07:50:00', '2026-02-09 10:22:34'),
(21, 21, 10, 2, 'Entrepreneur Stories: Latest Developments in Web Series, Global Shows & Anime', 'entrepreneur-stories-21', 'Key updates from the entrepreneur stories segment in web series, global shows & anime.', 'The entrepreneur stories category has seen major developments. Experts believe these changes could have long-term impact on web series, global shows & anime.', 'en', 'published', 0, 0, 2766, '2026-02-09 04:45:45', '2025-01-01 08:00:00', '2026-02-09 10:22:34'),
(22, 22, 11, 3, 'Automobile: Latest Developments in Sports & Games', 'automobile-22', 'Key updates from the automobile segment in sports & games.', 'The automobile category has seen major developments. Experts believe these changes could have long-term impact on sports & games.', 'en', 'published', 0, 0, 6582, '2026-02-09 04:45:45', '2025-01-01 08:10:00', '2026-02-09 10:22:34'),
(23, 23, 12, 4, 'Aviation: Latest Developments in Space, Science & Environment', 'aviation-23', 'Key updates from the aviation segment in space, science & environment.', 'The aviation category has seen major developments. Experts believe these changes could have long-term impact on space, science & environment.', 'en', 'published', 0, 0, 15265, '2026-02-09 04:45:45', '2025-01-01 08:20:00', '2026-02-09 10:22:34'),
(24, 24, 1, 5, 'Company News: Latest Developments in Religion, Spirituality & Culture', 'company-news-24', 'Key updates from the company news segment in religion, spirituality & culture.', 'The company news category has seen major developments. Experts believe these changes could have long-term impact on religion, spirituality & culture.', 'en', 'published', 0, 0, 13015, '2026-02-09 04:45:45', '2025-01-01 08:30:00', '2026-02-09 10:22:34'),
(25, 25, 2, 1, 'Earnings & Results: Latest Developments in India & World', 'earnings-&-results-25', 'Key updates from the earnings & results segment in india & world.', 'The earnings & results category has seen major developments. Experts believe these changes could have long-term impact on india & world.', 'en', 'published', 0, 0, 12410, '2026-02-09 04:45:45', '2025-01-01 08:40:00', '2026-02-09 10:22:34'),
(26, 26, 3, 2, 'Mergers & Acquisitions: Latest Developments in Corporate Affairs', 'mergers-&-acquisitions-26', 'Key updates from the mergers & acquisitions segment in corporate affairs.', 'The mergers & acquisitions category has seen major developments. Experts believe these changes could have long-term impact on corporate affairs.', 'en', 'published', 0, 0, 4047, '2026-02-09 04:45:45', '2025-01-01 08:50:00', '2026-02-09 10:22:34'),
(27, 27, 4, 3, 'Leadership & Appointments: Latest Developments in Startup Ecosystem', 'leadership-&-appointments-27', 'Key updates from the leadership & appointments segment in startup ecosystem.', 'The leadership & appointments category has seen major developments. Experts believe these changes could have long-term impact on startup ecosystem.', 'en', 'published', 0, 0, 7385, '2026-02-09 04:45:45', '2025-01-01 09:00:00', '2026-02-09 10:22:34'),
(28, 28, 5, 4, 'Restructuring & Layoffs: Latest Developments in Venture Capital', 'restructuring-&-layoffs-28', 'Key updates from the restructuring & layoffs segment in venture capital.', 'The restructuring & layoffs category has seen major developments. Experts believe these changes could have long-term impact on venture capital.', 'en', 'published', 0, 0, 14680, '2026-02-09 04:45:45', '2025-01-01 09:10:00', '2026-02-09 10:22:34'),
(29, 29, 6, 5, 'Startup Funding: Latest Developments in Private Equity', 'startup-funding-29', 'Key updates from the startup funding segment in private equity.', 'The startup funding category has seen major developments. Experts believe these changes could have long-term impact on private equity.', 'en', 'published', 0, 0, 11438, '2026-02-09 04:45:45', '2025-01-01 09:20:00', '2026-02-09 10:22:34'),
(30, 30, 7, 1, 'Unicorns: Latest Developments in Global Economy', 'unicorns-30', 'Key updates from the unicorns segment in global economy.', 'The unicorns category has seen major developments. Experts believe these changes could have long-term impact on global economy.', 'en', 'published', 0, 0, 2678, '2026-02-09 04:45:45', '2025-01-01 09:30:00', '2026-02-09 10:22:34'),
(31, 31, 8, 2, 'Incubators: Latest Developments in International Trade', 'incubators-31', 'Key updates from the incubators segment in international trade.', 'The incubators category has seen major developments. Experts believe these changes could have long-term impact on international trade.', 'en', 'published', 0, 0, 3259, '2026-02-09 04:45:45', '2025-01-01 09:40:00', '2026-02-09 10:22:34'),
(32, 32, 9, 3, 'MSME Policies: Latest Developments in Public Policy', 'msme-policies-32', 'Key updates from the msme policies segment in public policy.', 'The msme policies category has seen major developments. Experts believe these changes could have long-term impact on public policy.', 'en', 'published', 0, 0, 10688, '2026-02-09 04:45:45', '2025-01-01 09:50:00', '2026-02-09 10:22:34'),
(33, 33, 10, 4, 'Entrepreneur Stories: Latest Developments in Taxation & Budget', 'entrepreneur-stories-33', 'Key updates from the entrepreneur stories segment in taxation & budget.', 'The entrepreneur stories category has seen major developments. Experts believe these changes could have long-term impact on taxation & budget.', 'en', 'published', 0, 0, 9504, '2026-02-09 04:45:45', '2025-01-01 10:00:00', '2026-02-09 10:22:34'),
(34, 34, 11, 5, 'Automobile: Latest Developments in Stock Analysis', 'automobile-34', 'Key updates from the automobile segment in stock analysis.', 'The automobile category has seen major developments. Experts believe these changes could have long-term impact on stock analysis.', 'en', 'published', 0, 0, 6382, '2026-02-09 04:45:45', '2025-01-01 10:10:00', '2026-02-09 10:22:34'),
(35, 35, 12, 1, 'Aviation: Latest Developments in Investment Strategies', 'aviation-35', 'Key updates from the aviation segment in investment strategies.', 'The aviation category has seen major developments. Experts believe these changes could have long-term impact on investment strategies.', 'en', 'published', 0, 0, 7536, '2026-02-09 04:45:45', '2025-01-01 10:20:00', '2026-02-09 10:22:34'),
(36, 36, 1, 2, 'Company News: Latest Developments in Wealth Management', 'company-news-36', 'Key updates from the company news segment in wealth management.', 'The company news category has seen major developments. Experts believe these changes could have long-term impact on wealth management.', 'en', 'published', 0, 0, 13736, '2026-02-09 04:45:45', '2025-01-01 10:30:00', '2026-02-09 10:22:34'),
(37, 37, 2, 3, 'Earnings & Results: Latest Developments in Retirement Planning', 'earnings-&-results-37', 'Key updates from the earnings & results segment in retirement planning.', 'The earnings & results category has seen major developments. Experts believe these changes could have long-term impact on retirement planning.', 'en', 'published', 0, 0, 8119, '2026-02-09 04:45:45', '2025-01-01 10:40:00', '2026-02-09 10:22:34'),
(38, 38, 3, 4, 'Mergers & Acquisitions: Latest Developments in Banking Reforms', 'mergers-&-acquisitions-38', 'Key updates from the mergers & acquisitions segment in banking reforms.', 'The mergers & acquisitions category has seen major developments. Experts believe these changes could have long-term impact on banking reforms.', 'en', 'published', 0, 0, 6216, '2026-02-09 04:45:45', '2025-01-01 10:50:00', '2026-02-09 10:22:34'),
(39, 39, 4, 5, 'Leadership & Appointments: Latest Developments in Fintech Innovations', 'leadership-&-appointments-39', 'Key updates from the leadership & appointments segment in fintech innovations.', 'The leadership & appointments category has seen major developments. Experts believe these changes could have long-term impact on fintech innovations.', 'en', 'published', 0, 0, 14260, '2026-02-09 04:45:45', '2025-01-01 11:00:00', '2026-02-09 10:22:34'),
(40, 40, 5, 1, 'Restructuring & Layoffs: Latest Developments in Digital Payments', 'restructuring-&-layoffs-40', 'Key updates from the restructuring & layoffs segment in digital payments.', 'The restructuring & layoffs category has seen major developments. Experts believe these changes could have long-term impact on digital payments.', 'en', 'published', 0, 0, 9274, '2026-02-09 04:45:45', '2025-01-01 11:10:00', '2026-02-09 10:22:34'),
(41, 41, 6, 2, 'Startup Funding: Latest Developments in Insurance Sector', 'startup-funding-41', 'Key updates from the startup funding segment in insurance sector.', 'The startup funding category has seen major developments. Experts believe these changes could have long-term impact on insurance sector.', 'en', 'published', 0, 0, 10921, '2026-02-09 04:45:45', '2025-01-01 11:20:00', '2026-02-09 10:22:34'),
(42, 42, 7, 3, 'Unicorns: Latest Developments in Renewable Energy', 'unicorns-42', 'Key updates from the unicorns segment in renewable energy.', 'The unicorns category has seen major developments. Experts believe these changes could have long-term impact on renewable energy.', 'en', 'published', 0, 0, 2145, '2026-02-09 04:45:45', '2025-01-01 11:30:00', '2026-02-09 10:22:34'),
(43, 43, 8, 4, 'Incubators: Latest Developments in Power Sector', 'incubators-43', 'Key updates from the incubators segment in power sector.', 'The incubators category has seen major developments. Experts believe these changes could have long-term impact on power sector.', 'en', 'published', 0, 0, 6632, '2026-02-09 04:45:45', '2025-01-01 11:40:00', '2026-02-09 10:22:34'),
(44, 44, 9, 5, 'MSME Policies: Latest Developments in Oil & Gas', 'msme-policies-44', 'Key updates from the msme policies segment in oil & gas.', 'The msme policies category has seen major developments. Experts believe these changes could have long-term impact on oil & gas.', 'en', 'published', 0, 0, 7453, '2026-02-09 04:45:45', '2025-01-01 11:50:00', '2026-02-09 10:22:34'),
(45, 45, 10, 1, 'Entrepreneur Stories: Latest Developments in Electric Vehicles', 'entrepreneur-stories-45', 'Key updates from the entrepreneur stories segment in electric vehicles.', 'The entrepreneur stories category has seen major developments. Experts believe these changes could have long-term impact on electric vehicles.', 'en', 'published', 0, 0, 6863, '2026-02-09 04:45:45', '2025-01-01 12:00:00', '2026-02-09 10:22:34'),
(46, 46, 11, 2, 'Automobile: Latest Developments in Automobile Industry', 'automobile-46', 'Key updates from the automobile segment in automobile industry.', 'The automobile category has seen major developments. Experts believe these changes could have long-term impact on automobile industry.', 'en', 'published', 0, 0, 2062, '2026-02-09 04:45:45', '2025-01-01 12:10:00', '2026-02-09 10:22:34'),
(47, 47, 12, 3, 'Aviation: Latest Developments in Aviation Industry', 'aviation-47', 'Key updates from the aviation segment in aviation industry.', 'The aviation category has seen major developments. Experts believe these changes could have long-term impact on aviation industry.', 'en', 'published', 0, 0, 13519, '2026-02-09 04:45:45', '2025-01-01 12:20:00', '2026-02-09 10:22:34'),
(48, 48, 1, 4, 'Company News: Latest Developments in Railways & Transport', 'company-news-48', 'Key updates from the company news segment in railways & transport.', 'The company news category has seen major developments. Experts believe these changes could have long-term impact on railways & transport.', 'en', 'published', 0, 0, 11873, '2026-02-09 04:45:45', '2025-01-01 12:30:00', '2026-02-09 10:22:34'),
(49, 49, 2, 5, 'Earnings & Results: Latest Developments in Logistics & Supply Chain', 'earnings-&-results-49', 'Key updates from the earnings & results segment in logistics & supply chain.', 'The earnings & results category has seen major developments. Experts believe these changes could have long-term impact on logistics & supply chain.', 'en', 'published', 0, 0, 11421, '2026-02-09 04:45:45', '2025-01-01 12:40:00', '2026-02-09 10:22:34'),
(50, 50, 3, 1, 'Mergers & Acquisitions: Latest Developments in Smart Cities', 'mergers-&-acquisitions-50', 'Key updates from the mergers & acquisitions segment in smart cities.', 'The mergers & acquisitions category has seen major developments. Experts believe these changes could have long-term impact on smart cities.', 'en', 'published', 0, 0, 10366, '2026-02-09 04:45:45', '2025-01-01 12:50:00', '2026-02-09 10:22:34'),
(51, 51, 4, 2, 'Leadership & Appointments: Latest Developments in Urban Development', 'leadership-&-appointments-51', 'Key updates from the leadership & appointments segment in urban development.', 'The leadership & appointments category has seen major developments. Experts believe these changes could have long-term impact on urban development.', 'en', 'published', 0, 0, 16877, '2026-02-09 04:45:45', '2025-01-01 13:00:00', '2026-02-09 10:22:34'),
(52, 52, 5, 3, 'Restructuring & Layoffs: Latest Developments in Rural Development', 'restructuring-&-layoffs-52', 'Key updates from the restructuring & layoffs segment in rural development.', 'The restructuring & layoffs category has seen major developments. Experts believe these changes could have long-term impact on rural development.', 'en', 'published', 0, 0, 10543, '2026-02-09 04:45:45', '2025-01-01 13:10:00', '2026-02-09 10:22:34'),
(53, 53, 6, 4, 'Startup Funding: Latest Developments in Infrastructure Projects', 'startup-funding-53', 'Key updates from the startup funding segment in infrastructure projects.', 'The startup funding category has seen major developments. Experts believe these changes could have long-term impact on infrastructure projects.', 'en', 'published', 0, 0, 10297, '2026-02-09 04:45:45', '2025-01-01 13:20:00', '2026-02-09 10:22:34'),
(54, 54, 7, 5, 'Unicorns: Latest Developments in Agriculture & Farming', 'unicorns-54', 'Key updates from the unicorns segment in agriculture & farming.', 'The unicorns category has seen major developments. Experts believe these changes could have long-term impact on agriculture & farming.', 'en', 'published', 0, 0, 15143, '2026-02-09 04:45:45', '2025-01-01 13:30:00', '2026-02-09 10:22:34'),
(55, 55, 8, 1, 'Incubators: Latest Developments in Food Security', 'incubators-55', 'Key updates from the incubators segment in food security.', 'The incubators category has seen major developments. Experts believe these changes could have long-term impact on food security.', 'en', 'published', 0, 0, 11313, '2026-02-09 04:45:45', '2025-01-01 13:40:00', '2026-02-09 10:22:34'),
(56, 56, 9, 2, 'MSME Policies: Latest Developments in Organic Farming', 'msme-policies-56', 'Key updates from the msme policies segment in organic farming.', 'The msme policies category has seen major developments. Experts believe these changes could have long-term impact on organic farming.', 'en', 'published', 0, 0, 10065, '2026-02-09 04:45:45', '2025-01-01 13:50:00', '2026-02-09 10:22:34'),
(57, 57, 10, 3, 'Entrepreneur Stories: Latest Developments in Agri Technology', 'entrepreneur-stories-57', 'Key updates from the entrepreneur stories segment in agri technology.', 'The entrepreneur stories category has seen major developments. Experts believe these changes could have long-term impact on agri technology.', 'en', 'published', 0, 0, 15396, '2026-02-09 04:45:45', '2025-01-01 14:00:00', '2026-02-09 10:22:34'),
(58, 58, 11, 4, 'Automobile: Latest Developments in Climate Change', 'automobile-58', 'Key updates from the automobile segment in climate change.', 'The automobile category has seen major developments. Experts believe these changes could have long-term impact on climate change.', 'en', 'published', 0, 0, 5629, '2026-02-09 04:45:45', '2025-01-01 14:10:00', '2026-02-09 10:22:34'),
(59, 59, 12, 5, 'Aviation: Latest Developments in Environmental Policy', 'aviation-59', 'Key updates from the aviation segment in environmental policy.', 'The aviation category has seen major developments. Experts believe these changes could have long-term impact on environmental policy.', 'en', 'published', 0, 0, 12006, '2026-02-09 04:45:45', '2025-01-01 14:20:00', '2026-02-09 10:22:34'),
(60, 60, 1, 1, 'Company News: Latest Developments in Wildlife Conservation', 'company-news-60', 'Key updates from the company news segment in wildlife conservation.', 'The company news category has seen major developments. Experts believe these changes could have long-term impact on wildlife conservation.', 'en', 'published', 0, 0, 12827, '2026-02-09 04:45:45', '2025-01-01 14:30:00', '2026-02-09 10:22:34'),
(61, 61, 2, 2, 'Earnings & Results: Latest Developments in Disaster Management', 'earnings-&-results-61', 'Key updates from the earnings & results segment in disaster management.', 'The earnings & results category has seen major developments. Experts believe these changes could have long-term impact on disaster management.', 'en', 'published', 0, 0, 17354, '2026-02-09 04:45:45', '2025-01-01 14:40:00', '2026-02-09 10:22:34'),
(62, 62, 3, 3, 'Mergers & Acquisitions: Latest Developments in Medical Research', 'mergers-&-acquisitions-62', 'Key updates from the mergers & acquisitions segment in medical research.', 'The mergers & acquisitions category has seen major developments. Experts believe these changes could have long-term impact on medical research.', 'en', 'published', 0, 0, 9581, '2026-02-09 04:45:45', '2025-01-01 14:50:00', '2026-02-09 10:22:34'),
(63, 63, 4, 4, 'Leadership & Appointments: Latest Developments in Public Health', 'leadership-&-appointments-63', 'Key updates from the leadership & appointments segment in public health.', 'The leadership & appointments category has seen major developments. Experts believe these changes could have long-term impact on public health.', 'en', 'published', 0, 0, 15767, '2026-02-09 04:45:45', '2025-01-01 15:00:00', '2026-02-09 10:22:34'),
(64, 64, 5, 5, 'Restructuring & Layoffs: Latest Developments in Mental Wellness', 'restructuring-&-layoffs-64', 'Key updates from the restructuring & layoffs segment in mental wellness.', 'The restructuring & layoffs category has seen major developments. Experts believe these changes could have long-term impact on mental wellness.', 'en', 'published', 0, 0, 12589, '2026-02-09 04:45:45', '2025-01-01 15:10:00', '2026-02-09 10:22:34'),
(65, 65, 6, 1, 'Startup Funding: Latest Developments in Nutrition & Diet', 'startup-funding-65', 'Key updates from the startup funding segment in nutrition & diet.', 'The startup funding category has seen major developments. Experts believe these changes could have long-term impact on nutrition & diet.', 'en', 'published', 0, 0, 2743, '2026-02-09 04:45:45', '2025-01-01 15:20:00', '2026-02-09 10:22:34'),
(66, 66, 7, 2, 'Unicorns: Latest Developments in Higher Education', 'unicorns-66', 'Key updates from the unicorns segment in higher education.', 'The unicorns category has seen major developments. Experts believe these changes could have long-term impact on higher education.', 'en', 'published', 0, 0, 7585, '2026-02-09 04:45:45', '2025-01-01 15:30:00', '2026-02-09 10:22:34'),
(67, 67, 8, 3, 'Incubators: Latest Developments in Online Learning', 'incubators-67', 'Key updates from the incubators segment in online learning.', 'The incubators category has seen major developments. Experts believe these changes could have long-term impact on online learning.', 'en', 'published', 0, 0, 9426, '2026-02-09 04:45:45', '2025-01-01 15:40:00', '2026-02-09 10:22:34'),
(68, 68, 9, 4, 'MSME Policies: Latest Developments in Skill Development', 'msme-policies-68', 'Key updates from the msme policies segment in skill development.', 'The msme policies category has seen major developments. Experts believe these changes could have long-term impact on skill development.', 'en', 'published', 0, 0, 16017, '2026-02-09 04:45:45', '2025-01-01 15:50:00', '2026-02-09 10:22:34'),
(69, 69, 10, 5, 'Entrepreneur Stories: Latest Developments in Vocational Training', 'entrepreneur-stories-69', 'Key updates from the entrepreneur stories segment in vocational training.', 'The entrepreneur stories category has seen major developments. Experts believe these changes could have long-term impact on vocational training.', 'en', 'published', 0, 0, 3663, '2026-02-09 04:45:45', '2025-01-01 16:00:00', '2026-02-09 10:22:34'),
(70, 70, 11, 1, 'Automobile: Latest Developments in Government Jobs', 'automobile-70', 'Key updates from the automobile segment in government jobs.', 'The automobile category has seen major developments. Experts believe these changes could have long-term impact on government jobs.', 'en', 'published', 0, 0, 8886, '2026-02-09 04:45:45', '2025-01-01 16:10:00', '2026-02-09 10:22:34'),
(71, 71, 12, 2, 'Aviation: Latest Developments in Private Jobs', 'aviation-71', 'Key updates from the aviation segment in private jobs.', 'The aviation category has seen major developments. Experts believe these changes could have long-term impact on private jobs.', 'en', 'published', 0, 0, 12289, '2026-02-09 04:45:45', '2025-01-01 16:20:00', '2026-02-09 10:22:34'),
(72, 72, 1, 3, 'Company News: Latest Developments in Startup Hiring', 'company-news-72', 'Key updates from the company news segment in startup hiring.', 'The company news category has seen major developments. Experts believe these changes could have long-term impact on startup hiring.', 'en', 'published', 0, 0, 6614, '2026-02-09 04:45:45', '2025-01-01 16:30:00', '2026-02-09 10:22:34'),
(73, 73, 2, 4, 'Earnings & Results: Latest Developments in Freelancing Economy', 'earnings-&-results-73', 'Key updates from the earnings & results segment in freelancing economy.', 'The earnings & results category has seen major developments. Experts believe these changes could have long-term impact on freelancing economy.', 'en', 'published', 0, 0, 6499, '2026-02-09 04:45:45', '2025-01-01 16:40:00', '2026-02-09 10:22:34'),
(74, 74, 3, 5, 'Mergers & Acquisitions: Latest Developments in Artificial Intelligence', 'mergers-&-acquisitions-74', 'Key updates from the mergers & acquisitions segment in artificial intelligence.', 'The mergers & acquisitions category has seen major developments. Experts believe these changes could have long-term impact on artificial intelligence.', 'en', 'published', 0, 0, 10756, '2026-02-09 04:45:45', '2025-01-01 16:50:00', '2026-02-09 10:22:34'),
(75, 75, 4, 1, 'Leadership & Appointments: Latest Developments in Machine Learning', 'leadership-&-appointments-75', 'Key updates from the leadership & appointments segment in machine learning.', 'The leadership & appointments category has seen major developments. Experts believe these changes could have long-term impact on machine learning.', 'en', 'published', 0, 0, 12519, '2026-02-09 04:45:45', '2025-01-01 17:00:00', '2026-02-09 10:22:34'),
(76, 76, 5, 2, 'Restructuring & Layoffs: Latest Developments in Data Science', 'restructuring-&-layoffs-76', 'Key updates from the restructuring & layoffs segment in data science.', 'The restructuring & layoffs category has seen major developments. Experts believe these changes could have long-term impact on data science.', 'en', 'published', 0, 0, 11606, '2026-02-09 04:45:45', '2025-01-01 17:10:00', '2026-02-09 10:22:34'),
(77, 77, 6, 3, 'Startup Funding: Latest Developments in Cloud Computing', 'startup-funding-77', 'Key updates from the startup funding segment in cloud computing.', 'The startup funding category has seen major developments. Experts believe these changes could have long-term impact on cloud computing.', 'en', 'published', 0, 0, 3317, '2026-02-09 04:45:45', '2025-01-01 17:20:00', '2026-02-09 10:22:34'),
(78, 78, 7, 4, 'Unicorns: Latest Developments in Cyber Security', 'unicorns-78', 'Key updates from the unicorns segment in cyber security.', 'The unicorns category has seen major developments. Experts believe these changes could have long-term impact on cyber security.', 'en', 'published', 0, 0, 3271, '2026-02-09 04:45:45', '2025-01-01 17:30:00', '2026-02-09 10:22:34'),
(79, 79, 8, 5, 'Incubators: Latest Developments in Blockchain Technology', 'incubators-79', 'Key updates from the incubators segment in blockchain technology.', 'The incubators category has seen major developments. Experts believe these changes could have long-term impact on blockchain technology.', 'en', 'published', 0, 0, 8219, '2026-02-09 04:45:45', '2025-01-01 17:40:00', '2026-02-09 10:22:34'),
(80, 80, 9, 1, 'MSME Policies: Latest Developments in Web Development', 'msme-policies-80', 'Key updates from the msme policies segment in web development.', 'The msme policies category has seen major developments. Experts believe these changes could have long-term impact on web development.', 'en', 'published', 0, 0, 2967, '2026-02-09 04:45:45', '2025-01-01 17:50:00', '2026-02-09 10:22:34'),
(81, 81, 10, 2, 'Entrepreneur Stories: Latest Developments in Mobile Applications', 'entrepreneur-stories-81', 'Key updates from the entrepreneur stories segment in mobile applications.', 'The entrepreneur stories category has seen major developments. Experts believe these changes could have long-term impact on mobile applications.', 'en', 'published', 0, 0, 8517, '2026-02-09 04:45:45', '2025-01-01 18:00:00', '2026-02-09 10:22:34'),
(82, 82, 11, 3, 'Automobile: Latest Developments in Social Media Trends', 'automobile-82', 'Key updates from the automobile segment in social media trends.', 'The automobile category has seen major developments. Experts believe these changes could have long-term impact on social media trends.', 'en', 'published', 0, 0, 6896, '2026-02-09 04:45:45', '2025-01-01 18:10:00', '2026-02-09 10:22:34'),
(83, 83, 12, 4, 'Aviation: Latest Developments in Influencer Economy', 'aviation-83', 'Key updates from the aviation segment in influencer economy.', 'The aviation category has seen major developments. Experts believe these changes could have long-term impact on influencer economy.', 'en', 'published', 0, 0, 9992, '2026-02-09 04:45:45', '2025-01-01 18:20:00', '2026-02-09 10:22:34'),
(84, 84, 1, 5, 'Company News: Latest Developments in Digital Marketing', 'company-news-84', 'Key updates from the company news segment in digital marketing.', 'The company news category has seen major developments. Experts believe these changes could have long-term impact on digital marketing.', 'en', 'published', 0, 0, 4108, '2026-02-09 04:45:45', '2025-01-01 18:30:00', '2026-02-09 10:22:34'),
(85, 85, 2, 1, 'Earnings & Results: Latest Developments in Online Advertising', 'earnings-&-results-85', 'Key updates from the earnings & results segment in online advertising.', 'The earnings & results category has seen major developments. Experts believe these changes could have long-term impact on online advertising.', 'en', 'published', 0, 0, 7942, '2026-02-09 04:45:45', '2025-01-01 18:40:00', '2026-02-09 10:22:34'),
(86, 86, 3, 2, 'Mergers & Acquisitions: Latest Developments in Media Ethics', 'mergers-&-acquisitions-86', 'Key updates from the mergers & acquisitions segment in media ethics.', 'The mergers & acquisitions category has seen major developments. Experts believe these changes could have long-term impact on media ethics.', 'en', 'published', 0, 0, 12521, '2026-02-09 04:45:45', '2025-01-01 18:50:00', '2026-02-09 10:22:34'),
(87, 87, 4, 3, 'Leadership & Appointments: Latest Developments in Press Freedom', 'leadership-&-appointments-87', 'Key updates from the leadership & appointments segment in press freedom.', 'The leadership & appointments category has seen major developments. Experts believe these changes could have long-term impact on press freedom.', 'en', 'published', 0, 0, 5670, '2026-02-09 04:45:45', '2025-01-01 19:00:00', '2026-02-09 10:22:34'),
(88, 88, 5, 4, 'Restructuring & Layoffs: Latest Developments in Journalism Standards', 'restructuring-&-layoffs-88', 'Key updates from the restructuring & layoffs segment in journalism standards.', 'The restructuring & layoffs category has seen major developments. Experts believe these changes could have long-term impact on journalism standards.', 'en', 'published', 0, 0, 3881, '2026-02-09 04:45:45', '2025-01-01 19:10:00', '2026-02-09 10:22:34'),
(89, 89, 6, 5, 'Startup Funding: Latest Developments in Content Regulation', 'startup-funding-89', 'Key updates from the startup funding segment in content regulation.', 'The startup funding category has seen major developments. Experts believe these changes could have long-term impact on content regulation.', 'en', 'published', 0, 0, 12149, '2026-02-09 04:45:45', '2025-01-01 19:20:00', '2026-02-09 10:22:34'),
(90, 90, 7, 1, 'Unicorns: Latest Developments in Film Industry', 'unicorns-90', 'Key updates from the unicorns segment in film industry.', 'The unicorns category has seen major developments. Experts believe these changes could have long-term impact on film industry.', 'en', 'published', 0, 0, 6142, '2026-02-09 04:45:45', '2025-01-01 19:30:00', '2026-02-09 10:22:34'),
(91, 91, 8, 2, 'Incubators: Latest Developments in Music Industry', 'incubators-91', 'Key updates from the incubators segment in music industry.', 'The incubators category has seen major developments. Experts believe these changes could have long-term impact on music industry.', 'en', 'published', 0, 0, 7858, '2026-02-09 04:45:45', '2025-01-01 19:40:00', '2026-02-09 10:22:34'),
(92, 92, 9, 3, 'MSME Policies: Latest Developments in Television Industry', 'msme-policies-92', 'Key updates from the msme policies segment in television industry.', 'The msme policies category has seen major developments. Experts believe these changes could have long-term impact on television industry.', 'en', 'published', 0, 0, 6806, '2026-02-09 04:45:45', '2025-01-01 19:50:00', '2026-02-09 10:22:34'),
(93, 93, 10, 4, 'Entrepreneur Stories: Latest Developments in OTT Platforms', 'entrepreneur-stories-93', 'Key updates from the entrepreneur stories segment in ott platforms.', 'The entrepreneur stories category has seen major developments. Experts believe these changes could have long-term impact on ott platforms.', 'en', 'published', 0, 0, 6488, '2026-02-09 04:45:45', '2025-01-01 20:00:00', '2026-02-09 10:22:34'),
(94, 94, 11, 5, 'Automobile: Latest Developments in Celebrity Lifestyle', 'automobile-94', 'Key updates from the automobile segment in celebrity lifestyle.', 'The automobile category has seen major developments. Experts believe these changes could have long-term impact on celebrity lifestyle.', 'en', 'published', 0, 0, 16484, '2026-02-09 04:45:45', '2025-01-01 20:10:00', '2026-02-09 10:22:34'),
(95, 95, 12, 1, 'Aviation: Latest Developments in Fashion & Beauty', 'aviation-95', 'Key updates from the aviation segment in fashion & beauty.', 'The aviation category has seen major developments. Experts believe these changes could have long-term impact on fashion & beauty.', 'en', 'published', 0, 0, 6762, '2026-02-09 04:45:45', '2025-01-01 20:20:00', '2026-02-09 10:22:34'),
(96, 96, 1, 2, 'Company News: Latest Developments in Luxury Lifestyle', 'company-news-96', 'Key updates from the company news segment in luxury lifestyle.', 'The company news category has seen major developments. Experts believe these changes could have long-term impact on luxury lifestyle.', 'en', 'published', 0, 0, 6406, '2026-02-09 04:45:45', '2025-01-01 20:30:00', '2026-02-09 10:22:34'),
(97, 97, 2, 3, 'Earnings & Results: Latest Developments in Travel Experiences', 'earnings-&-results-97', 'Key updates from the earnings & results segment in travel experiences.', 'The earnings & results category has seen major developments. Experts believe these changes could have long-term impact on travel experiences.', 'en', 'published', 0, 0, 16863, '2026-02-09 04:45:45', '2025-01-01 20:40:00', '2026-02-09 10:22:34'),
(98, 98, 3, 4, 'Mergers & Acquisitions: Latest Developments in Tourism Development', 'mergers-&-acquisitions-98', 'Key updates from the mergers & acquisitions segment in tourism development.', 'The mergers & acquisitions category has seen major developments. Experts believe these changes could have long-term impact on tourism development.', 'en', 'published', 0, 0, 13614, '2026-02-09 04:45:45', '2025-01-01 20:50:00', '2026-02-09 10:22:34'),
(99, 99, 4, 5, 'Leadership & Appointments: Latest Developments in Heritage Sites', 'leadership-&-appointments-99', 'Key updates from the leadership & appointments segment in heritage sites.', 'The leadership & appointments category has seen major developments. Experts believe these changes could have long-term impact on heritage sites.', 'en', 'published', 0, 0, 9219, '2026-02-09 04:45:45', '2025-01-01 21:00:00', '2026-02-09 10:22:34'),
(100, 100, 5, 1, 'Restructuring & Layoffs: Latest Developments in Pilgrimage Tourism', 'restructuring-&-layoffs-100', 'Key updates from the restructuring & layoffs segment in pilgrimage tourism.', 'The restructuring & layoffs category has seen major developments. Experts believe these changes could have long-term impact on pilgrimage tourism.', 'en', 'published', 0, 0, 13435, '2026-02-09 04:45:45', '2025-01-01 21:10:00', '2026-02-09 10:22:34'),
(101, 101, 6, 2, 'Startup Funding: Latest Developments in Eco Tourism', 'startup-funding-101', 'Key updates from the startup funding segment in eco tourism.', 'The startup funding category has seen major developments. Experts believe these changes could have long-term impact on eco tourism.', 'en', 'published', 0, 0, 6159, '2026-02-09 04:45:45', '2025-01-01 21:20:00', '2026-02-09 10:22:34'),
(102, 102, 7, 3, 'Unicorns: Latest Developments in Cricket Updates', 'unicorns-102', 'Key updates from the unicorns segment in cricket updates.', 'The unicorns category has seen major developments. Experts believe these changes could have long-term impact on cricket updates.', 'en', 'published', 0, 0, 11528, '2026-02-09 04:45:45', '2025-01-01 21:30:00', '2026-02-09 10:22:34'),
(103, 103, 8, 4, 'Incubators: Latest Developments in Football Leagues', 'incubators-103', 'Key updates from the incubators segment in football leagues.', 'The incubators category has seen major developments. Experts believe these changes could have long-term impact on football leagues.', 'en', 'published', 0, 0, 7156, '2026-02-09 04:45:45', '2025-01-01 21:40:00', '2026-02-09 10:22:34'),
(104, 104, 9, 5, 'MSME Policies: Latest Developments in Olympic Sports', 'msme-policies-104', 'Key updates from the msme policies segment in olympic sports.', 'The msme policies category has seen major developments. Experts believe these changes could have long-term impact on olympic sports.', 'en', 'published', 0, 0, 7974, '2026-02-09 04:45:45', '2025-01-01 21:50:00', '2026-02-09 10:22:34'),
(105, 105, 10, 1, 'Entrepreneur Stories: Latest Developments in Athlete Profiles', 'entrepreneur-stories-105', 'Key updates from the entrepreneur stories segment in athlete profiles.', 'The entrepreneur stories category has seen major developments. Experts believe these changes could have long-term impact on athlete profiles.', 'en', 'published', 0, 0, 8036, '2026-02-09 04:45:45', '2025-01-01 22:00:00', '2026-02-09 10:22:34'),
(106, 106, 11, 2, 'Automobile: Latest Developments in Esports Industry', 'automobile-106', 'Key updates from the automobile segment in esports industry.', 'The automobile category has seen major developments. Experts believe these changes could have long-term impact on esports industry.', 'en', 'published', 0, 0, 1189, '2026-02-09 04:45:45', '2025-01-01 22:10:00', '2026-02-09 10:22:34'),
(107, 107, 12, 3, 'Aviation: Latest Developments in Gaming Startups', 'aviation-107', 'Key updates from the aviation segment in gaming startups.', 'The aviation category has seen major developments. Experts believe these changes could have long-term impact on gaming startups.', 'en', 'published', 0, 0, 7870, '2026-02-09 04:45:45', '2025-01-01 22:20:00', '2026-02-09 10:22:34'),
(108, 108, 1, 4, 'Company News: Latest Developments in Game Reviews', 'company-news-108', 'Key updates from the company news segment in game reviews.', 'The company news category has seen major developments. Experts believe these changes could have long-term impact on game reviews.', 'en', 'published', 0, 0, 4620, '2026-02-09 04:45:45', '2025-01-01 22:30:00', '2026-02-09 10:22:34'),
(109, 109, 2, 5, 'Earnings & Results: Latest Developments in Streaming Platforms', 'earnings-&-results-109', 'Key updates from the earnings & results segment in streaming platforms.', 'The earnings & results category has seen major developments. Experts believe these changes could have long-term impact on streaming platforms.', 'en', 'published', 0, 0, 8481, '2026-02-09 04:45:45', '2025-01-01 22:40:00', '2026-02-09 10:22:34'),
(110, 110, 3, 1, 'Mergers & Acquisitions: Latest Developments in Space Missions', 'mergers-&-acquisitions-110', 'Key updates from the mergers & acquisitions segment in space missions.', 'The mergers & acquisitions category has seen major developments. Experts believe these changes could have long-term impact on space missions.', 'en', 'published', 0, 0, 5568, '2026-02-09 04:45:45', '2025-01-01 22:50:00', '2026-02-09 10:22:34'),
(111, 111, 4, 2, 'Leadership & Appointments: Latest Developments in Satellite Technology', 'leadership-&-appointments-111', 'Key updates from the leadership & appointments segment in satellite technology.', 'The leadership & appointments category has seen major developments. Experts believe these changes could have long-term impact on satellite technology.', 'en', 'published', 0, 0, 3857, '2026-02-09 04:45:45', '2025-01-01 23:00:00', '2026-02-09 10:22:34'),
(112, 112, 5, 3, 'Restructuring & Layoffs: Latest Developments in Astronomy Research', 'restructuring-&-layoffs-112', 'Key updates from the restructuring & layoffs segment in astronomy research.', 'The restructuring & layoffs category has seen major developments. Experts believe these changes could have long-term impact on astronomy research.', 'en', 'published', 0, 0, 9566, '2026-02-09 04:45:45', '2025-01-01 23:10:00', '2026-02-09 10:22:34'),
(113, 113, 6, 4, 'Startup Funding: Latest Developments in Astrophysics', 'startup-funding-113', 'Key updates from the startup funding segment in astrophysics.', 'The startup funding category has seen major developments. Experts believe these changes could have long-term impact on astrophysics.', 'en', 'published', 0, 0, 4294, '2026-02-09 04:45:45', '2025-01-01 23:20:00', '2026-02-09 10:22:34'),
(114, 114, 7, 5, 'Unicorns: Latest Developments in Scientific Discoveries', 'unicorns-114', 'Key updates from the unicorns segment in scientific discoveries.', 'The unicorns category has seen major developments. Experts believe these changes could have long-term impact on scientific discoveries.', 'en', 'published', 0, 0, 6644, '2026-02-09 04:45:45', '2025-01-01 23:30:00', '2026-02-09 10:22:34'),
(115, 115, 8, 1, 'Incubators: Latest Developments in Innovation Labs', 'incubators-115', 'Key updates from the incubators segment in innovation labs.', 'The incubators category has seen major developments. Experts believe these changes could have long-term impact on innovation labs.', 'en', 'published', 0, 0, 11558, '2026-02-09 04:45:45', '2025-01-01 23:40:00', '2026-02-09 10:22:34'),
(116, 116, 9, 2, 'MSME Policies: Latest Developments in Patent Research', 'msme-policies-116', 'Key updates from the msme policies segment in patent research.', 'The msme policies category has seen major developments. Experts believe these changes could have long-term impact on patent research.', 'en', 'published', 0, 0, 14002, '2026-02-09 04:45:45', '2025-01-01 23:50:00', '2026-02-09 10:22:34'),
(117, 117, 10, 3, 'Entrepreneur Stories: Latest Developments in R&D Investment', 'entrepreneur-stories-117', 'Key updates from the entrepreneur stories segment in r&d investment.', 'The entrepreneur stories category has seen major developments. Experts believe these changes could have long-term impact on r&d investment.', 'en', 'published', 0, 0, 8227, '2026-02-09 04:45:45', '2025-01-02 00:00:00', '2026-02-09 10:22:34'),
(118, 118, 11, 4, 'Automobile: Latest Developments in Spiritual Teachings', 'automobile-118', 'Key updates from the automobile segment in spiritual teachings.', 'The automobile category has seen major developments. Experts believe these changes could have long-term impact on spiritual teachings.', 'en', 'published', 0, 0, 7385, '2026-02-09 04:45:45', '2025-01-02 00:10:00', '2026-02-09 10:22:34'),
(119, 119, 12, 5, 'Aviation: Latest Developments in Meditation Practices', 'aviation-119', 'Key updates from the aviation segment in meditation practices.', 'The aviation category has seen major developments. Experts believe these changes could have long-term impact on meditation practices.', 'en', 'published', 0, 0, 12957, '2026-02-09 04:45:45', '2025-01-02 00:20:00', '2026-02-09 10:22:34'),
(120, 120, 1, 1, 'Company News: Latest Developments in Cultural Heritage', 'company-news-120', 'Key updates from the company news segment in cultural heritage.', 'The company news category has seen major developments. Experts believe these changes could have long-term impact on cultural heritage.', 'en', 'published', 0, 0, 11228, '2026-02-09 04:45:45', '2025-01-02 00:30:00', '2026-02-09 10:22:34'),
(121, 121, 2, 2, 'Earnings & Results: Latest Developments in Traditional Arts', 'earnings-&-results-121', 'Key updates from the earnings & results segment in traditional arts.', 'The earnings & results category has seen major developments. Experts believe these changes could have long-term impact on traditional arts.', 'en', 'published', 0, 0, 5720, '2026-02-09 04:45:45', '2025-01-02 00:40:00', '2026-02-09 10:22:34'),
(122, 122, 3, 3, 'Mergers & Acquisitions: Latest Developments in Temple Economy', 'mergers-&-acquisitions-122', 'Key updates from the mergers & acquisitions segment in temple economy.', 'The mergers & acquisitions category has seen major developments. Experts believe these changes could have long-term impact on temple economy.', 'en', 'published', 0, 0, 3080, '2026-02-09 04:45:45', '2025-01-02 00:50:00', '2026-02-09 10:22:34');
INSERT INTO `articles` (`id`, `category_id`, `subcategory_id`, `author_id`, `title`, `slug`, `short_description`, `full_content`, `language`, `status`, `is_breaking`, `is_trending`, `views`, `published_at`, `created_at`, `updated_at`) VALUES
(123, 123, 4, 4, 'Leadership & Appointments: Latest Developments in Festival Economy', 'leadership-&-appointments-123', 'Key updates from the leadership & appointments segment in festival economy.', 'The leadership & appointments category has seen major developments. Experts believe these changes could have long-term impact on festival economy.', 'en', 'published', 0, 0, 11909, '2026-02-09 04:45:45', '2025-01-02 01:00:00', '2026-02-09 10:22:34'),
(124, 124, 5, 5, 'Restructuring & Layoffs: Latest Developments in Religious Tourism', 'restructuring-&-layoffs-124', 'Key updates from the restructuring & layoffs segment in religious tourism.', 'The restructuring & layoffs category has seen major developments. Experts believe these changes could have long-term impact on religious tourism.', 'en', 'published', 0, 0, 12648, '2026-02-09 04:45:45', '2025-01-02 01:10:00', '2026-02-09 10:22:34'),
(125, 125, 6, 1, 'Startup Funding: Latest Developments in Cultural Festivals', 'startup-funding-125', 'Key updates from the startup funding segment in cultural festivals.', 'The startup funding category has seen major developments. Experts believe these changes could have long-term impact on cultural festivals.', 'en', 'published', 0, 0, 6273, '2026-02-09 04:45:45', '2025-01-02 01:20:00', '2026-02-09 10:22:34'),
(126, 126, 7, 2, 'Unicorns: Latest Developments in Urban Crime', 'unicorns-126', 'Key updates from the unicorns segment in urban crime.', 'The unicorns category has seen major developments. Experts believe these changes could have long-term impact on urban crime.', 'en', 'published', 0, 0, 8896, '2026-02-09 04:45:45', '2025-01-02 01:30:00', '2026-02-09 10:22:34'),
(127, 127, 8, 3, 'Incubators: Latest Developments in Cyber Fraud', 'incubators-127', 'Key updates from the incubators segment in cyber fraud.', 'The incubators category has seen major developments. Experts believe these changes could have long-term impact on cyber fraud.', 'en', 'published', 0, 0, 10131, '2026-02-09 04:45:45', '2025-01-02 01:40:00', '2026-02-09 10:22:34'),
(128, 128, 9, 4, 'MSME Policies: Latest Developments in Financial Scams', 'msme-policies-128', 'Key updates from the msme policies segment in financial scams.', 'The msme policies category has seen major developments. Experts believe these changes could have long-term impact on financial scams.', 'en', 'published', 0, 0, 9794, '2026-02-09 04:45:45', '2025-01-02 01:50:00', '2026-02-09 10:22:34'),
(129, 129, 10, 5, 'Entrepreneur Stories: Latest Developments in Legal Reforms', 'entrepreneur-stories-129', 'Key updates from the entrepreneur stories segment in legal reforms.', 'The entrepreneur stories category has seen major developments. Experts believe these changes could have long-term impact on legal reforms.', 'en', 'published', 0, 0, 3103, '2026-02-09 04:45:45', '2025-01-02 02:00:00', '2026-02-09 10:22:34'),
(130, 130, 11, 1, 'Automobile: Latest Developments in Court Judgments', 'automobile-130', 'Key updates from the automobile segment in court judgments.', 'The automobile category has seen major developments. Experts believe these changes could have long-term impact on court judgments.', 'en', 'published', 0, 0, 8834, '2026-02-09 04:45:45', '2025-01-02 02:10:00', '2026-02-09 10:22:34'),
(131, 131, 12, 2, 'Aviation: Latest Developments in Human Rights', 'aviation-131', 'Key updates from the aviation segment in human rights.', 'The aviation category has seen major developments. Experts believe these changes could have long-term impact on human rights.', 'en', 'published', 0, 0, 12248, '2026-02-09 04:45:45', '2025-01-02 02:20:00', '2026-02-09 10:22:34'),
(132, 132, 1, 3, 'Company News: Latest Developments in Women Safety', 'company-news-132', 'Key updates from the company news segment in women safety.', 'The company news category has seen major developments. Experts believe these changes could have long-term impact on women safety.', 'en', 'published', 0, 0, 5918, '2026-02-09 04:45:45', '2025-01-02 02:30:00', '2026-02-09 10:22:34'),
(133, 133, 2, 4, 'Earnings & Results: Latest Developments in Child Welfare', 'earnings-&-results-133', 'Key updates from the earnings & results segment in child welfare.', 'The earnings & results category has seen major developments. Experts believe these changes could have long-term impact on child welfare.', 'en', 'published', 0, 0, 4251, '2026-02-09 04:45:45', '2025-01-02 02:40:00', '2026-02-09 10:22:34'),
(134, 134, 3, 5, 'Mergers & Acquisitions: Latest Developments in NGO Activities', 'mergers-&-acquisitions-134', 'Key updates from the mergers & acquisitions segment in ngo activities.', 'The mergers & acquisitions category has seen major developments. Experts believe these changes could have long-term impact on ngo activities.', 'en', 'published', 0, 0, 16434, '2026-02-09 04:45:45', '2025-01-02 02:50:00', '2026-02-09 10:22:34'),
(135, 135, 4, 1, 'Leadership & Appointments: Latest Developments in Social Welfare', 'leadership-&-appointments-135', 'Key updates from the leadership & appointments segment in social welfare.', 'The leadership & appointments category has seen major developments. Experts believe these changes could have long-term impact on social welfare.', 'en', 'published', 0, 0, 8254, '2026-02-09 04:45:45', '2025-01-02 03:00:00', '2026-02-09 10:22:34'),
(136, 136, 5, 2, 'Restructuring & Layoffs: Latest Developments in Poverty Alleviation', 'restructuring-&-layoffs-136', 'Key updates from the restructuring & layoffs segment in poverty alleviation.', 'The restructuring & layoffs category has seen major developments. Experts believe these changes could have long-term impact on poverty alleviation.', 'en', 'published', 0, 0, 12287, '2026-02-09 04:45:45', '2025-01-02 03:10:00', '2026-02-09 10:22:34'),
(137, 137, 6, 3, 'Startup Funding: Latest Developments in Rural Healthcare', 'startup-funding-137', 'Key updates from the startup funding segment in rural healthcare.', 'The startup funding category has seen major developments. Experts believe these changes could have long-term impact on rural healthcare.', 'en', 'published', 0, 0, 11478, '2026-02-09 04:45:45', '2025-01-02 03:20:00', '2026-02-09 10:22:34'),
(138, 138, 7, 4, 'Unicorns: Latest Developments in Defense Technology', 'unicorns-138', 'Key updates from the unicorns segment in defense technology.', 'The unicorns category has seen major developments. Experts believe these changes could have long-term impact on defense technology.', 'en', 'published', 0, 0, 2468, '2026-02-09 04:45:45', '2025-01-02 03:30:00', '2026-02-09 10:22:34'),
(139, 139, 8, 5, 'Incubators: Latest Developments in Military Strategy', 'incubators-139', 'Key updates from the incubators segment in military strategy.', 'The incubators category has seen major developments. Experts believe these changes could have long-term impact on military strategy.', 'en', 'published', 0, 0, 11241, '2026-02-09 04:45:45', '2025-01-02 03:40:00', '2026-02-09 10:22:34'),
(140, 140, 9, 1, 'MSME Policies: Latest Developments in Border Security', 'msme-policies-140', 'Key updates from the msme policies segment in border security.', 'The msme policies category has seen major developments. Experts believe these changes could have long-term impact on border security.', 'en', 'published', 0, 0, 9128, '2026-02-09 04:45:45', '2025-01-02 03:50:00', '2026-02-09 10:22:34'),
(141, 141, 10, 2, 'Entrepreneur Stories: Latest Developments in National Security', 'entrepreneur-stories-141', 'Key updates from the entrepreneur stories segment in national security.', 'The entrepreneur stories category has seen major developments. Experts believe these changes could have long-term impact on national security.', 'en', 'published', 0, 0, 1684, '2026-02-09 04:45:45', '2025-01-02 04:00:00', '2026-02-09 10:22:34'),
(142, 142, 11, 3, 'Automobile: Latest Developments in Foreign Relations', 'automobile-142', 'Key updates from the automobile segment in foreign relations.', 'The automobile category has seen major developments. Experts believe these changes could have long-term impact on foreign relations.', 'en', 'published', 0, 0, 8764, '2026-02-09 04:45:45', '2025-01-02 04:10:00', '2026-02-09 10:22:34'),
(143, 143, 12, 4, 'Aviation: Latest Developments in Diplomatic Affairs', 'aviation-143', 'Key updates from the aviation segment in diplomatic affairs.', 'The aviation category has seen major developments. Experts believe these changes could have long-term impact on diplomatic affairs.', 'en', 'published', 0, 0, 14250, '2026-02-09 04:45:45', '2025-01-02 04:20:00', '2026-02-09 10:22:34'),
(144, 144, 1, 5, 'Company News: Latest Developments in Global Summits', 'company-news-144', 'Key updates from the company news segment in global summits.', 'The company news category has seen major developments. Experts believe these changes could have long-term impact on global summits.', 'en', 'published', 0, 0, 10662, '2026-02-09 04:45:45', '2025-01-02 04:30:00', '2026-02-09 10:22:34'),
(145, 145, 2, 1, 'Earnings & Results: Latest Developments in International Treaties', 'earnings-&-results-145', 'Key updates from the earnings & results segment in international treaties.', 'The earnings & results category has seen major developments. Experts believe these changes could have long-term impact on international treaties.', 'en', 'published', 0, 0, 5715, '2026-02-09 04:45:45', '2025-01-02 04:40:00', '2026-02-09 10:22:34'),
(146, 146, 3, 2, 'Mergers & Acquisitions: Latest Developments in Population Studies', 'mergers-&-acquisitions-146', 'Key updates from the mergers & acquisitions segment in population studies.', 'The mergers & acquisitions category has seen major developments. Experts believe these changes could have long-term impact on population studies.', 'en', 'published', 0, 0, 13144, '2026-02-09 04:45:45', '2025-01-02 04:50:00', '2026-02-09 10:22:34'),
(147, 147, 4, 3, 'Leadership & Appointments: Latest Developments in Migration Trends', 'leadership-&-appointments-147', 'Key updates from the leadership & appointments segment in migration trends.', 'The leadership & appointments category has seen major developments. Experts believe these changes could have long-term impact on migration trends.', 'en', 'published', 0, 0, 4036, '2026-02-09 04:45:45', '2025-01-02 05:00:00', '2026-02-09 10:22:34'),
(148, 148, 5, 4, 'Restructuring & Layoffs: Latest Developments in Urban Housing', 'restructuring-&-layoffs-148', 'Key updates from the restructuring & layoffs segment in urban housing.', 'The restructuring & layoffs category has seen major developments. Experts believe these changes could have long-term impact on urban housing.', 'en', 'published', 0, 0, 11934, '2026-02-09 04:45:45', '2025-01-02 05:10:00', '2026-02-09 10:22:34'),
(149, 149, 6, 5, 'Startup Funding: Latest Developments in Affordable Housing', 'startup-funding-149', 'Key updates from the startup funding segment in affordable housing.', 'The startup funding category has seen major developments. Experts believe these changes could have long-term impact on affordable housing.', 'en', 'published', 0, 0, 15312, '2026-02-09 04:45:45', '2025-01-02 05:20:00', '2026-02-09 10:22:34'),
(150, 150, 7, 1, 'Unicorns: Latest Developments in Real Estate Laws', 'unicorns-150', 'Key updates from the unicorns segment in real estate laws.', 'The unicorns category has seen major developments. Experts believe these changes could have long-term impact on real estate laws.', 'en', 'published', 0, 0, 8333, '2026-02-09 04:45:45', '2025-01-02 05:30:00', '2026-02-09 10:22:34'),
(151, 151, 8, 2, 'Incubators: Latest Developments in Property Investment', 'incubators-151', 'Key updates from the incubators segment in property investment.', 'The incubators category has seen major developments. Experts believe these changes could have long-term impact on property investment.', 'en', 'published', 0, 0, 5441, '2026-02-09 04:45:45', '2025-01-02 05:40:00', '2026-02-09 10:22:34'),
(152, 152, 9, 3, 'MSME Policies: Latest Developments in REIT Markets', 'msme-policies-152', 'Key updates from the msme policies segment in reit markets.', 'The msme policies category has seen major developments. Experts believe these changes could have long-term impact on reit markets.', 'en', 'published', 0, 0, 6665, '2026-02-09 04:45:45', '2025-01-02 05:50:00', '2026-02-09 10:22:34'),
(153, 153, 10, 4, 'Entrepreneur Stories: Latest Developments in Commercial Leasing', 'entrepreneur-stories-153', 'Key updates from the entrepreneur stories segment in commercial leasing.', 'The entrepreneur stories category has seen major developments. Experts believe these changes could have long-term impact on commercial leasing.', 'en', 'published', 0, 0, 13096, '2026-02-09 04:45:45', '2025-01-02 06:00:00', '2026-02-09 10:22:34'),
(154, 154, 11, 5, 'Automobile: Latest Developments in Consumer Rights', 'automobile-154', 'Key updates from the automobile segment in consumer rights.', 'The automobile category has seen major developments. Experts believe these changes could have long-term impact on consumer rights.', 'en', 'published', 0, 0, 9168, '2026-02-09 04:45:45', '2025-01-02 06:10:00', '2026-02-09 10:22:34'),
(155, 155, 12, 1, 'Aviation: Latest Developments in Product Reviews', 'aviation-155', 'Key updates from the aviation segment in product reviews.', 'The aviation category has seen major developments. Experts believe these changes could have long-term impact on product reviews.', 'en', 'published', 0, 0, 4441, '2026-02-09 04:45:45', '2025-01-02 06:20:00', '2026-02-09 10:22:34'),
(156, 156, 1, 2, 'Company News: Latest Developments in Brand Analysis', 'company-news-156', 'Key updates from the company news segment in brand analysis.', 'The company news category has seen major developments. Experts believe these changes could have long-term impact on brand analysis.', 'en', 'published', 0, 0, 6828, '2026-02-09 04:45:45', '2025-01-02 06:30:00', '2026-02-09 10:22:34'),
(157, 157, 2, 3, 'Earnings & Results: Latest Developments in Retail Trends', 'earnings-&-results-157', 'Key updates from the earnings & results segment in retail trends.', 'The earnings & results category has seen major developments. Experts believe these changes could have long-term impact on retail trends.', 'en', 'published', 0, 0, 9412, '2026-02-09 04:45:45', '2025-01-02 06:40:00', '2026-02-09 10:22:34'),
(158, 158, 3, 4, 'Mergers & Acquisitions: Latest Developments in E-commerce Platforms', 'mergers-&-acquisitions-158', 'Key updates from the mergers & acquisitions segment in e-commerce platforms.', 'The mergers & acquisitions category has seen major developments. Experts believe these changes could have long-term impact on e-commerce platforms.', 'en', 'published', 0, 0, 7697, '2026-02-09 04:45:45', '2025-01-02 06:50:00', '2026-02-09 10:22:34'),
(159, 159, 4, 5, 'Leadership & Appointments: Latest Developments in Marketplace Policies', 'leadership-&-appointments-159', 'Key updates from the leadership & appointments segment in marketplace policies.', 'The leadership & appointments category has seen major developments. Experts believe these changes could have long-term impact on marketplace policies.', 'en', 'published', 0, 0, 13545, '2026-02-09 04:45:45', '2025-01-02 07:00:00', '2026-02-09 10:22:34'),
(160, 160, 5, 1, 'Restructuring & Layoffs: Latest Developments in Cross-border Trade', 'restructuring-&-layoffs-160', 'Key updates from the restructuring & layoffs segment in cross-border trade.', 'The restructuring & layoffs category has seen major developments. Experts believe these changes could have long-term impact on cross-border trade.', 'en', 'published', 0, 0, 13481, '2026-02-09 04:45:45', '2025-01-02 07:10:00', '2026-02-09 10:22:34'),
(161, 161, 6, 2, 'Startup Funding: Latest Developments in Export Promotion', 'startup-funding-161', 'Key updates from the startup funding segment in export promotion.', 'The startup funding category has seen major developments. Experts believe these changes could have long-term impact on export promotion.', 'en', 'published', 0, 0, 12369, '2026-02-09 04:45:45', '2025-01-02 07:20:00', '2026-02-09 10:22:34'),
(162, 162, 7, 3, 'Unicorns: Latest Developments in Import Regulations', 'unicorns-162', 'Key updates from the unicorns segment in import regulations.', 'The unicorns category has seen major developments. Experts believe these changes could have long-term impact on import regulations.', 'en', 'published', 0, 0, 3132, '2026-02-09 04:45:45', '2025-01-02 07:30:00', '2026-02-09 10:22:34'),
(163, 163, 8, 4, 'Incubators: Latest Developments in Trade Logistics', 'incubators-163', 'Key updates from the incubators segment in trade logistics.', 'The incubators category has seen major developments. Experts believe these changes could have long-term impact on trade logistics.', 'en', 'published', 0, 0, 6490, '2026-02-09 04:45:45', '2025-01-02 07:40:00', '2026-02-09 10:22:34'),
(164, 164, 9, 5, 'MSME Policies: Latest Developments in Customs Policy', 'msme-policies-164', 'Key updates from the msme policies segment in customs policy.', 'The msme policies category has seen major developments. Experts believe these changes could have long-term impact on customs policy.', 'en', 'published', 0, 0, 7276, '2026-02-09 04:45:45', '2025-01-02 07:50:00', '2026-02-09 10:22:34'),
(165, 165, 10, 1, 'Entrepreneur Stories: Latest Developments in Shipping Industry', 'entrepreneur-stories-165', 'Key updates from the entrepreneur stories segment in shipping industry.', 'The entrepreneur stories category has seen major developments. Experts believe these changes could have long-term impact on shipping industry.', 'en', 'published', 0, 0, 8450, '2026-02-09 04:45:45', '2025-01-02 08:00:00', '2026-02-09 10:22:34'),
(166, 166, 11, 2, 'Automobile: Latest Developments in Ports Development', 'automobile-166', 'Key updates from the automobile segment in ports development.', 'The automobile category has seen major developments. Experts believe these changes could have long-term impact on ports development.', 'en', 'published', 0, 0, 13498, '2026-02-09 04:45:45', '2025-01-02 08:10:00', '2026-02-09 10:22:34'),
(167, 167, 12, 3, 'Aviation: Latest Developments in Maritime Security', 'aviation-167', 'Key updates from the aviation segment in maritime security.', 'The aviation category has seen major developments. Experts believe these changes could have long-term impact on maritime security.', 'en', 'published', 0, 0, 6199, '2026-02-09 04:45:45', '2025-01-02 08:20:00', '2026-02-09 10:22:34'),
(168, 168, 1, 4, 'Company News: Latest Developments in Fisheries Industry', 'company-news-168', 'Key updates from the company news segment in fisheries industry.', 'The company news category has seen major developments. Experts believe these changes could have long-term impact on fisheries industry.', 'en', 'published', 0, 0, 8903, '2026-02-09 04:45:45', '2025-01-02 08:30:00', '2026-02-09 10:22:34'),
(169, 169, 2, 5, 'Earnings & Results: Latest Developments in Blue Economy', 'earnings-&-results-169', 'Key updates from the earnings & results segment in blue economy.', 'The earnings & results category has seen major developments. Experts believe these changes could have long-term impact on blue economy.', 'en', 'published', 0, 0, 10190, '2026-02-09 04:45:45', '2025-01-02 08:40:00', '2026-02-09 10:22:34'),
(170, 170, 3, 1, 'Mergers & Acquisitions: Latest Developments in Startup Mentorship', 'mergers-&-acquisitions-170', 'Key updates from the mergers & acquisitions segment in startup mentorship.', 'The mergers & acquisitions category has seen major developments. Experts believe these changes could have long-term impact on startup mentorship.', 'en', 'published', 0, 0, 4836, '2026-02-09 04:45:45', '2025-01-02 08:50:00', '2026-02-09 10:22:34'),
(171, 171, 4, 2, 'Leadership & Appointments: Latest Developments in Incubators & Accelerators', 'leadership-&-appointments-171', 'Key updates from the leadership & appointments segment in incubators & accelerators.', 'The leadership & appointments category has seen major developments. Experts believe these changes could have long-term impact on incubators & accelerators.', 'en', 'published', 0, 0, 7147, '2026-02-09 04:45:45', '2025-01-02 09:00:00', '2026-02-09 10:22:34'),
(172, 172, 5, 3, 'Restructuring & Layoffs: Latest Developments in Innovation Hubs', 'restructuring-&-layoffs-172', 'Key updates from the restructuring & layoffs segment in innovation hubs.', 'The restructuring & layoffs category has seen major developments. Experts believe these changes could have long-term impact on innovation hubs.', 'en', 'published', 0, 0, 3304, '2026-02-09 04:45:45', '2025-01-02 09:10:00', '2026-02-09 10:22:34'),
(173, 173, 6, 4, 'Startup Funding: Latest Developments in Tech Parks', 'startup-funding-173', 'Key updates from the startup funding segment in tech parks.', 'The startup funding category has seen major developments. Experts believe these changes could have long-term impact on tech parks.', 'en', 'published', 0, 0, 7787, '2026-02-09 04:45:45', '2025-01-02 09:20:00', '2026-02-09 10:22:34'),
(174, 174, 7, 5, 'Unicorns: Latest Developments in Women Entrepreneurs', 'unicorns-174', 'Key updates from the unicorns segment in women entrepreneurs.', 'The unicorns category has seen major developments. Experts believe these changes could have long-term impact on women entrepreneurs.', 'en', 'published', 0, 0, 4829, '2026-02-09 04:45:45', '2025-01-02 09:30:00', '2026-02-09 10:22:34'),
(175, 175, 8, 1, 'Incubators: Latest Developments in Youth Startups', 'incubators-175', 'Key updates from the incubators segment in youth startups.', 'The incubators category has seen major developments. Experts believe these changes could have long-term impact on youth startups.', 'en', 'published', 0, 0, 11499, '2026-02-09 04:45:45', '2025-01-02 09:40:00', '2026-02-09 10:22:34'),
(176, 176, 9, 2, 'MSME Policies: Latest Developments in Rural Startups', 'msme-policies-176', 'Key updates from the msme policies segment in rural startups.', 'The msme policies category has seen major developments. Experts believe these changes could have long-term impact on rural startups.', 'en', 'published', 0, 0, 11425, '2026-02-09 04:45:45', '2025-01-02 09:50:00', '2026-02-09 10:22:34'),
(177, 177, 10, 3, 'Entrepreneur Stories: Latest Developments in Social Enterprises', 'entrepreneur-stories-177', 'Key updates from the entrepreneur stories segment in social enterprises.', 'The entrepreneur stories category has seen major developments. Experts believe these changes could have long-term impact on social enterprises.', 'en', 'published', 0, 0, 13257, '2026-02-09 04:45:45', '2025-01-02 10:00:00', '2026-02-09 10:22:34'),
(178, 178, 11, 4, 'Automobile: Latest Developments in Enterprise-wide uniform approach', 'automobile-178', 'Key updates from the automobile segment in enterprise-wide uniform approach.', 'The automobile category has seen major developments. Experts believe these changes could have long-term impact on enterprise-wide uniform approach.', 'en', 'published', 0, 0, 11398, '2026-02-09 04:45:45', '2025-01-02 10:10:00', '2026-02-09 10:22:34'),
(179, 179, 12, 5, 'Aviation: Latest Developments in Extended fresh-thinking interface', 'aviation-179', 'Key updates from the aviation segment in extended fresh-thinking interface.', 'The aviation category has seen major developments. Experts believe these changes could have long-term impact on extended fresh-thinking interface.', 'en', 'published', 0, 0, 2801, '2026-02-09 04:45:45', '2025-01-02 10:20:00', '2026-02-09 10:22:34'),
(180, 180, 1, 1, 'Company News: Latest Developments in Streamlined content-based initiative', 'company-news-180', 'Key updates from the company news segment in streamlined content-based initiative.', 'The company news category has seen major developments. Experts believe these changes could have long-term impact on streamlined content-based initiative.', 'en', 'published', 0, 0, 13230, '2026-02-09 04:45:45', '2025-01-02 10:30:00', '2026-02-09 10:22:34'),
(181, 181, 2, 2, 'Earnings & Results: Latest Developments in Synergistic methodical flexibility', 'earnings-&-results-181', 'Key updates from the earnings & results segment in synergistic methodical flexibility.', 'The earnings & results category has seen major developments. Experts believe these changes could have long-term impact on synergistic methodical flexibility.', 'en', 'published', 0, 0, 10496, '2026-02-09 04:45:45', '2025-01-02 10:40:00', '2026-02-09 10:22:34'),
(182, 182, 3, 3, 'Mergers & Acquisitions: Latest Developments in Reverse-engineered exuding contingency', 'mergers-&-acquisitions-182', 'Key updates from the mergers & acquisitions segment in reverse-engineered exuding contingency.', 'The mergers & acquisitions category has seen major developments. Experts believe these changes could have long-term impact on reverse-engineered exuding contingency.', 'en', 'published', 0, 0, 8362, '2026-02-09 04:45:45', '2025-01-02 10:50:00', '2026-02-09 10:22:34'),
(183, 183, 4, 4, 'Leadership & Appointments: Latest Developments in Operative interactive database', 'leadership-&-appointments-183', 'Key updates from the leadership & appointments segment in operative interactive database.', 'The leadership & appointments category has seen major developments. Experts believe these changes could have long-term impact on operative interactive database.', 'en', 'published', 0, 0, 3435, '2026-02-09 04:45:45', '2025-01-02 11:00:00', '2026-02-09 10:22:34'),
(184, 184, 5, 5, 'Restructuring & Layoffs: Latest Developments in Virtual 24/7 matrix', 'restructuring-&-layoffs-184', 'Key updates from the restructuring & layoffs segment in virtual 24/7 matrix.', 'The restructuring & layoffs category has seen major developments. Experts believe these changes could have long-term impact on virtual 24/7 matrix.', 'en', 'published', 0, 0, 5938, '2026-02-09 04:45:45', '2025-01-02 11:10:00', '2026-02-09 10:22:34'),
(185, 185, 6, 1, 'Startup Funding: Latest Developments in Pre-emptive transitional Local Area Network', 'startup-funding-185', 'Key updates from the startup funding segment in pre-emptive transitional local area network.', 'The startup funding category has seen major developments. Experts believe these changes could have long-term impact on pre-emptive transitional local area network.', 'en', 'published', 0, 0, 7803, '2026-02-09 04:45:45', '2025-01-02 11:20:00', '2026-02-09 10:22:34'),
(186, 186, 7, 2, 'Unicorns: Latest Developments in Upgradable motivating product', 'unicorns-186', 'Key updates from the unicorns segment in upgradable motivating product.', 'The unicorns category has seen major developments. Experts believe these changes could have long-term impact on upgradable motivating product.', 'en', 'published', 0, 0, 14024, '2026-02-09 04:45:45', '2025-01-02 11:30:00', '2026-02-09 10:22:34'),
(187, 187, 8, 3, 'Incubators: Latest Developments in Devolved attitude-oriented ability', 'incubators-187', 'Key updates from the incubators segment in devolved attitude-oriented ability.', 'The incubators category has seen major developments. Experts believe these changes could have long-term impact on devolved attitude-oriented ability.', 'en', 'published', 0, 0, 17559, '2026-02-09 04:45:45', '2025-01-02 11:40:00', '2026-02-09 10:22:34'),
(188, 188, 9, 4, 'MSME Policies: Latest Developments in Ameliorated client-server toolset', 'msme-policies-188', 'Key updates from the msme policies segment in ameliorated client-server toolset.', 'The msme policies category has seen major developments. Experts believe these changes could have long-term impact on ameliorated client-server toolset.', 'en', 'published', 0, 0, 6961, '2026-02-09 04:45:45', '2025-01-02 11:50:00', '2026-02-09 10:22:34'),
(189, 189, 10, 5, 'Entrepreneur Stories: Latest Developments in Balanced scalable emulation', 'entrepreneur-stories-189', 'Key updates from the entrepreneur stories segment in balanced scalable emulation.', 'The entrepreneur stories category has seen major developments. Experts believe these changes could have long-term impact on balanced scalable emulation.', 'en', 'published', 0, 0, 10469, '2026-02-09 04:45:45', '2025-01-02 12:00:00', '2026-02-09 10:22:34'),
(190, 190, 11, 1, 'Automobile: Latest Developments in Reverse-engineered next generation Graphic Interface', 'automobile-190', 'Key updates from the automobile segment in reverse-engineered next generation graphic interface.', 'The automobile category has seen major developments. Experts believe these changes could have long-term impact on reverse-engineered next generation graphic interface.', 'en', 'published', 0, 0, 2504, '2026-02-09 04:45:45', '2025-01-02 12:10:00', '2026-02-09 10:22:34'),
(191, 191, 12, 2, 'Aviation: Latest Developments in Phased static alliance', 'aviation-191', 'Key updates from the aviation segment in phased static alliance.', 'The aviation category has seen major developments. Experts believe these changes could have long-term impact on phased static alliance.', 'en', 'published', 0, 0, 8402, '2026-02-09 04:45:45', '2025-01-02 12:20:00', '2026-02-09 10:22:34'),
(192, 192, 1, 3, 'Company News: Latest Developments in Configurable motivating website', 'company-news-192', 'Key updates from the company news segment in configurable motivating website.', 'The company news category has seen major developments. Experts believe these changes could have long-term impact on configurable motivating website.', 'en', 'published', 0, 0, 4592, '2026-02-09 04:45:45', '2025-01-02 12:30:00', '2026-02-09 10:22:34'),
(193, 193, 2, 4, 'Earnings & Results: Latest Developments in Cross-platform modular matrices', 'earnings-&-results-193', 'Key updates from the earnings & results segment in cross-platform modular matrices.', 'The earnings & results category has seen major developments. Experts believe these changes could have long-term impact on cross-platform modular matrices.', 'en', 'published', 0, 0, 12255, '2026-02-09 04:45:45', '2025-01-02 12:40:00', '2026-02-09 10:22:34'),
(194, 194, 3, 5, 'Mergers & Acquisitions: Latest Developments in Exclusive zero tolerance process improvement', 'mergers-&-acquisitions-194', 'Key updates from the mergers & acquisitions segment in exclusive zero tolerance process improvement.', 'The mergers & acquisitions category has seen major developments. Experts believe these changes could have long-term impact on exclusive zero tolerance process improvement.', 'en', 'published', 0, 0, 1501, '2026-02-09 04:45:45', '2025-01-02 12:50:00', '2026-02-09 10:22:34'),
(195, 195, 4, 1, 'Leadership & Appointments: Latest Developments in Triple-buffered client-server groupware', 'leadership-&-appointments-195', 'Key updates from the leadership & appointments segment in triple-buffered client-server groupware.', 'The leadership & appointments category has seen major developments. Experts believe these changes could have long-term impact on triple-buffered client-server groupware.', 'en', 'published', 0, 0, 2205, '2026-02-09 04:45:45', '2025-01-02 13:00:00', '2026-02-09 10:22:34'),
(196, 196, 5, 2, 'Restructuring & Layoffs: Latest Developments in Triple-buffered interactive installation', 'restructuring-&-layoffs-196', 'Key updates from the restructuring & layoffs segment in triple-buffered interactive installation.', 'The restructuring & layoffs category has seen major developments. Experts believe these changes could have long-term impact on triple-buffered interactive installation.', 'en', 'published', 0, 0, 6446, '2026-02-09 04:45:45', '2025-01-02 13:10:00', '2026-02-09 10:22:34'),
(197, 197, 6, 3, 'Startup Funding: Latest Developments in Future-proofed incremental initiative', 'startup-funding-197', 'Key updates from the startup funding segment in future-proofed incremental initiative.', 'The startup funding category has seen major developments. Experts believe these changes could have long-term impact on future-proofed incremental initiative.', 'en', 'published', 0, 0, 13124, '2026-02-09 04:45:45', '2025-01-02 13:20:00', '2026-02-09 10:22:34'),
(198, 198, 7, 4, 'Unicorns: Latest Developments in Reduced analyzing open architecture', 'unicorns-198', 'Key updates from the unicorns segment in reduced analyzing open architecture.', 'The unicorns category has seen major developments. Experts believe these changes could have long-term impact on reduced analyzing open architecture.', 'en', 'published', 0, 0, 2151, '2026-02-09 04:45:45', '2025-01-02 13:30:00', '2026-02-09 10:22:34'),
(199, 199, 8, 5, 'Incubators: Latest Developments in Upgradable analyzing service-desk', 'incubators-199', 'Key updates from the incubators segment in upgradable analyzing service-desk.', 'The incubators category has seen major developments. Experts believe these changes could have long-term impact on upgradable analyzing service-desk.', 'en', 'published', 0, 0, 11641, '2026-02-09 04:45:45', '2025-01-02 13:40:00', '2026-02-09 10:22:34'),
(200, 200, 9, 1, 'MSME Policies: Latest Developments in Re-contextualized fault-tolerant encoding', 'msme-policies-200', 'Key updates from the msme policies segment in re-contextualized fault-tolerant encoding.', 'The msme policies category has seen major developments. Experts believe these changes could have long-term impact on re-contextualized fault-tolerant encoding.', 'en', 'published', 0, 0, 8393, '2026-02-24 02:46:49', '2025-01-02 13:50:00', '2026-02-24 02:46:49'),
(205, 1, 1, 203, 'Key Company News', 'key-company-news', 'As of February 23, 2026, several major companies have released significant news regarding leadership changes, infrastructure expansion, and financial incidents.', 'Microsoft: Named Asha Sharma as the new CEO of Microsoft Gaming, succeeding Phil Spencer who is retiring after nearly 40 years. Sharma previously led Microsoft’s CoreAI product group and is tasked with integrating AI innovation into the Xbox ecosystem while navigating rising costs and stiff competition.\r\nAmazon: Officially inaugurated its second-largest office in Asia in North Bengaluru today. The 1.1 million-square-foot campus can accommodate over 7,000 employees and underscores Amazon\'s plan to invest an additional $35 billion in India by 2030.\r\nIDFC First Bank: Reported a suspected ₹590 crore fraud involving Haryana government accounts at its Chandigarh branch. The bank has suspended four employees and appointed KPMG for a forensic audit, asserting that it has adequate buffers to absorb the impact.\r\nUrban Company: Announced that its quick-service housekeeping vertical, InstaHelp, crossed a milestone of 51,520 daily bookings on February 22, 2026, less than a year after its pilot launch.\r\nApple: Announced plans to open a new retail store in Mumbai on February 26, 2026. Reports also indicate Apple is preparing a \"special experience\" event on March 4 to launch at least five new products, including a potential low-cost MacBook and the iPhone 17e.\r\nNvidia: Investors are focused on the upcoming earnings report on February 25, with Wall Street expecting revenue of approximately $65.7 billion.', NULL, 'pending', 0, 0, 0, NULL, '2026-02-23 04:40:58', '2026-02-24 07:33:38');

-- --------------------------------------------------------

--
-- Table structure for table `article_media`
--

CREATE TABLE `article_media` (
  `id` bigint(20) NOT NULL,
  `article_id` bigint(20) NOT NULL,
  `type` enum('image','video','audio','document') NOT NULL,
  `file_url` varchar(500) NOT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `size` bigint(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `article_media`
--

INSERT INTO `article_media` (`id`, `article_id`, `type`, `file_url`, `thumbnail`, `duration`, `size`, `created_at`) VALUES
(1, 1, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media1/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(2, 2, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(3, 3, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(4, 4, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(5, 5, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media5/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(6, 6, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(7, 7, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(8, 8, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(9, 9, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media9/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(10, 10, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(11, 11, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(12, 12, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(13, 13, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media13/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(14, 14, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(15, 15, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(16, 16, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(17, 17, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media17/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(18, 18, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(19, 19, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(20, 20, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(21, 21, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media21/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(22, 22, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(23, 23, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(24, 24, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(25, 25, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media25/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(26, 26, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(27, 27, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(28, 28, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(29, 29, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media29/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(30, 30, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(31, 31, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(32, 32, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(33, 33, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media33/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(34, 34, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(35, 35, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(36, 36, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(37, 37, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media37/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(38, 38, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(39, 39, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(40, 40, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(41, 41, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media41/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(42, 42, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(43, 43, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(44, 44, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(45, 45, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media45/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(46, 46, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(47, 47, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(48, 48, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(49, 49, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media49/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(50, 50, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(51, 51, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(52, 52, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(53, 53, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media53/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(54, 54, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(55, 55, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(56, 56, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(57, 57, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media57/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(58, 58, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(59, 59, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(60, 60, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(61, 61, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media61/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(62, 62, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(63, 63, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(64, 64, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(65, 65, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media65/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(66, 66, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(67, 67, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(68, 68, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(69, 69, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media69/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(70, 70, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(71, 71, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(72, 72, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(73, 73, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media73/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(74, 74, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(75, 75, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(76, 76, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(77, 77, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media77/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(78, 78, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(79, 79, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(80, 80, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(81, 81, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media81/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(82, 82, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(83, 83, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(84, 84, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(85, 85, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media85/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(86, 86, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(87, 87, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(88, 88, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(89, 89, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media89/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(90, 90, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(91, 91, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(92, 92, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(93, 93, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media93/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(94, 94, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(95, 95, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(96, 96, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(97, 97, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media97/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(98, 98, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(99, 99, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(100, 100, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(101, 101, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media101/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(102, 102, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(103, 103, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(104, 104, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(105, 105, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media105/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(106, 106, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(107, 107, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(108, 108, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(109, 109, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media109/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(110, 110, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(111, 111, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(112, 112, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(113, 113, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media113/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(114, 114, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(115, 115, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(116, 116, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(117, 117, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media117/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(118, 118, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(119, 119, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(120, 120, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(121, 121, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media121/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(122, 122, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(123, 123, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(124, 124, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(125, 125, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media125/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(126, 126, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(127, 127, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(128, 128, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(129, 129, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media129/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(130, 130, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(131, 131, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(132, 132, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(133, 133, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media133/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(134, 134, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(135, 135, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(136, 136, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(137, 137, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media137/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(138, 138, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(139, 139, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(140, 140, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(141, 141, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media141/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(142, 142, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(143, 143, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(144, 144, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(145, 145, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media145/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(146, 146, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(147, 147, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(148, 148, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(149, 149, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media149/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(150, 150, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(151, 151, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(152, 152, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(153, 153, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media153/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(154, 154, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(155, 155, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(156, 156, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(157, 157, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media157/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(158, 158, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(159, 159, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(160, 160, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(161, 161, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media161/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(162, 162, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(163, 163, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(164, 164, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(165, 165, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media165/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(166, 166, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(167, 167, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(168, 168, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(169, 169, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media169/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(170, 170, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(171, 171, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(172, 172, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(173, 173, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media173/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(174, 174, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(175, 175, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(176, 176, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(177, 177, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media177/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(178, 178, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(179, 179, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(180, 180, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(181, 181, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media181/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(182, 182, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(183, 183, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(184, 184, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(185, 185, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media185/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(186, 186, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(187, 187, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(188, 188, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(189, 189, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media189/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(190, 190, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(191, 191, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(192, 192, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(193, 193, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media193/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(194, 194, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(195, 195, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(196, 196, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(197, 197, 'image', 'images/news/pic.jpg', 'https://picsum.photos/seed/media197/400/300', NULL, 200000, '2026-02-04 08:35:13'),
(198, 198, 'video', 'video/vid.mp4', 'https://peach.blender.org/wp-content/uploads/title_anouncement.jpg', '00:09:56', 15800000, '2026-02-04 08:35:13'),
(199, 199, 'audio', 'audio/audio.mp3', NULL, '00:05:30', 8700000, '2026-02-04 08:35:13'),
(200, 200, 'document', 'document/pdf.pdf', NULL, NULL, 204800, '2026-02-04 08:35:13'),
(209, 205, 'image', 'images/news/1771851111_699c4d67e7dac.png', NULL, NULL, 2014100, '2026-02-23 12:51:51');

-- --------------------------------------------------------

--
-- Table structure for table `bookmarks`
--

CREATE TABLE `bookmarks` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `article_id` bigint(20) DEFAULT NULL,
  `page_location` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookmarks`
--

INSERT INTO `bookmarks` (`id`, `user_id`, `article_id`, `page_location`, `created_at`) VALUES
(1, 2, 1, '', '2026-01-10 03:45:00'),
(2, 2, 55, '', '2026-01-11 04:50:00'),
(3, 2, 110, '', '2026-01-12 05:35:00'),
(4, 4, 2, '', '2026-01-10 09:00:00'),
(5, 4, 60, '', '2026-01-15 03:15:00'),
(6, 4, 199, '', '2026-02-01 06:30:00'),
(7, 6, 3, '', '2026-01-12 10:52:00'),
(8, 6, 150, '', '2026-01-20 13:40:00'),
(9, 6, 45, '', '2026-01-25 15:30:00'),
(10, 7, 4, '', '2026-01-05 06:30:00'),
(11, 7, 12, '', '2026-01-06 07:30:00'),
(12, 7, 88, '', '2026-02-02 04:30:00'),
(13, 8, 5, '', '2026-01-08 06:00:00'),
(14, 8, 175, '', '2026-01-14 03:45:00'),
(15, 8, 20, '', '2026-01-30 10:15:00'),
(16, 12, 6, '', '2026-01-20 02:30:00'),
(17, 12, 44, '', '2026-01-21 03:30:00'),
(18, 12, 101, '', '2026-01-25 08:30:00'),
(19, 14, 7, '', '2026-01-15 12:00:00'),
(20, 14, 5, '', '2026-01-16 12:30:00'),
(21, 14, 190, '', '2026-01-18 13:50:00'),
(22, 15, 8, '', '2026-01-10 04:30:00'),
(23, 15, 9, '', '2026-01-11 05:30:00'),
(24, 15, 10, '', '2026-01-12 06:30:00'),
(25, 16, 11, '', '2026-01-13 07:30:00'),
(26, 16, 12, '', '2026-01-14 08:30:00'),
(27, 16, 13, '', '2026-01-15 09:30:00'),
(28, 17, 14, '', '2026-01-16 10:30:00'),
(29, 17, 15, '', '2026-01-17 11:30:00'),
(30, 17, 16, '', '2026-01-18 12:30:00'),
(31, 19, 17, '', '2026-01-19 13:30:00'),
(32, 19, 18, '', '2026-01-20 14:30:00'),
(33, 19, 19, '', '2026-01-21 15:30:00'),
(34, 22, 21, '', '2026-01-22 03:30:00'),
(35, 22, 22, '', '2026-01-23 04:30:00'),
(36, 22, 23, '', '2026-01-24 05:30:00'),
(37, 23, 24, '', '2026-01-25 06:30:00'),
(38, 23, 25, '', '2026-01-26 07:30:00'),
(39, 23, 26, '', '2026-01-27 08:30:00'),
(40, 25, 27, '', '2026-01-28 09:30:00'),
(41, 25, 28, '', '2026-01-29 10:30:00'),
(42, 25, 29, '', '2026-01-30 11:30:00'),
(43, 29, 31, '', '2026-01-31 12:30:00'),
(44, 29, 32, '', '2026-02-01 13:30:00'),
(45, 29, 33, '', '2026-02-02 14:30:00'),
(46, 30, 34, '', '2026-02-03 15:30:00'),
(47, 30, 35, '', '2026-02-04 03:30:00'),
(48, 30, 36, '', '2026-02-04 04:30:00'),
(49, 34, 37, '', '2026-01-05 05:30:00'),
(50, 34, 38, '', '2026-01-06 06:30:00'),
(51, 34, 39, '', '2026-01-07 07:30:00'),
(52, 36, 40, '', '2026-01-08 08:30:00'),
(53, 36, 41, '', '2026-01-09 09:30:00'),
(54, 36, 42, '', '2026-01-10 10:30:00'),
(55, 37, 43, '', '2026-01-11 11:30:00'),
(56, 37, 44, '', '2026-01-12 12:30:00'),
(57, 37, 45, '', '2026-01-13 13:30:00'),
(58, 41, 46, '', '2026-01-14 14:30:00'),
(59, 41, 47, '', '2026-01-15 15:30:00'),
(60, 41, 48, '', '2026-01-16 03:30:00'),
(61, 42, 49, '', '2026-01-17 04:30:00'),
(62, 42, 50, '', '2026-01-18 05:30:00'),
(63, 42, 51, '', '2026-01-19 06:30:00'),
(64, 45, 52, '', '2026-01-20 07:30:00'),
(65, 45, 53, '', '2026-01-21 08:30:00'),
(66, 45, 54, '', '2026-01-22 09:30:00'),
(67, 47, 56, '', '2026-01-23 10:30:00'),
(68, 47, 57, '', '2026-01-24 11:30:00'),
(69, 47, 58, '', '2026-01-25 12:30:00'),
(70, 49, 59, '', '2026-01-26 13:30:00'),
(71, 49, 61, '', '2026-01-27 14:30:00'),
(72, 49, 62, '', '2026-01-28 15:30:00'),
(73, 50, 63, '', '2026-01-29 03:30:00'),
(74, 50, 64, '', '2026-01-30 04:30:00'),
(75, 50, 65, '', '2026-01-31 05:30:00'),
(76, 52, 66, '', '2026-02-01 06:30:00'),
(77, 52, 67, '', '2026-02-02 07:30:00'),
(78, 52, 68, '', '2026-02-03 08:30:00'),
(79, 2, 69, '', '2026-01-05 09:30:00'),
(80, 4, 70, '', '2026-01-06 10:30:00'),
(81, 6, 71, '', '2026-01-07 11:30:00'),
(82, 7, 72, '', '2026-01-08 12:30:00'),
(83, 8, 73, '', '2026-01-09 13:30:00'),
(84, 12, 74, '', '2026-01-10 14:30:00'),
(85, 14, 75, '', '2026-01-11 15:30:00'),
(86, 15, 76, '', '2026-01-12 03:30:00'),
(87, 16, 77, '', '2026-01-13 04:30:00'),
(88, 17, 78, '', '2026-01-14 05:30:00'),
(89, 19, 79, '', '2026-01-15 06:30:00'),
(90, 22, 80, '', '2026-01-16 07:30:00'),
(91, 23, 81, '', '2026-01-17 08:30:00'),
(92, 25, 82, '', '2026-01-18 09:30:00'),
(93, 29, 83, '', '2026-01-19 10:30:00'),
(94, 30, 84, '', '2026-01-20 11:30:00'),
(95, 34, 85, '', '2026-01-21 12:30:00'),
(96, 36, 86, '', '2026-01-22 13:30:00'),
(97, 37, 87, '', '2026-01-23 14:30:00'),
(98, 41, 89, '', '2026-01-24 15:30:00'),
(99, 42, 90, '', '2026-01-25 03:30:00'),
(100, 45, 91, '', '2026-01-26 04:30:00'),
(101, 47, 92, '', '2026-01-27 05:30:00'),
(102, 49, 93, '', '2026-01-28 06:30:00'),
(103, 50, 94, '', '2026-01-29 07:30:00'),
(104, 52, 95, '', '2026-01-30 08:30:00'),
(105, 2, 96, '', '2026-01-31 09:30:00'),
(106, 4, 97, '', '2026-02-01 10:30:00'),
(107, 6, 98, '', '2026-02-02 11:30:00'),
(108, 7, 99, '', '2026-02-03 12:30:00'),
(109, 8, 100, '', '2026-02-04 09:30:00'),
(110, 12, 102, '', '2026-01-05 09:30:00'),
(111, 14, 103, '', '2026-01-06 10:30:00'),
(112, 15, 104, '', '2026-01-07 11:30:00'),
(113, 16, 105, '', '2026-01-08 12:30:00'),
(114, 17, 106, '', '2026-01-09 13:30:00'),
(115, 19, 107, '', '2026-01-10 14:30:00'),
(116, 22, 108, '', '2026-01-11 15:30:00'),
(117, 23, 109, '', '2026-01-12 03:30:00'),
(118, 25, 111, '', '2026-01-13 04:30:00'),
(119, 29, 112, '', '2026-01-14 05:30:00'),
(120, 30, 113, '', '2026-01-15 06:30:00'),
(121, 34, 114, '', '2026-01-16 07:30:00'),
(122, 36, 115, '', '2026-01-17 08:30:00'),
(123, 37, 116, '', '2026-01-18 09:30:00'),
(124, 41, 117, '', '2026-01-19 10:30:00'),
(125, 42, 118, '', '2026-01-20 11:30:00'),
(126, 45, 119, '', '2026-01-21 12:30:00'),
(127, 47, 120, '', '2026-01-22 13:30:00'),
(128, 49, 121, '', '2026-01-23 14:30:00'),
(129, 50, 122, '', '2026-01-24 15:30:00'),
(130, 52, 123, '', '2026-01-25 03:30:00'),
(131, 2, 124, '', '2026-01-26 04:30:00'),
(132, 4, 125, '', '2026-01-27 05:30:00'),
(133, 6, 126, '', '2026-01-28 06:30:00'),
(134, 7, 127, '', '2026-01-29 07:30:00'),
(135, 8, 128, '', '2026-01-30 08:30:00'),
(136, 12, 130, '', '2026-01-31 09:30:00'),
(137, 14, 131, '', '2026-02-01 10:30:00'),
(138, 15, 132, '', '2026-02-02 11:30:00'),
(139, 16, 133, '', '2026-02-03 12:30:00'),
(140, 17, 134, '', '2026-02-04 09:30:00'),
(141, 19, 135, '', '2026-01-05 09:30:00'),
(142, 22, 136, '', '2026-01-06 10:30:00'),
(143, 23, 137, '', '2026-01-07 11:30:00'),
(144, 25, 138, '', '2026-01-08 12:30:00'),
(145, 29, 139, '', '2026-01-09 13:30:00'),
(146, 30, 140, '', '2026-01-10 14:30:00'),
(147, 34, 141, '', '2026-01-11 15:30:00'),
(148, 36, 142, '', '2026-01-12 03:30:00'),
(149, 37, 143, '', '2026-01-13 04:30:00'),
(150, 41, 144, '', '2026-01-14 05:30:00'),
(151, 42, 145, '', '2026-01-15 06:30:00'),
(152, 45, 146, '', '2026-01-16 07:30:00'),
(153, 47, 147, '', '2026-01-17 08:30:00'),
(154, 49, 148, '', '2026-01-18 09:30:00'),
(155, 50, 149, '', '2026-01-19 10:30:00'),
(156, 52, 151, '', '2026-01-20 11:30:00'),
(157, 2, 152, '', '2026-01-21 12:30:00'),
(158, 4, 153, '', '2026-01-22 13:30:00'),
(159, 6, 154, '', '2026-01-23 14:30:00'),
(160, 7, 155, '', '2026-01-24 15:30:00'),
(161, 8, 156, '', '2026-01-25 03:30:00'),
(162, 12, 157, '', '2026-01-26 04:30:00'),
(163, 14, 158, '', '2026-01-27 05:30:00'),
(164, 15, 159, '', '2026-01-28 06:30:00'),
(165, 16, 160, '', '2026-01-29 07:30:00'),
(166, 17, 161, '', '2026-01-30 08:30:00'),
(167, 19, 162, '', '2026-01-31 09:30:00'),
(168, 22, 163, '', '2026-02-01 10:30:00'),
(169, 23, 164, '', '2026-02-02 11:30:00'),
(170, 25, 165, '', '2026-02-03 12:30:00'),
(171, 29, 166, '', '2026-01-05 09:30:00'),
(172, 30, 167, '', '2026-01-06 10:30:00'),
(173, 34, 168, '', '2026-01-07 11:30:00'),
(174, 36, 169, '', '2026-01-08 12:30:00'),
(175, 37, 170, '', '2026-01-09 13:30:00'),
(176, 41, 171, '', '2026-01-10 14:30:00'),
(177, 42, 172, '', '2026-01-11 15:30:00'),
(178, 45, 173, '', '2026-01-12 03:30:00'),
(179, 47, 174, '', '2026-01-13 04:30:00'),
(180, 49, 176, '', '2026-01-14 05:30:00'),
(181, 50, 177, '', '2026-01-15 06:30:00'),
(182, 52, 178, '', '2026-01-16 07:30:00'),
(183, 2, 179, '', '2026-01-17 08:30:00'),
(184, 4, 180, '', '2026-01-18 09:30:00'),
(185, 6, 181, '', '2026-01-19 10:30:00'),
(186, 7, 182, '', '2026-01-20 11:30:00'),
(187, 8, 183, '', '2026-01-21 12:30:00'),
(188, 12, 184, '', '2026-01-22 13:30:00'),
(189, 14, 185, '', '2026-01-23 14:30:00'),
(190, 15, 186, '', '2026-01-24 15:30:00'),
(191, 16, 187, '', '2026-01-25 03:30:00'),
(192, 17, 188, '', '2026-01-26 04:30:00'),
(193, 19, 189, '', '2026-01-27 05:30:00'),
(194, 22, 191, '', '2026-01-28 06:30:00'),
(195, 23, 192, '', '2026-01-29 07:30:00'),
(196, 25, 193, '', '2026-01-30 08:30:00'),
(197, 29, 194, '', '2026-01-31 09:30:00'),
(198, 30, 195, '', '2026-02-01 10:30:00'),
(199, 34, 196, '', '2026-02-02 11:30:00'),
(200, 36, 197, '', '2026-02-03 12:30:00'),
(201, 37, 198, '', '2026-02-04 09:30:00'),
(202, 41, 200, '', '2026-01-05 09:30:00'),
(203, 42, 1, '', '2026-01-06 10:30:00'),
(207, 205, 1, NULL, '2026-02-28 11:25:32');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) NOT NULL,
  `name` varchar(150) DEFAULT NULL,
  `slug` varchar(150) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `icon`, `status`, `created_at`) VALUES
(1, 'Business', 'business', 'icon-001.svg', 1, '2021-03-19 17:19:30'),
(2, 'Markets', 'markets', 'icon-002.svg', 1, '2024-06-20 23:59:38'),
(3, 'Wealth', 'wealth', 'icon-003.svg', 1, '2026-02-09 06:40:05'),
(4, 'World / Global', 'world--global', 'icon-004.svg', 1, '2025-10-30 22:46:09'),
(5, 'Personal Finance', 'personal-finance', 'icon-005.svg', 1, '2021-01-11 19:36:59'),
(6, 'Startups & Tech', 'startups-and-tech', 'icon-006.svg', 1, '2022-05-11 04:52:40'),
(7, 'Industry & Energy', 'industry-and-energy', 'icon-007.svg', 1, '2022-11-29 13:50:01'),
(8, 'Politics & Governance', 'politics-and-governance', 'icon-008.svg', 1, '2025-02-08 11:14:30'),
(9, 'Education, Universities & Careers', 'education-universities-and-careers', 'icon-009.svg', 1, '2022-02-14 08:57:56'),
(10, 'Health & Science', 'health-and-science', 'icon-010.svg', 1, '2023-10-29 19:40:48'),
(11, 'Real Estate & Infrastructure', 'real-estate-and-infrastructure', 'icon-011.svg', 1, '2022-03-27 11:16:54'),
(12, 'Food, Travel & Lifestyle', 'food-travel-and-lifestyle', 'icon-012.svg', 1, '2024-02-09 04:07:41'),
(13, 'Digital & Media', 'digital-and-media', 'icon-013.svg', 1, '2022-12-17 14:00:49'),
(14, 'Opinion & Insights', 'opinion-and-insights', 'icon-014.svg', 1, '2022-10-03 16:08:12'),
(15, 'Learning Hub', 'learning-hub', 'icon-015.svg', 1, '2022-02-09 19:08:11'),
(16, 'Data & Tools', 'data-and-tools', 'icon-016.svg', 1, '2022-01-02 04:16:36'),
(17, 'Special Projects', 'special-projects', 'icon-017.svg', 1, '2022-12-20 19:03:19'),
(18, 'Regional & State Hot Picks', 'regional-and-state-hot-picks', 'icon-018.svg', 1, '2021-01-07 02:49:24'),
(19, 'Crime & Justice', 'crime-and-justice', 'icon-019.svg', 1, '2023-03-28 10:05:34'),
(20, 'Celebrities & Entertainment', 'celebrities-and-entertainment', 'icon-020.svg', 1, '2025-11-12 07:11:33'),
(21, 'Web Series, Global Shows & Anime', 'web-series-global-shows-and-anime', 'icon-021.svg', 1, '2025-04-19 03:55:34'),
(22, 'Sports & Games', 'sports-and-games', 'icon-022.svg', 1, '2025-03-17 16:34:49'),
(23, 'Space, Science & Environment', 'space-science-and-environment', 'icon-023.svg', 1, '2021-01-05 00:41:59'),
(24, 'Religion, Spirituality & Culture', 'religion-spirituality-and-culture', 'icon-024.svg', 1, '2025-08-02 02:31:58'),
(25, 'India & World', 'india-and-world', 'icon-025.svg', 1, '2021-01-29 15:22:56'),
(26, 'Corporate Affairs', 'corporate-affairs', 'icon-026.svg', 1, '2022-03-10 05:43:58'),
(27, 'Startup Ecosystem', 'startup-ecosystem', 'icon-027.svg', 1, '2023-05-18 00:34:01'),
(28, 'Venture Capital', 'venture-capital', 'icon-028.svg', 1, '2021-04-05 08:10:43'),
(29, 'Private Equity', 'private-equity', 'icon-029.svg', 1, '2025-04-27 14:40:49'),
(30, 'Global Economy', 'global-economy', 'icon-030.svg', 1, '2023-02-18 10:43:58'),
(31, 'International Trade', 'international-trade', 'icon-031.svg', 1, '2023-10-23 14:03:23'),
(32, 'Public Policy', 'public-policy', 'icon-032.svg', 1, '2022-08-13 12:51:34'),
(33, 'Taxation & Budget', 'taxation-and-budget', 'icon-033.svg', 1, '2024-11-24 17:10:57'),
(34, 'Stock Analysis', 'stock-analysis', 'icon-034.svg', 1, '2023-05-20 12:56:54'),
(35, 'Investment Strategies', 'investment-strategies', 'icon-035.svg', 1, '2023-12-01 14:34:52'),
(36, 'Wealth Management', 'wealth-management', 'icon-036.svg', 1, '2020-01-20 09:58:12'),
(37, 'Retirement Planning', 'retirement-planning', 'icon-037.svg', 1, '2020-02-28 06:14:41'),
(38, 'Banking Reforms', 'banking-reforms', 'icon-038.svg', 1, '2025-04-09 13:47:52'),
(39, 'Fintech Innovations', 'fintech-innovations', 'icon-039.svg', 1, '2021-08-12 22:09:03'),
(40, 'Digital Payments', 'digital-payments', 'icon-040.svg', 1, '2021-04-02 23:41:51'),
(41, 'Insurance Sector', 'insurance-sector', 'icon-041.svg', 1, '2023-01-10 23:24:13'),
(42, 'Renewable Energy', 'renewable-energy', 'icon-042.svg', 1, '2025-02-02 15:07:43'),
(43, 'Power Sector', 'power-sector', 'icon-043.svg', 1, '2025-04-15 01:09:52'),
(44, 'Oil & Gas', 'oil-and-gas', 'icon-044.svg', 1, '2024-12-07 16:50:19'),
(45, 'Electric Vehicles', 'electric-vehicles', 'icon-045.svg', 1, '2025-06-18 06:35:02'),
(46, 'Automobile Industry', 'automobile-industry', 'icon-046.svg', 1, '2020-01-04 11:14:15'),
(47, 'Aviation Industry', 'aviation-industry', 'icon-047.svg', 1, '2022-03-15 11:48:30'),
(48, 'Railways & Transport', 'railways-and-transport', 'icon-048.svg', 1, '2020-02-23 11:48:18'),
(49, 'Logistics & Supply Chain', 'logistics-and-supply-chain', 'icon-049.svg', 1, '2022-08-11 13:39:13'),
(50, 'Smart Cities', 'smart-cities', 'icon-050.svg', 1, '2024-08-13 01:26:53'),
(51, 'Urban Development', 'urban-development', 'icon-051.svg', 1, '2023-02-04 21:02:33'),
(52, 'Rural Development', 'rural-development', 'icon-052.svg', 1, '2026-01-05 17:58:19'),
(53, 'Infrastructure Projects', 'infrastructure-projects', 'icon-053.svg', 1, '2025-08-20 06:13:39'),
(54, 'Agriculture & Farming', 'agriculture-and-farming', 'icon-054.svg', 1, '2020-12-25 19:40:35'),
(55, 'Food Security', 'food-security', 'icon-055.svg', 1, '2021-01-12 07:39:21'),
(56, 'Organic Farming', 'organic-farming', 'icon-056.svg', 1, '2020-12-25 13:46:50'),
(57, 'Agri Technology', 'agri-technology', 'icon-057.svg', 1, '2021-03-27 19:27:42'),
(58, 'Climate Change', 'climate-change', 'icon-058.svg', 1, '2023-05-02 06:54:21'),
(59, 'Environmental Policy', 'environmental-policy', 'icon-059.svg', 1, '2026-02-03 12:15:32'),
(60, 'Wildlife Conservation', 'wildlife-conservation', 'icon-060.svg', 1, '2025-06-14 11:07:39'),
(61, 'Disaster Management', 'disaster-management', 'icon-061.svg', 1, '2023-09-04 04:44:27'),
(62, 'Medical Research', 'medical-research', 'icon-062.svg', 1, '2023-05-04 18:30:35'),
(63, 'Public Health', 'public-health', 'icon-063.svg', 1, '2024-09-26 13:10:49'),
(64, 'Mental Wellness', 'mental-wellness', 'icon-064.svg', 1, '2025-12-29 18:04:56'),
(65, 'Nutrition & Diet', 'nutrition-and-diet', 'icon-065.svg', 1, '2021-05-26 03:25:12'),
(66, 'Higher Education', 'higher-education', 'icon-066.svg', 1, '2026-01-15 15:50:09'),
(67, 'Online Learning', 'online-learning', 'icon-067.svg', 1, '2023-04-20 08:03:00'),
(68, 'Skill Development', 'skill-development', 'icon-068.svg', 1, '2020-09-22 12:03:12'),
(69, 'Vocational Training', 'vocational-training', 'icon-069.svg', 1, '2024-08-14 16:20:03'),
(70, 'Government Jobs', 'government-jobs', 'icon-070.svg', 1, '2023-03-19 07:08:42'),
(71, 'Private Jobs', 'private-jobs', 'icon-071.svg', 1, '2022-04-19 21:53:46'),
(72, 'Startup Hiring', 'startup-hiring', 'icon-072.svg', 1, '2023-10-19 04:13:12'),
(73, 'Freelancing Economy', 'freelancing-economy', 'icon-073.svg', 1, '2023-10-17 00:59:33'),
(74, 'Artificial Intelligence', 'artificial-intelligence', 'icon-074.svg', 1, '2024-04-12 15:38:52'),
(75, 'Machine Learning', 'machine-learning', 'icon-075.svg', 1, '2025-05-28 23:41:18'),
(76, 'Data Science', 'data-science', 'icon-076.svg', 1, '2025-11-17 02:24:10'),
(77, 'Cloud Computing', 'cloud-computing', 'icon-077.svg', 1, '2020-06-22 00:08:15'),
(78, 'Cyber Security', 'cyber-security', 'icon-078.svg', 1, '2023-11-07 16:36:38'),
(79, 'Blockchain Technology', 'blockchain-technology', 'icon-079.svg', 1, '2020-12-22 01:46:58'),
(80, 'Web Development', 'web-development', 'icon-080.svg', 1, '2020-11-29 17:28:19'),
(81, 'Mobile Applications', 'mobile-applications', 'icon-081.svg', 1, '2021-10-22 18:42:06'),
(82, 'Social Media Trends', 'social-media-trends', 'icon-082.svg', 1, '2024-08-15 10:36:55'),
(83, 'Influencer Economy', 'influencer-economy', 'icon-083.svg', 1, '2024-12-24 01:22:52'),
(84, 'Digital Marketing', 'digital-marketing', 'icon-084.svg', 1, '2024-08-19 07:55:38'),
(85, 'Online Advertising', 'online-advertising', 'icon-085.svg', 1, '2024-12-05 14:50:10'),
(86, 'Media Ethics', 'media-ethics', 'icon-086.svg', 1, '2023-10-03 20:01:19'),
(87, 'Press Freedom', 'press-freedom', 'icon-087.svg', 1, '2024-01-16 22:53:10'),
(88, 'Journalism Standards', 'journalism-standards', 'icon-088.svg', 1, '2022-08-14 18:38:10'),
(89, 'Content Regulation', 'content-regulation', 'icon-089.svg', 1, '2022-10-18 19:25:23'),
(90, 'Film Industry', 'film-industry', 'icon-090.svg', 1, '2024-02-07 21:28:43'),
(91, 'Music Industry', 'music-industry', 'icon-091.svg', 1, '2025-09-09 15:47:34'),
(92, 'Television Industry', 'television-industry', 'icon-092.svg', 1, '2020-06-03 11:22:36'),
(93, 'OTT Platforms', 'ott-platforms', 'icon-093.svg', 1, '2020-07-09 15:59:05'),
(94, 'Celebrity Lifestyle', 'celebrity-lifestyle', 'icon-094.svg', 1, '2026-01-26 04:27:21'),
(95, 'Fashion & Beauty', 'fashion-and-beauty', 'icon-095.svg', 1, '2020-10-04 01:13:54'),
(96, 'Luxury Lifestyle', 'luxury-lifestyle', 'icon-096.svg', 1, '2022-10-03 23:46:33'),
(97, 'Travel Experiences', 'travel-experiences', 'icon-097.svg', 1, '2024-07-15 20:36:24'),
(98, 'Tourism Development', 'tourism-development', 'icon-098.svg', 1, '2023-08-27 22:03:01'),
(99, 'Heritage Sites', 'heritage-sites', 'icon-099.svg', 1, '2023-10-03 16:34:08'),
(100, 'Pilgrimage Tourism', 'pilgrimage-tourism', 'icon-100.svg', 1, '2021-06-15 15:28:43'),
(101, 'Eco Tourism', 'eco-tourism', 'icon-101.svg', 1, '2020-12-02 18:13:41'),
(102, 'Cricket Updates', 'cricket-updates', 'icon-102.svg', 1, '2025-06-08 13:36:41'),
(103, 'Football Leagues', 'football-leagues', 'icon-103.svg', 1, '2021-05-28 11:13:13'),
(104, 'Olympic Sports', 'olympic-sports', 'icon-104.svg', 1, '2024-01-03 23:50:37'),
(105, 'Athlete Profiles', 'athlete-profiles', 'icon-105.svg', 1, '2020-03-11 14:32:31'),
(106, 'Esports Industry', 'esports-industry', 'icon-106.svg', 1, '2021-02-27 11:40:26'),
(107, 'Gaming Startups', 'gaming-startups', 'icon-107.svg', 1, '2022-09-17 05:33:38'),
(108, 'Game Reviews', 'game-reviews', 'icon-108.svg', 1, '2022-12-01 00:24:21'),
(109, 'Streaming Platforms', 'streaming-platforms', 'icon-109.svg', 1, '2025-10-03 10:43:24'),
(110, 'Space Missions', 'space-missions', 'icon-110.svg', 1, '2022-01-08 12:45:59'),
(111, 'Satellite Technology', 'satellite-technology', 'icon-111.svg', 1, '2020-04-26 04:10:58'),
(112, 'Astronomy Research', 'astronomy-research', 'icon-112.svg', 1, '2024-09-06 03:36:56'),
(113, 'Astrophysics', 'astrophysics', 'icon-113.svg', 1, '2023-04-13 12:03:27'),
(114, 'Scientific Discoveries', 'scientific-discoveries', 'icon-114.svg', 1, '2021-12-10 06:34:55'),
(115, 'Innovation Labs', 'innovation-labs', 'icon-115.svg', 1, '2021-05-17 06:50:03'),
(116, 'Patent Research', 'patent-research', 'icon-116.svg', 1, '2025-07-08 03:38:41'),
(117, 'R&D Investment', 'randd-investment', 'icon-117.svg', 1, '2024-05-23 01:05:02'),
(118, 'Spiritual Teachings', 'spiritual-teachings', 'icon-118.svg', 1, '2022-12-01 08:16:15'),
(119, 'Meditation Practices', 'meditation-practices', 'icon-119.svg', 1, '2025-10-24 14:06:37'),
(120, 'Cultural Heritage', 'cultural-heritage', 'icon-120.svg', 1, '2021-05-26 06:37:45'),
(121, 'Traditional Arts', 'traditional-arts', 'icon-121.svg', 1, '2023-09-15 22:28:48'),
(122, 'Temple Economy', 'temple-economy', 'icon-122.svg', 1, '2020-09-16 19:18:38'),
(123, 'Festival Economy', 'festival-economy', 'icon-123.svg', 1, '2025-11-03 19:48:02'),
(124, 'Religious Tourism', 'religious-tourism', 'icon-124.svg', 1, '2021-05-30 17:16:58'),
(125, 'Cultural Festivals', 'cultural-festivals', 'icon-125.svg', 1, '2022-01-13 02:11:00'),
(126, 'Urban Crime', 'urban-crime', 'icon-126.svg', 1, '2020-02-20 03:35:20'),
(127, 'Cyber Fraud', 'cyber-fraud', 'icon-127.svg', 1, '2023-01-25 00:16:59'),
(128, 'Financial Scams', 'financial-scams', 'icon-128.svg', 1, '2021-06-13 01:48:31'),
(129, 'Legal Reforms', 'legal-reforms', 'icon-129.svg', 1, '2021-09-24 19:58:58'),
(130, 'Court Judgments', 'court-judgments', 'icon-130.svg', 1, '2021-10-17 23:17:27'),
(131, 'Human Rights', 'human-rights', 'icon-131.svg', 1, '2023-11-06 09:20:51'),
(132, 'Women Safety', 'women-safety', 'icon-132.svg', 1, '2025-06-14 03:42:24'),
(133, 'Child Welfare', 'child-welfare', 'icon-133.svg', 1, '2023-04-12 17:23:31'),
(134, 'NGO Activities', 'ngo-activities', 'icon-134.svg', 1, '2024-09-20 09:44:57'),
(135, 'Social Welfare', 'social-welfare', 'icon-135.svg', 1, '2020-08-02 10:07:15'),
(136, 'Poverty Alleviation', 'poverty-alleviation', 'icon-136.svg', 1, '2020-11-03 12:21:14'),
(137, 'Rural Healthcare', 'rural-healthcare', 'icon-137.svg', 1, '2021-02-16 14:32:25'),
(138, 'Defense Technology', 'defense-technology', 'icon-138.svg', 1, '2020-07-14 07:37:37'),
(139, 'Military Strategy', 'military-strategy', 'icon-139.svg', 1, '2022-01-06 19:53:18'),
(140, 'Border Security', 'border-security', 'icon-140.svg', 1, '2025-01-24 23:14:24'),
(141, 'National Security', 'national-security', 'icon-141.svg', 1, '2022-04-11 18:32:03'),
(142, 'Foreign Relations', 'foreign-relations', 'icon-142.svg', 1, '2025-09-07 11:40:56'),
(143, 'Diplomatic Affairs', 'diplomatic-affairs', 'icon-143.svg', 1, '2023-08-17 20:10:51'),
(144, 'Global Summits', 'global-summits', 'icon-144.svg', 1, '2023-03-22 08:30:50'),
(145, 'International Treaties', 'international-treaties', 'icon-145.svg', 1, '2022-09-22 06:24:04'),
(146, 'Population Studies', 'population-studies', 'icon-146.svg', 1, '2024-07-20 17:45:16'),
(147, 'Migration Trends', 'migration-trends', 'icon-147.svg', 1, '2020-06-12 03:20:02'),
(148, 'Urban Housing', 'urban-housing', 'icon-148.svg', 1, '2021-10-29 05:44:14'),
(149, 'Affordable Housing', 'affordable-housing', 'icon-149.svg', 1, '2022-11-19 22:28:58'),
(150, 'Real Estate Laws', 'real-estate-laws', 'icon-150.svg', 1, '2025-11-24 08:08:54'),
(151, 'Property Investment', 'property-investment', 'icon-151.svg', 1, '2021-07-02 04:35:00'),
(152, 'REIT Markets', 'reit-markets', 'icon-152.svg', 1, '2021-08-29 11:57:25'),
(153, 'Commercial Leasing', 'commercial-leasing', 'icon-153.svg', 1, '2020-08-06 07:57:59'),
(154, 'Consumer Rights', 'consumer-rights', 'icon-154.svg', 1, '2023-02-23 08:03:09'),
(155, 'Product Reviews', 'product-reviews', 'icon-155.svg', 1, '2025-07-25 20:44:38'),
(156, 'Brand Analysis', 'brand-analysis', 'icon-156.svg', 1, '2023-09-27 18:57:45'),
(157, 'Retail Trends', 'retail-trends', 'icon-157.svg', 1, '2021-03-12 14:51:31'),
(158, 'E-commerce Platforms', 'e-commerce-platforms', 'icon-158.svg', 1, '2022-09-22 23:33:44'),
(159, 'Marketplace Policies', 'marketplace-policies', 'icon-159.svg', 1, '2020-03-03 02:09:24'),
(160, 'Cross-border Trade', 'cross-border-trade', 'icon-160.svg', 1, '2020-12-03 13:59:47'),
(161, 'Export Promotion', 'export-promotion', 'icon-161.svg', 1, '2021-11-22 00:56:08'),
(162, 'Import Regulations', 'import-regulations', 'icon-162.svg', 1, '2022-10-07 07:40:29'),
(163, 'Trade Logistics', 'trade-logistics', 'icon-163.svg', 1, '2022-05-07 03:06:46'),
(164, 'Customs Policy', 'customs-policy', 'icon-164.svg', 1, '2024-12-09 22:03:41'),
(165, 'Shipping Industry', 'shipping-industry', 'icon-165.svg', 1, '2023-10-04 00:11:49'),
(166, 'Ports Development', 'ports-development', 'icon-166.svg', 1, '2025-05-11 12:14:58'),
(167, 'Maritime Security', 'maritime-security', 'icon-167.svg', 1, '2021-04-21 23:22:25'),
(168, 'Fisheries Industry', 'fisheries-industry', 'icon-168.svg', 1, '2022-05-31 23:30:25'),
(169, 'Blue Economy', 'blue-economy', 'icon-169.svg', 1, '2022-04-07 15:48:28'),
(170, 'Startup Mentorship', 'startup-mentorship', 'icon-170.svg', 1, '2023-08-18 22:13:05'),
(171, 'Incubators & Accelerators', 'incubators-and-accelerators', 'icon-171.svg', 1, '2025-06-22 04:24:41'),
(172, 'Innovation Hubs', 'innovation-hubs', 'icon-172.svg', 1, '2024-11-07 13:10:24'),
(173, 'Tech Parks', 'tech-parks', 'icon-173.svg', 1, '2025-03-31 02:02:58'),
(174, 'Women Entrepreneurs', 'women-entrepreneurs', 'icon-174.svg', 1, '2025-07-13 15:09:37'),
(175, 'Youth Startups', 'youth-startups', 'icon-175.svg', 1, '2023-02-09 05:13:08'),
(176, 'Rural Startups', 'rural-startups', 'icon-176.svg', 1, '2022-03-08 04:22:37'),
(177, 'Social Enterprises', 'social-enterprises', 'icon-177.svg', 1, '2024-05-29 05:44:29'),
(178, 'Enterprise-wide uniform approach', 'enterprise-wide-uniform-approach', 'icon-178.svg', 1, '2026-01-02 00:15:29'),
(179, 'Extended fresh-thinking interface', 'extended-fresh-thinking-interface', 'icon-179.svg', 1, '2020-09-23 09:39:21'),
(180, 'Streamlined content-based initiative', 'streamlined-content-based-initiative', 'icon-180.svg', 1, '2025-03-13 21:13:18'),
(181, 'Synergistic methodical flexibility', 'synergistic-methodical-flexibility', 'icon-181.svg', 1, '2020-10-28 20:55:29'),
(182, 'Reverse-engineered exuding contingency', 'reverse-engineered-exuding-contingency', 'icon-182.svg', 1, '2025-05-24 19:43:47'),
(183, 'Operative interactive database', 'operative-interactive-database', 'icon-183.svg', 1, '2020-11-24 14:10:53'),
(184, 'Virtual 24/7 matrix', 'virtual-247-matrix', 'icon-184.svg', 1, '2023-03-18 07:24:41'),
(185, 'Pre-emptive transitional Local Area Network', 'pre-emptive-transitional-local-area-network', 'icon-185.svg', 1, '2022-12-24 12:49:41'),
(186, 'Upgradable motivating product', 'upgradable-motivating-product', 'icon-186.svg', 1, '2022-11-11 02:59:47'),
(187, 'Devolved attitude-oriented ability', 'devolved-attitude-oriented-ability', 'icon-187.svg', 1, '2020-04-08 23:43:08'),
(188, 'Ameliorated client-server toolset', 'ameliorated-client-server-toolset', 'icon-188.svg', 1, '2022-02-12 21:04:05'),
(189, 'Balanced scalable emulation', 'balanced-scalable-emulation', 'icon-189.svg', 1, '2021-11-23 05:36:44'),
(190, 'Reverse-engineered next generation Graphic Interface', 'reverse-engineered-next-generation-graphic-interface', 'icon-190.svg', 1, '2020-06-19 02:17:03'),
(191, 'Phased static alliance', 'phased-static-alliance', 'icon-191.svg', 1, '2022-11-21 01:52:50'),
(192, 'Configurable motivating website', 'configurable-motivating-website', 'icon-192.svg', 1, '2022-07-19 05:17:55'),
(193, 'Cross-platform modular matrices', 'cross-platform-modular-matrices', 'icon-193.svg', 1, '2023-12-05 11:34:40'),
(194, 'Exclusive zero tolerance process improvement', 'exclusive-zero-tolerance-process-improvement', 'icon-194.svg', 1, '2022-03-30 06:55:55'),
(195, 'Triple-buffered client-server groupware', 'triple-buffered-client-server-groupware', 'icon-195.svg', 1, '2020-08-10 22:26:15'),
(196, 'Triple-buffered interactive installation', 'triple-buffered-interactive-installation', 'icon-196.svg', 1, '2021-06-20 00:40:52'),
(197, 'Future-proofed incremental initiative', 'future-proofed-incremental-initiative', 'icon-197.svg', 1, '2024-12-30 05:28:23'),
(198, 'Reduced analyzing open architecture', 'reduced-analyzing-open-architecture', 'icon-198.svg', 1, '2021-05-06 00:49:00'),
(199, 'Upgradable analyzing service-desk', 'upgradable-analyzing-service-desk', 'icon-199.svg', 1, '2025-11-12 15:30:16'),
(200, 'Re-contextualized fault-tolerant encoding', 're-contextualized-fault-tolerant-encoding', 'icon-200.svg', 1, '2021-08-24 19:55:43'),
(201, 'Companies', 'company', NULL, 1, '2026-02-18 06:59:03');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) NOT NULL,
  `article_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `content` text NOT NULL,
  `status` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `article_id`, `user_id`, `parent_id`, `content`, `status`, `created_at`) VALUES
(1, 1, 2, NULL, 'Very insightful article! I learned a lot about the current market trends.', 1, '2026-01-10 04:45:00'),
(2, 1, 4, 1, 'I agree. The section on investor sentiment was particularly well-written.', 1, '2026-01-10 06:00:00'),
(3, 2, 12, NULL, 'Could you provide more details on the supply chain impact mentioned here?', 1, '2026-01-12 08:30:00'),
(4, 3, 14, NULL, 'This strategic shift for the firm seems long overdue.', 1, '2026-01-14 04:15:00'),
(5, 4, 15, NULL, 'Wait, I thought the funding round was already closed?', 1, '2026-01-15 10:50:00'),
(6, 5, 16, NULL, 'The manufacturing sector really needs to adapt faster.', 1, '2026-01-16 06:40:00'),
(7, 6, 17, NULL, 'Great coverage of the steady growth report.', 0, '2026-01-18 03:00:00'),
(8, 7, 19, NULL, 'Interesting perspective on the policy signals.', 1, '2026-01-20 10:25:00'),
(9, 8, 22, NULL, 'I was expecting a more detailed analysis of the risks involved.', 1, '2026-01-22 05:50:00'),
(10, 9, 23, NULL, 'The charts in this article are very helpful.', 1, '2026-01-24 08:10:00'),
(11, 10, 25, NULL, 'How will this affect small-scale investors in the long run?', 1, '2026-01-26 04:35:00'),
(12, 11, 29, NULL, 'Looking forward to the follow-up piece on this topic.', 1, '2026-01-28 12:00:00'),
(13, 12, 30, NULL, 'The leadership changes are definitely going to shake things up.', 1, '2026-01-30 08:45:00'),
(14, 13, 34, NULL, 'A very balanced view of the current economic situation.', 1, '2026-02-01 04:20:00'),
(15, 14, 36, NULL, 'Is there any data available for the previous quarter to compare?', 1, '2026-02-02 06:55:00'),
(16, 15, 41, NULL, 'This is a must-read for anyone in the tech industry.', 1, '2026-02-03 10:30:00'),
(17, 16, 42, NULL, 'I have some doubts about the projected growth rates mentioned.', 1, '2026-02-04 05:40:00'),
(18, 17, 45, NULL, 'Excellent analysis! The depth of research is evident.', 1, '2026-01-11 03:30:00'),
(19, 18, 47, NULL, 'The supply chain issues are more complex than stated here.', 1, '2026-01-13 09:00:00'),
(20, 19, 49, NULL, 'Hopefully, the new leadership brings some much-needed innovation.', 1, '2026-01-15 05:15:00'),
(21, 20, 50, NULL, 'Investors are definitely staying cautious for now.', 1, '2026-01-17 07:50:00'),
(22, 21, 52, NULL, 'The sector is definitely showing some resilience.', 1, '2026-01-19 10:45:00'),
(23, 22, 2, NULL, 'Another great report! Keep up the good work.', 1, '2026-01-21 05:30:00'),
(24, 23, 4, NULL, 'Policy changes are always a double-edged sword.', 1, '2026-01-23 10:00:00'),
(25, 24, 12, NULL, 'The risks are definitely there, but so are the opportunities.', 1, '2026-01-25 04:20:00'),
(26, 25, 14, NULL, 'The data points are very clear and easy to understand.', 1, '2026-01-27 06:45:00'),
(27, 26, 15, NULL, 'Small investors should focus on long-term value.', 1, '2026-01-29 09:10:00'),
(28, 27, 16, NULL, 'The next phase of this development will be crucial.', 1, '2026-01-31 04:35:00'),
(29, 28, 17, NULL, 'Strategic shifts are never easy, but they are necessary.', 1, '2026-02-02 12:00:00'),
(30, 29, 19, NULL, 'Economic stability is the need of the hour.', 1, '2026-02-04 02:50:00'),
(31, 30, 22, NULL, 'How does this impact the local ecosystem?', 1, '2026-01-20 04:30:00'),
(32, 31, 23, NULL, 'It mostly helps by bringing in more global expertise.', 1, '2026-01-20 05:30:00'),
(33, 32, 25, NULL, 'The stats on inflation seem a bit conservative.', 1, '2026-01-25 04:00:00'),
(34, 33, 29, NULL, 'Agreed, ground reality might be different.', 1, '2026-01-25 04:45:00'),
(35, 34, 30, NULL, 'Is there any upcoming webinar on this subject?', 1, '2026-01-26 08:30:00'),
(36, 35, 34, NULL, 'Glad to see these issues being addressed publicly.', 1, '2026-01-28 03:45:00'),
(37, 36, 36, NULL, 'Thanks for the detailed breakdown of the stats.', 1, '2026-01-30 06:00:00'),
(38, 37, 41, NULL, 'How can a beginner start implementing these strategies?', 1, '2026-02-01 10:15:00'),
(39, 38, 42, NULL, 'The author makes several valid points about the market.', 1, '2026-02-02 04:50:00'),
(40, 39, 45, NULL, 'Does anyone have a link to the full report?', 1, '2026-02-03 03:20:00'),
(41, 40, 47, NULL, 'This matches what I am seeing in my own portfolio.', 1, '2026-02-04 06:40:00'),
(42, 41, 49, NULL, 'Well-written and easy to follow even for non-experts.', 1, '2026-01-10 11:00:00'),
(43, 42, 50, NULL, 'The conclusion perfectly sums up the current situation.', 1, '2026-01-12 05:50:00'),
(44, 43, 52, NULL, 'There is some really useful advice here for tech founders.', 1, '2026-01-14 09:20:00'),
(45, 44, 2, NULL, 'Can we expect more coverage on similar industries?', 1, '2026-01-16 04:40:00'),
(46, 45, 4, NULL, 'Highly informative and relevant to my current project.', 1, '2026-01-18 08:10:00'),
(47, 46, 12, NULL, 'What are the main takeaways for small businesses?', 1, '2026-01-20 03:50:00'),
(48, 47, 14, NULL, 'Exactly what I needed to read today, very timely.', 1, '2026-01-22 09:35:00'),
(49, 48, 15, NULL, 'I disagree with the assessment of the banking sector.', 1, '2026-01-24 06:25:00'),
(50, 49, 16, NULL, 'Could we see a follow-up on the energy market impact?', 1, '2026-01-26 12:00:00'),
(51, 50, 17, NULL, 'Looking forward to the next installment in this series.', 1, '2026-01-28 03:15:00'),
(52, 51, 19, NULL, 'A very timely piece given the current global climate.', 1, '2026-01-30 08:45:00'),
(53, 52, 22, NULL, 'The research behind this is quite impressive.', 1, '2026-02-01 04:30:00'),
(54, 53, 23, NULL, 'Has this been corroborated by other major outlets?', 1, '2026-02-02 06:55:00'),
(55, 54, 25, NULL, 'This will definitely change how I look at my investments.', 1, '2026-02-03 11:10:00'),
(56, 55, 29, NULL, 'Does the policy change apply to all regions?', 1, '2026-02-04 03:40:00'),
(57, 56, 30, NULL, 'Clear, concise, and incredibly useful information.', 1, '2026-01-11 06:00:00'),
(58, 57, 34, NULL, 'The charts were a great addition to the article.', 1, '2026-01-13 09:50:00'),
(59, 58, 36, NULL, 'What does this mean for the long-term debt market?', 1, '2026-01-15 05:25:00'),
(60, 59, 41, NULL, 'Great insights, I will be sharing this with my team.', 1, '2026-01-17 08:10:00'),
(61, 60, 42, NULL, 'How does the current volatility affect these findings?', 1, '2026-01-19 03:45:00'),
(62, 61, 45, NULL, 'The article hits the nail on the head regarding the risks.', 1, '2026-01-21 10:35:00'),
(63, 62, 47, NULL, 'This is a significant development for the industry.', 1, '2026-01-23 06:20:00'),
(64, 63, 49, NULL, 'How will the upcoming elections impact this scenario?', 1, '2026-01-25 09:00:00'),
(65, 64, 50, NULL, 'Looking for more such deep dives into the economy.', 1, '2026-01-27 04:40:00'),
(66, 65, 52, NULL, 'Excellent reporting on the recent startup trends.', 1, '2026-01-29 06:55:00'),
(67, 66, 2, NULL, 'Can we get a comparison with last year’s performance?', 1, '2026-01-31 03:20:00'),
(68, 67, 4, NULL, 'This article provides a very fresh perspective.', 1, '2026-02-02 10:10:00'),
(69, 68, 12, NULL, 'The data presented is truly eye-opening.', 1, '2026-02-04 05:45:00'),
(70, 69, 14, NULL, 'How much of this is driven by international factors?', 1, '2026-01-12 11:00:00'),
(71, 70, 15, NULL, 'Very well argued, though I have some minor reservations.', 1, '2026-01-14 03:50:00'),
(72, 71, 16, NULL, 'Is there a summary version available for a quick read?', 1, '2026-01-16 08:20:00'),
(73, 72, 17, NULL, 'The impact on local businesses needs more attention.', 1, '2026-01-18 04:35:00'),
(74, 73, 19, NULL, 'What are the main risks for early-stage investors?', 1, '2026-01-20 10:15:00'),
(75, 74, 22, NULL, 'This provides a lot of clarity on a complex issue.', 1, '2026-01-22 06:00:00'),
(76, 75, 23, NULL, 'Highly recommended for anyone tracking market trends.', 1, '2026-01-24 02:45:00'),
(77, 76, 25, NULL, 'Will this lead to a change in the central bank’s policy?', 1, '2026-01-26 09:10:00'),
(78, 77, 29, NULL, 'The section on consumer behavior was very helpful.', 1, '2026-01-28 05:25:00'),
(79, 78, 30, NULL, 'I enjoyed reading this, very well thought out.', 1, '2026-01-30 10:50:00'),
(80, 79, 34, NULL, 'Does the author have any other articles on this topic?', 1, '2026-02-01 06:45:00'),
(81, 80, 36, NULL, 'How will the recent budget impact these projections?', 1, '2026-02-03 04:10:00'),
(82, 81, 41, NULL, 'This is exactly the kind of analysis the industry needs.', 1, '2026-02-04 09:35:00'),
(83, 82, 42, NULL, 'What role will tech innovation play in the recovery?', 1, '2026-01-15 06:00:00'),
(84, 83, 45, NULL, 'A very comprehensive look at the global supply chain.', 1, '2026-01-17 08:40:00'),
(85, 84, 47, NULL, 'This clarifies many of the doubts I had about the sector.', 1, '2026-01-19 05:25:00'),
(86, 85, 49, NULL, 'Good article, but could use more direct industry quotes.', 1, '2026-01-21 08:10:00'),
(87, 86, 50, NULL, 'How soon can we expect a stabilization in the market?', 1, '2026-01-23 03:45:00'),
(88, 87, 52, NULL, 'Excellent piece of journalism, very well researched.', 1, '2026-01-25 10:35:00'),
(89, 88, 2, NULL, 'I am looking forward to seeing how this story develops.', 1, '2026-01-27 06:20:00'),
(90, 89, 4, NULL, 'The analysis of the geopolitical impact is spot on.', 1, '2026-01-29 09:00:00'),
(91, 90, 12, NULL, 'This is a game-changer for my investment strategy.', 1, '2026-01-31 04:40:00'),
(92, 91, 14, NULL, 'The article does a great job of explaining the basics.', 1, '2026-02-02 06:55:00'),
(93, 92, 15, NULL, 'I would like to see more focus on the social impact.', 1, '2026-02-04 03:20:00'),
(94, 93, 16, NULL, 'Can we get an update on the regulatory changes?', 1, '2026-01-11 10:10:00'),
(95, 94, 17, NULL, 'This is one of the best articles I have read this month.', 1, '2026-01-13 05:45:00'),
(96, 95, 19, NULL, 'What are the main takeaways for retail investors?', 1, '2026-01-15 11:00:00'),
(97, 96, 22, NULL, 'A very balanced and objective piece of writing.', 1, '2026-01-17 03:50:00'),
(98, 97, 23, NULL, 'How much of this is already priced into the market?', 1, '2026-01-19 08:20:00'),
(99, 98, 25, NULL, 'I found the section on historical trends very useful.', 1, '2026-01-21 04:35:00'),
(100, 99, 29, NULL, 'This really helps in understanding the current policy.', 1, '2026-01-23 10:15:00'),
(101, 100, 30, NULL, 'The author has a very engaging writing style.', 1, '2026-01-25 06:00:00'),
(102, 101, 34, NULL, 'How can small firms compete with these new trends?', 1, '2026-01-27 02:45:00'),
(103, 102, 36, NULL, 'This article clears up many common misconceptions.', 1, '2026-01-29 09:10:00'),
(104, 103, 41, NULL, 'Very informative, keep the great content coming.', 1, '2026-01-31 05:25:00'),
(105, 104, 42, NULL, 'What does the future hold for sustainable investments?', 1, '2026-02-02 10:50:00'),
(106, 105, 45, NULL, 'A must-read for anyone interested in the economy.', 1, '2026-02-04 06:45:00'),
(107, 106, 47, NULL, 'Very helpful analysis of the recent trade agreements.', 1, '2026-01-14 04:10:00'),
(108, 107, 49, NULL, 'How will the inflation data impact the next quarter?', 1, '2026-01-16 09:35:00'),
(109, 108, 50, NULL, 'The article highlights several key growth areas.', 1, '2026-01-18 06:00:00'),
(110, 109, 52, NULL, 'The impact on rural markets is also significant.', 1, '2026-01-20 08:40:00'),
(111, 110, 2, NULL, 'This article provides a solid overview of the tech landscape.', 1, '2026-01-22 05:25:00'),
(112, 111, 4, NULL, 'How will the new regulations affect established players?', 1, '2026-01-24 08:10:00'),
(113, 112, 12, NULL, 'Very useful insights into the future of manufacturing.', 1, '2026-01-26 03:45:00'),
(114, 113, 14, NULL, 'The piece is a bit pessimistic but raises valid points.', 1, '2026-01-28 10:35:00'),
(115, 114, 15, NULL, 'How can startups leverage these new developments?', 1, '2026-01-30 06:20:00'),
(116, 115, 16, NULL, 'The analysis of the labor market is very insightful.', 1, '2026-02-01 09:00:00'),
(117, 116, 17, NULL, 'What role will government funding play in this?', 1, '2026-02-03 04:40:00'),
(118, 117, 19, NULL, 'A very timely piece of investigative journalism.', 1, '2026-02-04 06:55:00'),
(119, 118, 22, NULL, 'How does the current crisis impact these findings?', 1, '2026-01-10 03:20:00'),
(120, 119, 23, NULL, 'This confirms many of my own thoughts on the matter.', 1, '2026-01-12 10:10:00'),
(121, 120, 25, NULL, 'I appreciate the deep dive into the historical data.', 1, '2026-01-14 05:45:00'),
(122, 121, 29, NULL, 'What are the main hurdles for the upcoming projects?', 1, '2026-01-16 11:00:00'),
(123, 122, 30, NULL, 'A very balanced view of the current challenges.', 1, '2026-01-18 03:50:00'),
(124, 123, 34, NULL, 'How does this compare with the global average?', 1, '2026-01-20 08:20:00'),
(125, 124, 36, NULL, 'Great article, very helpful for my research.', 1, '2026-01-22 04:35:00'),
(126, 125, 41, NULL, 'The findings are very relevant to the current situation.', 1, '2026-01-24 10:15:00'),
(127, 126, 42, NULL, 'I would like to see more data on the long-term impact.', 1, '2026-01-26 06:00:00'),
(128, 127, 45, NULL, 'This really sheds light on some hidden aspects of the market.', 1, '2026-01-28 02:45:00'),
(129, 128, 47, NULL, 'The analysis of the competitive landscape is excellent.', 1, '2026-01-30 09:10:00'),
(130, 129, 49, NULL, 'How will the upcoming trade show affect the industry?', 1, '2026-02-01 05:25:00'),
(131, 130, 50, NULL, 'A very clear and well-structured piece of writing.', 1, '2026-02-03 10:50:00'),
(132, 131, 52, NULL, 'This is a very important contribution to the discussion.', 1, '2026-02-04 06:45:00'),
(133, 132, 2, NULL, 'The article provides a lot of value for the readers.', 1, '2026-01-13 04:10:00'),
(134, 133, 4, NULL, 'What are the main takeaways for policy makers?', 1, '2026-01-15 09:35:00'),
(135, 134, 12, NULL, 'The findings are both surprising and informative.', 1, '2026-01-17 06:00:00'),
(136, 135, 14, NULL, 'How will the new laws affect the gig economy?', 1, '2026-01-19 08:40:00'),
(137, 136, 15, NULL, 'A very thorough and detailed piece of research.', 1, '2026-01-21 05:25:00'),
(138, 137, 16, NULL, 'How does this impact the future of education?', 1, '2026-01-23 08:10:00'),
(139, 138, 17, NULL, 'The article is very well organized and easy to read.', 1, '2026-01-25 03:45:00'),
(140, 139, 19, NULL, 'I appreciate the neutral tone of the article.', 1, '2026-01-27 10:35:00'),
(141, 140, 22, NULL, 'What role will AI play in these developments?', 1, '2026-01-29 06:20:00'),
(142, 141, 23, NULL, 'A very helpful guide for the current market situation.', 1, '2026-01-31 09:00:00'),
(143, 142, 25, NULL, 'The findings are very relevant to the industry today.', 1, '2026-02-02 04:40:00'),
(144, 143, 29, NULL, 'How can investors mitigate the mentioned risks?', 1, '2026-02-04 06:55:00'),
(145, 144, 30, NULL, 'The piece raises some very interesting questions.', 1, '2026-01-12 03:20:00'),
(146, 145, 34, NULL, 'I agree with the author’s main conclusion.', 1, '2026-01-14 10:10:00'),
(147, 146, 36, NULL, 'How much of this is based on current projections?', 1, '2026-01-16 05:45:00'),
(148, 147, 41, NULL, 'A very insightful and well-written article.', 1, '2026-01-18 11:00:00'),
(149, 148, 42, NULL, 'What are the main consequences for the environment?', 1, '2026-01-20 03:50:00'),
(150, 149, 45, NULL, 'The article provides a very clear summary of the issue.', 1, '2026-01-22 08:20:00'),
(151, 150, 47, NULL, 'How will the digital shift impact the traditional firms?', 1, '2026-01-24 04:35:00'),
(152, 151, 49, NULL, 'A very timely piece given the current situation.', 1, '2026-01-26 10:15:00'),
(153, 152, 50, NULL, 'The analysis of the current market is very deep.', 1, '2026-01-28 06:00:00'),
(154, 153, 52, NULL, 'What role does human behavior play in these trends?', 1, '2026-01-30 02:45:00'),
(155, 154, 2, NULL, 'A very insightful analysis of the current trends.', 1, '2026-02-01 09:10:00'),
(156, 155, 4, NULL, 'How much will the interest rates change the outcome?', 1, '2026-02-03 05:25:00'),
(158, 157, 14, NULL, 'The findings are very consistent with recent data.', 1, '2026-01-15 06:45:00'),
(159, 158, 15, NULL, 'How does the author see the future of the market?', 1, '2026-01-17 04:10:00'),
(160, 159, 16, NULL, 'A very informative piece, definitely worth a read.', 1, '2026-01-19 09:35:00'),
(161, 160, 17, NULL, 'The research provides a solid foundation for the claims.', 1, '2026-01-21 06:00:00'),
(162, 161, 19, NULL, 'How will the global growth affect the local market?', 1, '2026-01-23 08:40:00'),
(163, 162, 22, NULL, 'A very balanced view, presenting both sides clearly.', 1, '2026-01-25 05:25:00'),
(164, 163, 23, NULL, 'The findings are very helpful for long-term planning.', 1, '2026-01-27 08:10:00'),
(165, 164, 25, NULL, 'I found the section on historical trends fascinating.', 1, '2026-01-29 03:45:00'),
(166, 165, 29, NULL, 'This really clarifies the current policy landscape.', 1, '2026-01-31 10:35:00'),
(167, 166, 30, NULL, 'The author makes some very compelling arguments.', 1, '2026-02-02 06:20:00'),
(168, 167, 34, NULL, 'How much of this will be affected by technology?', 1, '2026-02-04 09:00:00'),
(169, 168, 36, NULL, 'A very interesting and thought-provoking piece.', 1, '2026-01-11 04:40:00'),
(170, 169, 41, NULL, 'The article is very relevant to my current interests.', 1, '2026-01-13 06:55:00'),
(171, 170, 42, NULL, 'What are the main consequences of the new policy?', 1, '2026-01-15 03:20:00'),
(172, 171, 45, NULL, 'A very thorough and comprehensive look at the issue.', 1, '2026-01-17 10:10:00'),
(173, 172, 47, NULL, 'The analysis provided is both deep and accessible.', 1, '2026-01-19 05:45:00'),
(174, 173, 49, NULL, 'How will the market respond to these new findings?', 1, '2026-01-21 11:00:00'),
(175, 174, 50, NULL, 'A very well-written piece, clear and easy to read.', 1, '2026-01-23 03:50:00'),
(176, 175, 52, NULL, 'The article hits all the main points perfectly.', 1, '2026-01-25 08:20:00'),
(177, 176, 2, NULL, 'What role will the youth play in this development?', 1, '2026-01-27 04:35:00'),
(178, 177, 4, NULL, 'This is a very important piece of reporting.', 1, '2026-01-29 10:15:00'),
(179, 178, 12, NULL, 'The data presented is very convincing and solid.', 1, '2026-01-31 06:00:00'),
(180, 179, 14, NULL, 'I enjoyed reading this, very well researched.', 1, '2026-02-02 02:45:00'),
(181, 180, 15, NULL, 'How much does this impact the future of business?', 1, '2026-02-04 09:10:00'),
(182, 181, 16, NULL, 'A very informative and useful piece of information.', 1, '2026-01-14 05:25:00'),
(183, 182, 17, NULL, 'The author has clearly put a lot of work into this.', 1, '2026-01-16 10:50:00'),
(184, 183, 19, NULL, 'A very fresh look at a very old problem.', 1, '2026-01-18 06:45:00'),
(185, 184, 22, NULL, 'What role will the international community play?', 1, '2026-01-20 04:10:00'),
(186, 185, 23, NULL, 'The findings are both timely and very relevant.', 1, '2026-01-22 09:35:00'),
(187, 186, 25, NULL, 'I agree with most of the points raised here.', 1, '2026-01-24 06:00:00'),
(188, 187, 29, NULL, 'How much of this will actually happen in practice?', 1, '2026-01-26 08:40:00'),
(189, 188, 30, NULL, 'A very engaging and well-informed article.', 1, '2026-01-28 05:25:00'),
(190, 189, 34, NULL, 'I appreciate the focus on the actual evidence.', 1, '2026-01-30 08:10:00'),
(191, 190, 36, NULL, 'How will the upcoming changes impact the readers?', 1, '2026-02-01 03:45:00'),
(192, 191, 41, NULL, 'The article is very informative and very timely.', 1, '2026-02-03 10:35:00'),
(193, 192, 42, NULL, 'What are the main consequences for the economy?', 1, '2026-02-04 06:20:00'),
(194, 193, 45, NULL, 'The research provides a lot of value for everyone.', 1, '2026-01-10 09:00:00'),
(195, 194, 47, NULL, 'How will the market adapt to these findings?', 1, '2026-01-12 04:40:00'),
(196, 195, 49, NULL, 'A very clear and concise piece of writing.', 1, '2026-01-14 06:55:00'),
(197, 196, 50, NULL, 'The article makes several very valid points.', 1, '2026-01-16 03:20:00'),
(198, 197, 52, NULL, 'How soon can we expect a change in the market?', 1, '2026-01-18 10:10:00'),
(199, 198, 2, NULL, 'A very thorough and deep analysis of the issue.', 1, '2026-01-20 05:45:00'),
(200, 199, 4, NULL, 'The findings are very useful for everyone involved.', 1, '2026-01-22 11:00:00'),
(201, 200, 12, NULL, 'A very good piece of journalism, keep it up.', 1, '2026-01-24 03:50:00'),
(202, 1, 205, NULL, 'hello', 1, '2026-02-28 08:03:41'),
(205, 1, 205, NULL, 'hey', 1, '2026-02-28 11:25:40');

-- --------------------------------------------------------

--
-- Table structure for table `indices`
--

CREATE TABLE `indices` (
  `id` int(11) NOT NULL,
  `symbol` varchar(20) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `change_pts` decimal(10,2) DEFAULT NULL,
  `change_percent` decimal(6,2) DEFAULT NULL,
  `recorded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `indices`
--

INSERT INTO `indices` (`id`, `symbol`, `name`, `price`, `change_pts`, `change_percent`, `recorded_at`) VALUES
(1, 'NSE_INDEX|Nifty 50', 'NIFTY 50', 24865.70, -312.95, -1.24, '2026-03-02 10:55:09'),
(2, 'BSE_INDEX|SENSEX', 'SENSEX', 80238.85, -1048.34, -1.29, '2026-03-02 10:55:09'),
(3, 'NSE_INDEX|Nifty Bank', 'NIFTY BANK', 59839.65, -689.35, -1.14, '2026-03-02 10:55:09'),
(4, 'NSE_INDEX|Nifty IT', 'NIFTY IT', 30272.95, -330.90, -1.08, '2026-03-02 10:55:09');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` bigint(20) NOT NULL,
  `comment_id` bigint(20) DEFAULT NULL,
  `article_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  `reason` enum('fake_news','abuse','spam') NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('pending','resolved') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stocks`
--

CREATE TABLE `stocks` (
  `id` int(11) NOT NULL,
  `symbol` varchar(20) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `change_pts` decimal(10,2) DEFAULT NULL,
  `change_percent` decimal(6,2) DEFAULT NULL,
  `recorded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stocks`
--

INSERT INTO `stocks` (`id`, `symbol`, `name`, `type`, `price`, `change_pts`, `change_percent`, `recorded_at`) VALUES
(1, 'BEL', 'BEL', 'most_active', 454.15, 9.45, 2.13, '2026-03-02 10:55:12'),
(2, 'HINDALCO', 'HINDALCO', 'gainer', 940.45, 15.75, 1.70, '2026-03-02 10:55:12'),
(3, 'SUNPHARMA', 'SUNPHARMA', 'gainer', 1753.20, 16.20, 0.93, '2026-03-02 10:55:12'),
(4, 'ONGC', 'ONGC', 'most_active', 281.45, 1.75, 0.63, '2026-03-02 10:55:12'),
(5, 'ITC', 'ITC', 'gainer', 314.70, 1.10, 0.35, '2026-03-02 10:55:12'),
(6, 'CIPLA', 'CIPLA', 'gainer', 1351.00, 2.80, 0.21, '2026-03-02 10:55:12'),
(7, 'DRREDDY', 'DRREDDY', 'gainer', 1288.10, 1.80, 0.14, '2026-03-02 10:55:12'),
(8, 'JSWSTEEL', 'JSWSTEEL', 'gainer', 1265.70, 1.00, 0.08, '2026-03-02 10:55:12'),
(9, 'SBILIFE', 'SBILIFE', 'gainer', 2031.40, -5.80, -0.28, '2026-03-02 10:55:12'),
(10, 'ICICIBANK', 'ICICIBANK', 'most_active', 1374.80, -4.10, -0.30, '2026-03-02 10:55:12'),
(11, 'INDIGO', 'INDIGO', 'most_active', 4533.00, -294.20, -6.09, '2026-03-02 10:55:12'),
(12, 'LT', 'LT', 'most_active', 4054.00, -224.30, -5.24, '2026-03-02 10:55:12'),
(13, 'ADANIPORTS', 'ADANIPORTS', 'loser', 1468.90, -52.10, -3.43, '2026-03-02 10:55:12'),
(14, 'MARUTI', 'MARUTI', 'loser', 14368.00, -489.00, -3.29, '2026-03-02 10:55:12'),
(15, 'ASIANPAINT', 'ASIANPAINT', 'loser', 2303.00, -73.20, -3.08, '2026-03-02 10:55:12'),
(16, 'TMPV', 'TMPV', 'loser', 371.30, -11.35, -2.97, '2026-03-02 10:55:12'),
(17, 'BAJAJFINSV', 'BAJAJFINSV', 'loser', 1935.00, -58.40, -2.93, '2026-03-02 10:55:12'),
(18, 'SHRIRAMFIN', 'SHRIRAMFIN', 'loser', 1048.10, -31.30, -2.90, '2026-03-02 10:55:12'),
(19, 'EICHERMOT', 'EICHERMOT', 'loser', 7809.00, -201.50, -2.52, '2026-03-02 10:55:12'),
(20, 'JIOFIN', 'JIOFIN', 'loser', 249.10, -6.30, -2.47, '2026-03-02 10:55:12'),
(21, 'HDFCBANK', 'HDFCBANK', 'most_active', 882.10, -5.65, -0.64, '2026-03-02 10:55:12'),
(22, 'RELIANCE', 'RELIANCE', 'most_active', 1360.00, -33.90, -2.43, '2026-03-02 10:55:12'),
(23, 'BHARTIARTL', 'BHARTIARTL', 'most_active', 1872.00, -7.30, -0.39, '2026-03-02 10:55:12'),
(24, 'SBIN', 'SBIN', 'most_active', 1189.50, -12.20, -1.02, '2026-03-02 10:55:12'),
(25, 'ETERNAL', 'ETERNAL', 'most_active', 242.30, -4.00, -1.62, '2026-03-02 10:55:12');

-- --------------------------------------------------------

--
-- Table structure for table `stock_watchlist`
--

CREATE TABLE `stock_watchlist` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `symbol` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stock_watchlist`
--

INSERT INTO `stock_watchlist` (`id`, `user_id`, `symbol`, `created_at`) VALUES
(12, 205, 'APOLLOHOSP', '2026-02-28 11:45:15'),
(13, 205, 'ETERNAL', '2026-02-28 11:45:17'),
(14, 205, 'HCLTECH', '2026-02-28 11:45:19'),
(15, 205, 'NTPC', '2026-02-28 11:45:25'),
(17, 205, 'BEL', '2026-03-02 06:42:25'),
(18, 205, 'BHARTIARTL', '2026-03-02 06:42:26');

-- --------------------------------------------------------

--
-- Table structure for table `subcategories`
--

CREATE TABLE `subcategories` (
  `id` bigint(20) NOT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `slug` varchar(150) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subcategories`
--

INSERT INTO `subcategories` (`id`, `category_id`, `name`, `slug`, `status`) VALUES
(1, 1, 'Company News', 'company-news', 1),
(2, 1, 'Earnings & Results', 'earnings-and-results', 1),
(3, 1, 'Mergers & Acquisitions', 'mergers-and-acquisitions', 1),
(4, 1, 'Leadership & Appointments', 'leadership-and-appointments', 1),
(5, 1, 'Restructuring & Layoffs', 'restructuring-and-layoffs', 1),
(6, 1, 'Startup Funding', 'startup-funding', 1),
(7, 1, 'Unicorns', 'unicorns', 1),
(8, 1, 'Incubators', 'incubators', 1),
(9, 1, 'MSME Policies', 'msme-policies', 1),
(10, 1, 'Entrepreneur Stories', 'entrepreneur-stories', 1),
(11, 1, 'Automobile', 'automobile', 1),
(12, 1, 'Aviation', 'aviation', 1),
(13, 1, 'FMCG', 'fmcg', 1),
(14, 1, 'Retail', 'retail', 1),
(15, 1, 'Real Estate', 'real-estate', 1),
(16, 1, 'Infrastructure', 'infrastructure', 1),
(19, 2, 'Sensex/Nifty', 'sensex--nifty', 1),
(20, 2, 'Stock', 'mid-and-small-cap', 1),
(21, 2, 'IPO', 'market-movers', 1),
(23, 2, 'F&O', 'fando', 1),
(24, 2, 'SIPs', 'sips', 1),
(27, 2, 'NFOs', 'nfos', 1),
(31, 2, 'SME', 'sme-ipos', 1),
(32, 2, 'Gold / Silver', 'gold--silver', 1),
(33, 2, 'Crude Oil', 'crude-oil', 1),
(34, 2, 'Currency', 'currency', 1),
(35, 2, 'Crypto', 'crypto', 1),
(36, 3, 'GDP', 'gdp', 1),
(37, 3, 'Inflation', 'inflation', 1),
(38, 3, 'Growth Outlook', 'growth-outlook', 1),
(39, 3, 'Trade Balance', 'trade-balance', 1),
(40, 3, 'Budget', 'budget', 1),
(41, 3, 'Taxation', 'taxation', 1),
(42, 3, 'RBI', 'rbi', 1),
(43, 3, 'SEBI', 'sebi', 1),
(44, 3, 'Reforms', 'reforms', 1),
(45, 3, 'PSU News', 'psu-news', 1),
(46, 3, 'Disinvestment', 'disinvestment', 1),
(47, 3, 'Schemes', 'schemes', 1),
(48, 3, 'Subsidies', 'subsidies', 1),
(49, 4, 'USA', 'usa', 1),
(50, 4, 'Europe', 'europe', 1),
(51, 4, 'Asia-Pacific', 'asia-pacific', 1),
(52, 4, 'Middle East', 'middle-east', 1),
(53, 4, 'Africa', 'africa', 1),
(54, 4, 'IMF / World Bank', 'imf--world-bank', 1),
(55, 4, 'Trade Wars', 'trade-wars', 1),
(56, 4, 'Sanctions', 'sanctions', 1),
(57, 4, 'Supply Chains', 'supply-chains', 1),
(58, 4, 'Dow / Nasdaq', 'dow--nasdaq', 1),
(59, 4, 'FTSE', 'ftse', 1),
(60, 4, 'Nikkei', 'nikkei', 1),
(61, 5, 'Savings Accounts', 'savings-accounts', 1),
(62, 5, 'Fixed Deposits', 'fixed-deposits', 1),
(63, 5, 'Digital Banking', 'digital-banking', 1),
(64, 5, 'Home Loans', 'home-loans', 1),
(65, 5, 'Education Loans', 'education-loans', 1),
(66, 5, 'Credit Cards', 'credit-cards', 1),
(67, 5, 'Life Insurance', 'life-insurance', 1),
(68, 5, 'Health Insurance', 'health-insurance', 1),
(69, 5, 'Motor Insurance', 'motor-insurance', 1),
(70, 5, 'ITR', 'itr', 1),
(71, 5, 'Deductions', 'deductions', 1),
(72, 5, 'Retirement', 'retirement', 1),
(73, 6, 'Funding Rounds', 'funding-rounds', 1),
(74, 6, 'Exits', 'exits', 1),
(75, 6, 'VC / PE', 'vc--pe', 1),
(76, 6, 'Founder Stories', 'founder-stories', 1),
(77, 6, 'AI & ML', 'ai-and-ml', 1),
(78, 6, 'Cloud', 'cloud', 1),
(79, 6, 'Cybersecurity', 'cybersecurity', 1),
(80, 6, 'Blockchain', 'blockchain', 1),
(81, 6, 'SaaS', 'saas', 1),
(82, 6, 'Social Media', 'social-media', 1),
(83, 6, 'E-commerce', 'e-commerce', 1),
(84, 6, 'Platforms', 'platforms', 1),
(85, 7, 'Renewable', 'renewable', 1),
(86, 7, 'Oil & Gas', 'oil-and-gas', 1),
(87, 7, 'Power', 'power', 1),
(88, 7, 'EV Charging', 'ev-charging', 1),
(89, 7, 'Steel', 'steel', 1),
(90, 7, 'Cement', 'cement', 1),
(91, 7, 'Chemicals', 'chemicals', 1),
(92, 7, 'Mining', 'mining', 1),
(93, 7, 'Climate Change', 'climate-change', 1),
(94, 7, 'ESG', 'esg', 1),
(95, 7, 'Sustainability', 'sustainability', 1),
(96, 8, 'Parliament', 'parliament', 1),
(97, 8, 'Elections', 'elections', 1),
(98, 8, 'Policies', 'policies', 1),
(99, 8, 'Parties', 'parties', 1),
(100, 8, 'Judiciary', 'judiciary', 1),
(101, 8, 'Administration', 'administration', 1),
(102, 8, 'Transparency', 'transparency', 1),
(103, 8, 'Armed Forces', 'armed-forces', 1),
(104, 8, 'Border Issues', 'border-issues', 1),
(105, 8, 'Cyber Security', 'cyber-security', 1),
(106, 9, 'Schools', 'schools', 1),
(107, 9, 'Universities', 'universities', 1),
(108, 9, 'EdTech', 'edtech', 1),
(109, 9, 'Exams', 'exams', 1),
(110, 9, 'IITs', 'iits', 1),
(111, 9, 'IIMs', 'iims', 1),
(112, 9, 'AIIMS', 'aiims', 1),
(113, 9, 'Global Universities', 'global-universities', 1),
(114, 9, 'UPSC', 'upsc', 1),
(115, 9, 'NEET', 'neet', 1),
(116, 9, 'JEE', 'jee', 1),
(117, 9, 'CAT', 'cat', 1),
(118, 9, 'Jobs', 'jobs', 1),
(119, 9, 'Hiring Trends', 'hiring-trends', 1),
(120, 9, 'Skill Development', 'skill-development', 1),
(121, 9, 'Freelancing', 'freelancing', 1),
(122, 10, 'Public Health', 'public-health', 1),
(123, 10, 'Medical Research', 'medical-research', 1),
(124, 10, 'Hospitals', 'hospitals', 1),
(125, 10, 'Insurance', 'insurance', 1),
(126, 10, 'Space', 'space', 1),
(127, 10, 'Innovation', 'innovation', 1),
(128, 10, 'Research', 'research', 1),
(129, 10, 'Biotechnology', 'biotechnology', 1),
(130, 11, 'Housing Market', 'housing-market', 1),
(131, 11, 'Commercial Property', 'commercial-property', 1),
(132, 11, 'Smart Cities', 'smart-cities', 1),
(133, 11, 'Urban Development', 'urban-development', 1),
(134, 11, 'REITs', 'reits', 1),
(135, 12, 'Street Food', 'street-food', 1),
(136, 12, 'Restaurant Reviews', 'restaurant-reviews', 1),
(137, 12, 'Recipes', 'recipes', 1),
(138, 12, 'Healthy Eating', 'healthy-eating', 1),
(139, 12, 'Regional Cuisine', 'regional-cuisine', 1),
(140, 12, 'Domestic Destinations', 'domestic-destinations', 1),
(141, 12, 'International Travel', 'international-travel', 1),
(142, 12, 'Budget Trips', 'budget-trips', 1),
(143, 12, 'Luxury Travel', 'luxury-travel', 1),
(144, 12, 'Pilgrimage Tours', 'pilgrimage-tours', 1),
(145, 12, 'Yoga', 'yoga', 1),
(146, 12, 'Mental Health', 'mental-health', 1),
(147, 12, 'Fitness', 'fitness', 1),
(148, 13, 'Social Media Trends', 'social-media-trends', 1),
(149, 13, 'Digital Economy', 'digital-economy', 1),
(150, 13, 'Influencer Economy', 'influencer-economy', 1),
(151, 13, 'Advertising', 'advertising', 1),
(152, 13, 'Gaming', 'gaming', 1),
(153, 14, 'Editorials', 'editorials', 1),
(154, 14, 'Columns', 'columns', 1),
(155, 14, 'Expert Views', 'expert-views', 1),
(156, 14, 'Interviews', 'interviews', 1),
(157, 14, 'Guest Posts', 'guest-posts', 1),
(158, 15, 'Finance Basics', 'finance-basics', 1),
(159, 15, 'Stock Market 101', 'stock-market-101', 1),
(160, 15, 'Startup Guides', 'startup-guides', 1),
(161, 15, 'Policy Explainers', 'policy-explainers', 1),
(162, 15, 'Case Studies', 'case-studies', 1),
(163, 16, 'Calculators', 'calculators', 1),
(164, 16, 'Market Screener', 'market-screener', 1),
(165, 16, 'SIP Planner', 'sip-planner', 1),
(166, 16, 'Tax Calculator', 'tax-calculator', 1),
(167, 16, 'Comparison Tools', 'comparison-tools', 1),
(168, 17, 'Investigations', 'investigations', 1),
(169, 17, 'Reports', 'reports', 1),
(170, 17, 'Rankings', 'rankings', 1),
(171, 17, 'Annual Surveys', 'annual-surveys', 1),
(172, 17, 'Awards', 'awards', 1),
(173, 18, 'Maharashtra', 'maharashtra', 1),
(174, 18, 'Gujarat', 'gujarat', 1),
(175, 18, 'Delhi NCR', 'delhi-ncr', 1),
(176, 18, 'UP', 'up', 1),
(177, 18, 'Rajasthan', 'rajasthan', 1),
(178, 18, 'South India', 'south-india', 1),
(179, 18, 'North-East', 'north-east', 1),
(180, 18, 'Mumbai', 'mumbai', 1),
(181, 18, 'Delhi', 'delhi', 1),
(182, 18, 'Bengaluru', 'bengaluru', 1),
(183, 18, 'Chennai', 'chennai', 1),
(184, 18, 'Hyderabad', 'hyderabad', 1),
(185, 18, 'Pune', 'pune', 1),
(186, 18, 'Civic Issues', 'civic-issues', 1),
(187, 18, 'Development Projects', 'development-projects', 1),
(188, 19, 'Major Crimes', 'major-crimes', 1),
(189, 19, 'Cyber Crime', 'cyber-crime', 1),
(190, 19, 'Financial Fraud', 'financial-fraud', 1),
(191, 19, 'Organized Crime', 'organized-crime', 1),
(192, 19, 'Police Updates', 'police-updates', 1),
(193, 19, 'Court Cases', 'court-cases', 1),
(194, 19, 'Verdicts', 'verdicts', 1),
(195, 19, 'Special Reports', 'special-reports', 1),
(196, 19, 'Exposés', 'exposés', 1),
(197, 20, 'Movie Releases', 'movie-releases', 1),
(198, 20, 'Box Office', 'box-office', 1),
(199, 20, 'Star Interviews', 'star-interviews', 1),
(200, 20, 'Upcoming Films', 'upcoming-films', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `name` varchar(150) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('admin','editor','user') DEFAULT NULL,
  `language` varchar(20) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_login` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `status` enum('active','blocked') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `language`, `avatar`, `created_at`, `last_login`, `remember_token`, `status`) VALUES
(1, 'Robert Reid', 'whitemichael@gmail.com', '6fc99b58f173b021631e1c278f76cd2474c70e35ba76257c43dae1bb508e991d', 'editor', 'mr', 'https://i.pravatar.cc/150?img=4', '2021-06-22 00:12:22', '2026-01-29 05:31:47', NULL, 'active'),
(2, 'Jonathan Nash', 'matthewclark@taylor.biz', 'a4e15ed0d2ac1802ae8743dc47a42c02fbce4fdf38d9f3f059c4e23bd35906b2', 'user', 'en', 'https://i.pravatar.cc/150?img=23', '2026-01-31 15:47:09', '2026-01-31 08:12:43', NULL, 'active'),
(3, ' admin', 'admin@gmail.com', 'e7e285b204069b26eae7426300439c24cd3c6619f782eb35d29080518d5d7c83', 'user', 'ta', 'https://i.pravatar.cc/150?img=58', '2024-08-01 01:05:21', '2026-01-12 05:40:50', NULL, 'active'),
(4, 'Christopher Reese', 'phanna@gmail.com', '91ed4c5ee4511bcf4d630fb92c77256d76d082f5457a3e87318e260cee641084', 'user', 'hi', 'https://i.pravatar.cc/150?img=3', '2025-01-17 22:39:25', '2026-01-13 21:27:41', NULL, 'active'),
(5, 'Beth Long', 'ericvaldez@gmail.com', '09f737b3e2f075acd7493f51841152d0ab05ea0e28ea9ac7a5a5cebd6f44cab8', 'user', 'hi', 'https://i.pravatar.cc/150?img=20', '2025-08-28 18:44:10', '2026-02-01 06:54:53', NULL, 'active'),
(6, 'Susan Kennedy', 'ysantiago@fleming.org', '399bc8c850678624d0c692cc173e4a209f04650f71a9027dd6d9006334c26f7c', 'editor', 'en', 'https://i.pravatar.cc/150?img=1', '2020-10-30 16:20:22', '2026-01-19 18:48:53', NULL, 'active'),
(7, 'Heather Garcia', 'tford@white.com', 'e7e285b204069b26eae7426300439c24cd3c6619f782eb35d29080518d5d7c83', 'user', 'gu', 'https://i.pravatar.cc/150?img=48', '2021-02-02 13:50:59', '2026-01-22 04:54:42', NULL, 'active'),
(8, 'Lindsey Evans', 'chadrogers@klein.com', '9f08c211ae4a39624886635dcc5e1c59d6c59827a6f1e052cc92756e5fcffd88', 'user', 'mr', 'https://i.pravatar.cc/150?img=31', '2022-12-24 01:41:46', '2026-01-25 22:51:50', NULL, 'active'),
(9, 'Robert Elliott', 'mary84@small.info', '218a2e94a841e9e96c5e90d9a5e75a65bf331fbfd07172b726592d81abf1f71b', 'editor', 'mr', 'https://i.pravatar.cc/150?img=49', '2022-04-19 00:42:01', '2026-01-27 15:52:44', NULL, 'active'),
(10, 'Tara Anderson', 'denisewells@king.com', 'db8c53ab7ffdb28997d6a1dfc7031cf56bfdaa03197c36d3016c7e4280781678', 'editor', 'en', 'https://i.pravatar.cc/150?img=20', '2020-12-30 22:47:52', '2026-01-31 04:26:40', NULL, 'active'),
(11, 'Erin Mcclure', 'craigchavez@evans.com', 'df6597458a6a7474003c27ae0baea55440b4fdf824fa9fe01e562a4592795062', 'user', 'en', 'https://i.pravatar.cc/150?img=6', '2026-01-12 05:23:38', '2026-01-10 15:27:09', NULL, 'active'),
(12, 'Eddie Diaz', 'randy72@smith.org', '5d774a50f11ecece084e9e198284bfa3ea9a03d1f620dbd9deca7ad44b4ccbff', 'user', 'gu', 'https://i.pravatar.cc/150?img=19', '2025-02-10 22:31:29', '2026-01-10 00:53:58', NULL, 'active'),
(13, 'James Beck', 'mary96@gmail.com', '61d068a76328fe4a2157a17dab2f1e4d2123d778b7d4e3682f9e1beb5cb280e0', 'editor', 'ta', 'https://i.pravatar.cc/150?img=40', '2021-09-04 02:00:45', '2026-01-19 20:52:48', NULL, 'active'),
(14, 'Ruth Garrison', 'kathleenhale@wagner.com', '6413a1d14be15bb232c3f80f471e0befabebc2f8c4ed28b26d0ca38cb27af516', 'user', 'mr', 'https://i.pravatar.cc/150?img=4', '2022-05-24 08:50:33', '2026-01-11 08:49:20', NULL, 'active'),
(15, 'Kelly Gibson', 'robertwalls@johnston.com', 'c0fd49d145165d6540a9298e1123fe115db917974607b512debdd8c0f6ba9f84', 'user', 'hi', 'https://i.pravatar.cc/150?img=16', '2023-07-21 20:51:25', '2026-01-18 06:17:14', NULL, 'active'),
(16, 'Dennis Webb', 'cassandramatthews@hotmail.com', '4394315ee6ecfeb8c068a0e92f483f09cc86cc321e6e7a37471d442ca3ba55b7', 'user', 'gu', 'https://i.pravatar.cc/150?img=58', '2020-09-28 07:13:22', '2026-01-08 01:59:46', NULL, 'active'),
(17, 'Michael Woodard', 'sullivanjeffery@hotmail.com', '3f465f4fbe4e174c39ad0461609a0d075f3da2201a0ccd360e7a07e8313cfd22', 'user', 'hi', 'https://i.pravatar.cc/150?img=7', '2025-01-25 09:06:54', '2026-01-30 12:50:31', NULL, 'active'),
(18, 'Deborah Powers', 'ryan04@hotmail.com', '0dfd81f40c3591cf9f02ebc165c0f868f30c7d32ba793dcb544f1fde5a66a25b', 'editor', 'ta', 'https://i.pravatar.cc/150?img=34', '2021-03-16 01:38:13', '2026-01-12 20:11:53', NULL, 'active'),
(19, 'Andrew Lewis', 'bharris@hotmail.com', '527002cfe0348ac5b279a2d75ef543f1089766eeb4c9021f9e1138ea386d55df', 'user', 'ta', 'https://i.pravatar.cc/150?img=15', '2024-05-02 11:13:41', '2026-01-07 09:27:07', NULL, 'active'),
(20, 'Shawn Sims', 'nunezpatricia@wells.biz', '2dc4c09e2d2e7f3cd39f3972a75f261a7bc714ca5668d298fb385fedd167b5e6', 'user', 'en', 'https://i.pravatar.cc/150?img=39', '2020-11-26 12:37:21', '2026-01-13 14:06:39', NULL, 'active'),
(21, 'Anthony Allen', 'lindadixon@yahoo.com', 'e42017b4ed6e61d6822af10d50ee643a0a7d9d4415e98cf94a85ff9c2f25bd18', 'user', 'hi', 'https://i.pravatar.cc/150?img=27', '2023-08-24 21:19:29', '2026-01-14 09:29:21', NULL, 'active'),
(22, 'Kristina Scott', 'crystal41@yahoo.com', 'e2f6a11db09285d10fdc597417083db1e22b1386a12018db81a11b57c7c01d5f', 'user', 'hi', 'https://i.pravatar.cc/150?img=48', '2024-05-16 23:44:23', '2026-01-28 16:26:12', NULL, 'active'),
(23, 'Oscar Watson', 'leedavid@cunningham-baldwin.org', 'fac8b9ad61e37029cbd1e1ac2368d28af0ef6af48b8e390960b9eb66916cc367', 'user', 'ta', 'https://i.pravatar.cc/150?img=64', '2021-12-21 10:17:40', '2026-01-18 12:14:33', NULL, 'active'),
(24, 'Wayne Brown', 'qday@gmail.com', '8443712720c773ccab4057b199b58fcec2b4668f938f67518f76cb84d4c619fa', 'editor', 'ta', 'https://i.pravatar.cc/150?img=15', '2021-06-24 08:58:34', '2026-02-01 19:59:17', NULL, 'active'),
(25, 'Diane Lester', 'phillipsjamie@hotmail.com', 'ea855c63df0884daf5dce6aa94b334d3a9096834512f7eeb318c11828b587cec', 'user', 'hi', 'https://i.pravatar.cc/150?img=45', '2022-07-03 23:39:55', '2026-01-16 13:06:22', NULL, 'active'),
(26, 'Justin Grant', 'timothy75@bryant.com', 'd9a30a2d9299867197d2fe1aaeea8f74b823691f524d5428d3e1ee465ab983bb', 'editor', 'hi', 'https://i.pravatar.cc/150?img=36', '2022-02-18 03:09:37', '2026-01-23 06:15:49', NULL, 'active'),
(27, 'Michael Rivera', 'angela22@hotmail.com', 'e3f7413fe7a17d3c337b33fa940e8aeb0dfe7bb042abe4d76a4676cae3157cd2', 'user', 'hi', 'https://i.pravatar.cc/150?img=17', '2023-07-24 08:03:04', '2026-01-02 23:05:55', NULL, 'active'),
(28, 'Sheri Mora', 'gmartin@rice-bennett.com', 'de010682da7bb463f5b8fbbad883d4a49c780506b305b8d1fcedf3f571589179', 'user', 'mr', 'https://i.pravatar.cc/150?img=4', '2025-02-09 03:50:58', '2026-01-07 11:21:15', NULL, 'active'),
(29, 'Sarah Cruz', 'josephjordan@brown.biz', '1b85727adad8e746fd5d4a3fb4c35c8cb43570db7c20421db52b1907a41b094f', 'editor', 'en', 'https://i.pravatar.cc/150?img=57', '2021-01-08 22:49:06', '2026-01-03 17:36:44', NULL, 'active'),
(30, 'Mr. Kyle Cohen DVM', 'ashleyescobar@hotmail.com', 'ed86fda9540b76021573ce602204cc52c7d902d81c0c3871f45dc68fe17f144b', 'user', 'gu', 'https://i.pravatar.cc/150?img=23', '2023-03-15 09:23:10', '2026-01-11 07:19:17', NULL, 'active'),
(31, 'Alan Henderson', 'randolphangela@dixon.info', '20b7357c13c492324ccb6118a7af3eeb6089211728d3a0d1a053040ffdde117d', 'editor', 'ta', 'https://i.pravatar.cc/150?img=18', '2023-04-05 09:40:56', '2026-02-03 22:00:23', NULL, 'active'),
(32, 'Angela Howell', 'murphyjorge@hotmail.com', '4531d0ea8041dc6351064930aebda64a2b530e2d89dfa712ee25863235f277b5', 'user', 'mr', 'https://i.pravatar.cc/150?img=37', '2022-05-25 12:45:55', '2026-01-29 14:30:54', NULL, 'active'),
(33, 'Stacy Mercado', 'ogreen@yahoo.com', '6c131c33340e47a20c48fd4762501bde1ba0601bb06c5878e1e2829d6a32cc10', 'user', 'ta', 'https://i.pravatar.cc/150?img=51', '2022-12-15 09:20:59', '2026-01-31 16:14:08', NULL, 'active'),
(34, 'Richard Rocha', 'kevin22@gonzalez-chavez.com', '076941445d84fa49c2a2a981895fa02aa8b6a27d44a6dbfcc09cf48031154703', 'user', 'gu', 'https://i.pravatar.cc/150?img=64', '2024-12-08 17:47:40', '2026-02-01 23:23:25', NULL, 'active'),
(35, 'Scott Leach', 'barrettian@hotmail.com', '864a42c381c06e405a9918492ba54e82b79cb0f6bd0c1b672c3a159c753bb22f', 'user', 'en', 'https://i.pravatar.cc/150?img=36', '2020-12-14 17:12:49', '2026-01-22 13:48:21', NULL, 'active'),
(36, 'Rebecca Garcia', 'brittany00@yahoo.com', 'a2e5ead269f229bb55eb2c63e5165af293b7dc8fd6baf79994aed080180ae132', 'user', 'gu', 'https://i.pravatar.cc/150?img=59', '2025-12-29 01:04:20', '2026-01-10 01:54:57', NULL, 'active'),
(37, 'Adrian Mullins', 'autumn42@hancock.com', 'a05c35b1df20ca4a982f9089317f16dc74a4544fabce73d2288b5d797fb65cd5', 'user', 'ta', 'https://i.pravatar.cc/150?img=65', '2021-07-31 00:27:14', '2026-01-12 14:08:30', NULL, 'active'),
(38, 'Timothy Diaz', 'thomastanya@yahoo.com', 'ae17bc1407267bd3382b943c93ba5d8507c1b2504e12a756a419dab720ad5d32', 'user', 'en', 'https://i.pravatar.cc/150?img=57', '2025-09-23 07:27:34', '2026-01-12 06:17:20', NULL, 'active'),
(39, 'Judy Little', 'connor91@hotmail.com', 'd712681454ca0a8d409f640a0bee8fce3f11eb78d828b15c166d9f9a22c9f25f', 'editor', 'mr', 'https://i.pravatar.cc/150?img=7', '2024-11-11 14:40:23', '2026-01-07 17:38:59', NULL, 'active'),
(40, 'Taylor Jennings', 'cherylcook@gmail.com', '427ded9f81701209d4e3177540a50fe197515e214a417ac8312e7f2554156f1b', 'editor', 'mr', 'https://i.pravatar.cc/150?img=24', '2024-01-30 21:41:04', '2026-01-18 13:45:57', NULL, 'active'),
(41, 'James Gonzales', 'grahamdonna@dickson.com', 'd4cd12a60cdfb6498eeb23c7af601f19f946c07f479a530e98c26ac7902b5d18', 'user', 'hi', 'https://i.pravatar.cc/150?img=9', '2021-04-21 21:51:53', '2026-01-09 07:51:13', NULL, 'active'),
(42, 'Stephen Griffith', 'davidsonlisa@cherry.com', '25437281aa404811c9b4cdd47f6811b94c3d2523e14edad84607dcbc0a86b349', 'user', 'gu', 'https://i.pravatar.cc/150?img=19', '2025-11-03 03:06:46', '2026-01-15 22:26:56', NULL, 'active'),
(43, 'Linda Horton', 'ejohnson@jackson.com', '222640ea57b6edd26277b6ef32ac3424dde1df487f3ff029650ab337ffa6394e', 'user', 'ta', 'https://i.pravatar.cc/150?img=4', '2024-10-17 22:42:23', '2026-01-06 10:53:25', NULL, 'active'),
(44, 'Brian Huerta', 'bellchristopher@young-johnson.com', '14cd783de96eed825c7614c74d174e244d2694a2e89fd1b38ec8797533a490b2', 'editor', 'gu', 'https://i.pravatar.cc/150?img=48', '2021-08-17 03:01:34', '2026-01-08 05:00:29', NULL, 'active'),
(45, 'Hannah Ward', 'bberry@forbes-ewing.com', 'f0c00aa51a1eb89e5954e30eb8b72b051df5fc8c6971f12dfca50e548677edc8', 'user', 'ta', 'https://i.pravatar.cc/150?img=43', '2025-05-12 17:14:00', '2026-01-13 00:02:26', NULL, 'active'),
(46, 'Jonathan Stewart', 'wbarnett@wilkins.com', '5e80c5218f5a4406e2643c03d92efdeacf8e2a105e078ca38cd113e826a50ba8', 'editor', 'hi', 'https://i.pravatar.cc/150?img=23', '2022-09-04 16:10:23', '2026-01-30 20:10:57', NULL, 'active'),
(47, 'John May', 'stevenrobinson@mann-collins.info', '52cf9b9afac8540fbc542e4871e64916ecfa51fec71bc9ef61aade23db6ce0f2', 'user', 'hi', 'https://i.pravatar.cc/150?img=10', '2025-09-19 18:15:50', '2026-01-07 01:19:03', NULL, 'active'),
(48, 'Jeffrey Harrison', 'katkinson@gmail.com', '189409b7e064dfe1f6164b4b445c338daf73db07874527094a58e19687cc4ae9', 'editor', 'hi', 'https://i.pravatar.cc/150?img=14', '2024-10-18 00:20:31', '2026-01-29 22:13:21', NULL, 'active'),
(49, 'Linda Larsen', 'tchambers@hotmail.com', '39b7503b91914dbebda75ce69675788c9db098a29798bc022792c3ed66b8c7e3', 'user', 'en', 'https://i.pravatar.cc/150?img=51', '2020-06-22 05:53:13', '2026-01-08 10:52:12', NULL, 'active'),
(50, 'Thomas Barrera', 'iramos@gmail.com', '2c815556ac305010cf5d42322553b9eff8d57f6c3eb5efc6409d590a5ad3d2aa', 'editor', 'ta', 'https://i.pravatar.cc/150?img=24', '2023-06-02 22:24:30', '2026-01-05 13:12:24', NULL, 'active'),
(51, 'Jocelyn Wright', 'antoniobrooks@hotmail.com', '1eef2c28346d89bd99ebcd0070b229e245784a7d6b8a4bd21e76dfde0dccea1d', 'editor', 'mr', 'https://i.pravatar.cc/150?img=65', '2020-02-10 14:57:26', '2026-01-21 02:16:28', NULL, 'active'),
(52, 'Ryan Mitchell', 'deanna41@hotmail.com', '5eb36fafeb69ca3b9a5a75dc3b53243ba2fef07d59670e15a54d601ca801bea4', 'user', 'mr', 'https://i.pravatar.cc/150?img=38', '2021-09-29 00:09:12', '2026-01-17 12:41:51', NULL, 'active'),
(53, 'Steven Bryant', 'lisa89@yahoo.com', '565bb0d9ebc0ace81903e9f5678fe27ca0bf6b27a2154b77a4f87ce0e39866f7', 'editor', 'en', 'https://i.pravatar.cc/150?img=18', '2021-01-06 20:33:38', '2026-01-06 09:26:06', NULL, 'active'),
(54, 'Jacqueline Castillo MD', 'jhunter@foster.info', '571e096755211e4993466606080d88b550d03b4ae9a40305ce61b88a81a6edec', 'user', 'mr', 'https://i.pravatar.cc/150?img=66', '2021-07-06 11:50:39', '2026-01-02 06:40:00', NULL, 'active'),
(55, 'Diane Johnson', 'morgankevin@gmail.com', 'b7d62d53a93848ebce6a9161e5663d506e667413bb84a0b1828092b0abf02ecd', 'user', 'hi', 'https://i.pravatar.cc/150?img=23', '2022-01-22 01:02:25', '2026-01-17 20:27:28', NULL, 'active'),
(56, 'Melissa Jones', 'angelajordan@mills.net', '71a9fda01316595362e367978748644ad7e04272ca6e0e6030deabf702ac13bf', 'editor', 'mr', 'https://i.pravatar.cc/150?img=48', '2020-01-06 10:19:20', '2026-01-15 15:07:20', NULL, 'active'),
(57, 'Heather Bryant', 'joneslori@gilmore-palmer.biz', '5ef783a7ead6ccbe9f1ac325530f54beeef6e698e3e2bfa1c98aecb9a5e04e39', 'editor', 'gu', 'https://i.pravatar.cc/150?img=61', '2023-02-09 01:27:54', '2026-01-23 01:35:05', NULL, 'active'),
(58, 'Krystal Herring', 'robertsonerica@carter.com', '22009b852dcb358933357096b1d1c4e95c8360ad84cba09eafbd5b1e5e0d5f10', 'user', 'mr', 'https://i.pravatar.cc/150?img=20', '2020-08-26 03:13:47', '2026-01-07 14:37:52', NULL, 'active'),
(59, 'Michael Meyer', 'jonathan47@burns.com', 'ff653f171e4c4e77a231e58f9794e2061ef4000f84608945b6d0868a8762e3e4', 'user', 'ta', 'https://i.pravatar.cc/150?img=67', '2022-10-15 11:00:13', '2026-01-13 09:55:44', NULL, 'active'),
(60, 'Lauren Johnson', 'dixonelizabeth@jones.org', 'f8c7d0193b96904acaf00d67051b521fefa51e08c1dba89d10db8c1b0c711b79', 'user', 'en', 'https://i.pravatar.cc/150?img=68', '2021-02-07 17:21:34', '2026-01-31 15:21:23', NULL, 'active'),
(61, 'Alicia Glass', 'jordanchristine@mcclure.com', 'ad4102e94cd05fc0050548c012b2b0e04baebecb4ff8101b0eb9c572e76796e2', 'user', 'gu', 'https://i.pravatar.cc/150?img=56', '2025-03-19 17:59:15', '2026-01-19 20:42:29', NULL, 'active'),
(62, 'John Evans MD', 'sanchezanthony@barton.biz', 'e1c50a3fc1ac9c23e5c98b0808561e2894c9cd8c120673ea906a2dfaf3ebaf5d', 'user', 'gu', 'https://i.pravatar.cc/150?img=48', '2026-02-01 16:39:14', '2026-01-08 07:14:57', NULL, 'active'),
(63, 'Tracy Smith', 'colelisa@hotmail.com', '844980af341709513a38a544f01413953d2fcc794027d4a95bb7f355d321ffd0', 'editor', 'gu', 'https://i.pravatar.cc/150?img=9', '2025-04-15 20:25:59', '2026-01-18 02:16:48', NULL, 'active'),
(64, 'Leah Michael', 'lauramullins@hunter.com', '3ceb9e04eef45a434986fee0cd29e9a996f232dd1bfaeb39643887f2ebe4d1ba', 'user', 'en', 'https://i.pravatar.cc/150?img=36', '2023-04-12 00:17:55', '2026-01-03 09:45:22', NULL, 'active'),
(65, 'Tammy Garcia', 'carol10@miranda-hobbs.net', '77fc96591a46a5e9d0aca72b4893b8ddf5946211a0b28f01c659484d93a9425c', 'user', 'gu', 'https://i.pravatar.cc/150?img=36', '2024-05-25 14:56:52', '2026-01-20 18:51:05', NULL, 'active'),
(66, 'Jamie Mason', 'anthonyblack@greene.com', '0d5b9b18d4f9c34237afbb4c2999a2ba73122c7dfeb61c4c9963676ee06eb43f', 'editor', 'en', 'https://i.pravatar.cc/150?img=32', '2025-05-05 10:31:04', '2026-01-04 19:49:02', NULL, 'active'),
(67, 'Haley Mcdonald', 'ymorris@hotmail.com', '80d164c52980961d4531109b768e5ccbf95ec2b26e184fb843cd8c4338defbec', 'editor', 'gu', 'https://i.pravatar.cc/150?img=30', '2023-11-16 19:40:46', '2026-01-20 08:09:35', NULL, 'active'),
(68, 'Robert Frost', 'david48@mendez.com', 'f1ee6e359890895e1f0512ca06b5fa3a1779e67024fe00108f5e2119b8057cc5', 'editor', 'hi', 'https://i.pravatar.cc/150?img=35', '2024-07-27 17:41:27', '2026-01-16 17:32:30', NULL, 'active'),
(69, 'Karen Cross', 'davisnicholas@davis-cunningham.com', 'e504f0ea5f7b50e98536641c6928a8226108665d31bc626017f6a89d224a5b1e', 'user', 'mr', 'https://i.pravatar.cc/150?img=68', '2024-08-05 10:38:01', '2026-01-22 17:38:36', NULL, 'active'),
(70, 'Terry Sloan', 'ana22@hotmail.com', 'dacccc07845b7d83d7725d7056c76e6c2a49d6ace43aa6830c75921fc14948f1', 'user', 'en', 'https://i.pravatar.cc/150?img=3', '2021-04-16 12:48:02', '2026-01-07 06:44:23', NULL, 'active'),
(71, 'Eric Howell', 'nroberts@gmail.com', '42b54569f2c4301b227f495b9c3610a9f41d214c066d7407c3d753565d4aac02', 'user', 'hi', 'https://i.pravatar.cc/150?img=20', '2025-06-11 00:23:10', '2026-01-18 04:24:14', NULL, 'active'),
(72, 'Alex Hurley', 'david74@norman-miller.org', '606bd759fa2671bce77944287d4a8e5a42d6d7973f2a58134bc515057cb25511', 'user', 'hi', 'https://i.pravatar.cc/150?img=51', '2022-09-23 20:34:04', '2026-01-29 21:23:55', NULL, 'active'),
(73, 'Shelley Marshall', 'terrancesmith@tanner.com', '7105927170391bcd6d4cc36ee3eb9cf9b7878bb03bc8a939489bb9d5f49c8966', 'user', 'hi', 'https://i.pravatar.cc/150?img=8', '2020-08-22 00:36:59', '2026-01-14 01:16:00', NULL, 'active'),
(74, 'Joel Gonzales MD', 'gwood@baldwin-mcgee.com', '8353597b7c98602dfa38d2a6388487f2a94155ebd173d1fc61daa83a83d835f4', 'editor', 'gu', 'https://i.pravatar.cc/150?img=67', '2023-08-09 21:16:32', '2026-02-01 06:07:13', NULL, 'active'),
(75, 'Joseph Jordan', 'camposedward@simon.com', 'b3508590721aa35302c4451f9f64d30b7f746e05de2757491599665dbe5eb3b2', 'user', 'gu', 'https://i.pravatar.cc/150?img=7', '2023-02-24 12:44:30', '2026-01-12 01:05:43', NULL, 'active'),
(76, 'Amanda Carter', 'htorres@smith-blanchard.com', 'b91e4b9d22c718d77b6f686f640c9d0872a3e70e117a6139206fdb1ad26d144a', 'editor', 'gu', 'https://i.pravatar.cc/150?img=33', '2022-03-25 01:00:17', '2026-01-02 21:47:52', NULL, 'active'),
(77, 'Jennifer Harding', 'bentonmelissa@gmail.com', '2395909775f38c105d06b5148dafea31b55b0c97a725983e6d7349d9216b09c4', 'user', 'hi', 'https://i.pravatar.cc/150?img=48', '2024-10-22 16:09:33', '2026-01-11 18:03:04', NULL, 'active'),
(78, 'Samantha Herrera', 'julie79@yahoo.com', 'a19f6d8b97f5aa220530534773379ed6fcd9688ccefb583db477395824026a67', 'user', 'hi', 'https://i.pravatar.cc/150?img=16', '2023-08-01 07:47:01', '2026-01-20 04:03:44', NULL, 'active'),
(79, 'Olivia Castillo', 'paulmartinez@hotmail.com', 'e95f838ba2fe48b0b402af333249a9f34763797954d6accc7eb44ac1b3b9b77f', 'user', 'mr', 'https://i.pravatar.cc/150?img=67', '2023-08-24 00:02:39', '2026-01-01 06:41:57', NULL, 'active'),
(80, 'Christina Romero', 'marybecker@yahoo.com', 'f11e86e08ef42fd3da48e3391c2657887fc864d648f2ff0da3dc74b31504da52', 'user', 'hi', 'https://i.pravatar.cc/150?img=22', '2021-06-26 07:49:10', '2026-01-04 22:52:55', NULL, 'active'),
(81, 'Mark Macdonald', 'javier69@yahoo.com', '8dcf76415a9d8b36a08b0e3ed4032bbab1db022d3b3ca6bc5c74245477a87195', 'user', 'gu', 'https://i.pravatar.cc/150?img=16', '2021-01-16 00:08:19', '2026-01-07 03:23:19', NULL, 'active'),
(82, 'Cathy Hunter', 'timothy19@morgan-arnold.org', '9b6bad10ede2958d6a8fdd201eb1ef01b245daad1e751ae3d3ea5da739e7cd1f', 'editor', 'mr', 'https://i.pravatar.cc/150?img=6', '2020-09-09 13:19:03', '2026-01-08 05:49:34', NULL, 'active'),
(83, 'Robert Davis', 'katiejohnson@yahoo.com', 'f866148569411086da0ad2086956295cfea024f53eec9095d6eb22db41b35a01', 'user', 'hi', 'https://i.pravatar.cc/150?img=13', '2025-03-04 14:23:26', '2026-01-02 11:18:32', NULL, 'active'),
(84, 'Mrs. Latasha Thomas', 'iharper@hotmail.com', 'ced1127bff20387c420e02a2d2fac19379ef82846d6a4486df051fd40db503ba', 'editor', 'en', 'https://i.pravatar.cc/150?img=51', '2023-05-03 07:58:16', '2026-02-03 23:00:15', NULL, 'active'),
(85, 'Robert Torres', 'hokristina@jacobson-miller.com', '2f533c7d89a1965a5420d58355230eda1665bb8901b72cacd8e5c8fe555bb7da', 'user', 'hi', 'https://i.pravatar.cc/150?img=68', '2024-10-02 16:36:45', '2026-01-30 07:05:19', NULL, 'active'),
(86, 'Stephanie Reyes', 'alan70@hotmail.com', 'ebb6d173b441093c45eab2c2ee3825918387301dad5606f51a1a351f208be57f', 'editor', 'en', 'https://i.pravatar.cc/150?img=27', '2022-05-25 18:04:37', '2026-01-16 12:05:57', NULL, 'active'),
(87, 'Christine Harris', 'brycefrey@gmail.com', '46bf1af2cdb81c54d4e8d750ea88d90266902440346a6dc952b2f891b4c7900c', 'user', 'en', 'https://i.pravatar.cc/150?img=45', '2020-11-12 22:40:57', '2026-02-01 18:51:15', NULL, 'active'),
(88, 'Joe Sanchez', 'vaughanpaula@hotmail.com', '164b1f0963a19580cc8d107a9f3580245eca89321a987184882144f4a160d3aa', 'user', 'gu', 'https://i.pravatar.cc/150?img=54', '2022-03-28 08:55:18', '2026-01-18 05:53:27', NULL, 'active'),
(89, 'Rachel Matthews', 'aaronaguilar@martinez.org', '0e504ea7dcd8deb1efd442fa4b32fce3dbbff5e6b7f7ca31b52ddff57df590e4', 'editor', 'gu', 'https://i.pravatar.cc/150?img=2', '2022-03-22 03:49:30', '2026-01-24 22:07:40', NULL, 'active'),
(90, 'Mark Taylor', 'james31@hotmail.com', '202c52a0e1352a1b69ad28428e06db81145968c85df976b2f4e3e0985d9ea620', 'user', 'mr', 'https://i.pravatar.cc/150?img=32', '2024-05-05 07:34:51', '2026-01-17 08:49:02', NULL, 'active'),
(91, 'Richard Brown', 'brad04@lewis-murphy.biz', '8b9111a14c373115bba48aa96a1512643b63f4daeb0dfa84c4300bb9d5ae62af', 'editor', 'mr', 'https://i.pravatar.cc/150?img=19', '2022-08-31 22:13:23', '2026-01-18 08:17:43', NULL, 'active'),
(92, 'Austin Frazier', 'marshallamanda@gmail.com', '801595e5075f85ab521454d08762f7f0d42f149c4d7561186636be028d464245', 'user', 'mr', 'https://i.pravatar.cc/150?img=31', '2022-01-17 11:50:01', '2026-01-22 11:33:54', NULL, 'active'),
(93, 'Mrs. Pamela Smith DDS', 'jameswilson@mayer-kim.biz', '88a2dcba3c691b077fc0c55cc54e383a7f526371ac9300f742a009c65c2591d5', 'user', 'hi', 'https://i.pravatar.cc/150?img=3', '2022-06-26 11:39:03', '2026-01-12 04:34:55', NULL, 'active'),
(94, 'Deborah Michael', 'rodriguezwilliam@kramer.com', '4a5506f3fc9a9f98a98a74cf0106aceb099a7bf3b8dd1a7e56b6fddb21f3d4ba', 'user', 'mr', 'https://i.pravatar.cc/150?img=67', '2025-03-13 11:33:14', '2026-01-29 00:02:45', NULL, 'active'),
(95, 'Tamara Leach', 'qcobb@yahoo.com', 'e1762b28f48cb8d91c7e9a691cc802a296e9d3635133511af5e88c0342e441bf', 'user', 'en', 'https://i.pravatar.cc/150?img=62', '2025-09-08 15:42:02', '2026-01-31 16:26:43', NULL, 'active'),
(96, 'Vanessa Garza', 'matthewsjoseph@stone.net', 'd55ceb6fe73676fa74dbbdbcdb7282a3303f6e5eeb52e34c5746540d455faa9d', 'user', 'gu', 'https://i.pravatar.cc/150?img=54', '2023-11-06 16:28:58', '2026-01-21 09:06:14', NULL, 'active'),
(97, 'Joseph Jones', 'wrightjustin@reid.com', 'a75edf7ab4d2f3f401e689eab922cfa4ff6a03699c293a6bf90008793d0f2d23', 'editor', 'hi', 'https://i.pravatar.cc/150?img=18', '2025-02-25 02:21:39', '2026-01-27 17:54:55', NULL, 'active'),
(98, 'Patricia Allen', 'tinazamora@middleton-collins.com', '18b53340f9849cd7ad8920a966930eb83a843e987e8f7cb42234b7eeaac2665e', 'user', 'en', 'https://i.pravatar.cc/150?img=4', '2025-01-02 05:37:19', '2026-01-31 06:02:28', NULL, 'active'),
(99, 'Adam Henderson', 'hernandeztony@miller.biz', 'e001aa9ef262518cac1c4d621c06808355ac33cff5d813fabca9c07d410ed1d7', 'user', 'gu', 'https://i.pravatar.cc/150?img=67', '2020-03-09 03:40:33', '2026-01-16 14:53:48', NULL, 'active'),
(100, 'Evelyn Flynn', 'williamnguyen@yahoo.com', '4fbcdfc6a031e368f34e00cd70aca243c772bc1e58cbec7632eb3c39b2364e14', 'editor', 'mr', 'https://i.pravatar.cc/150?img=4', '2024-08-28 12:51:21', '2026-01-23 21:27:13', NULL, 'active'),
(101, 'Amanda Fowler', 'lawrencerichard@willis.info', '9cd68d6b30ec7ec4ec7e65725aba518caa1d6c16917a828560d3316770844791', 'user', 'gu', 'https://i.pravatar.cc/150?img=69', '2022-10-26 11:39:44', '2026-01-19 11:54:26', NULL, 'active'),
(102, 'Brenda Jones', 'matthewsingh@hartman-romero.info', '005e7db66320f837113fc2749e6e44758accd612e065eb50b9a139c09ab655a5', 'editor', 'mr', 'https://i.pravatar.cc/150?img=11', '2021-08-21 10:42:16', '2026-01-04 22:54:57', NULL, 'active'),
(103, 'Grace Davis', 'patrickvelasquez@gmail.com', '8f1571e250199719063a908ac2f70849a013474388848fa6a47ad4a4f76b18da', 'editor', 'mr', 'https://i.pravatar.cc/150?img=48', '2025-04-16 12:56:12', '2026-01-09 00:05:06', NULL, 'active'),
(104, 'Nicole Kirby', 'collinsrachel@gmail.com', 'f664164633de7ad8835995f00d11fac82b52ffabc070344283cdbb996e1f6be3', 'user', 'gu', 'https://i.pravatar.cc/150?img=66', '2023-12-24 23:01:39', '2026-01-02 06:32:45', NULL, 'active'),
(105, 'Margaret Smith', 'patriciagarza@donovan.com', 'd1850dd4aa836ebd9a25d2fc79be1a9c5d0a903ab613a9577e0132e54a73a5a5', 'user', 'mr', 'https://i.pravatar.cc/150?img=18', '2026-01-27 23:25:16', '2026-01-03 04:54:11', NULL, 'active'),
(106, 'Elizabeth Frazier', 'chavezmichele@willis.com', 'c0fe3cc4611129e8c49aa12dff71579b3415b74ec40cd1e21554dc51fd6f863a', 'user', 'en', 'https://i.pravatar.cc/150?img=44', '2023-07-25 11:12:25', '2026-01-09 01:40:20', NULL, 'active'),
(107, 'Martha Fisher', 'amandawarren@yahoo.com', '6eaa83e7209304adc65b700767f217f2411f37394102d6b7b0f5cff151435121', 'editor', 'gu', 'https://i.pravatar.cc/150?img=64', '2022-06-16 00:17:06', '2026-01-23 02:45:28', NULL, 'active'),
(108, 'Kimberly Glover', 'vwilson@yahoo.com', '3a32f07bfb136a664cf05d1a75730fc030b87e71ffaadbac4aeb2b3baead6dda', 'user', 'en', 'https://i.pravatar.cc/150?img=6', '2025-09-23 01:31:25', '2026-01-06 06:25:51', NULL, 'active'),
(109, 'John Rangel', 'eddie93@williams.com', '817331b795beddf5ca5df1c0e6ecc7210133ab6473ae8b6073e6932c0a8adff6', 'user', 'hi', 'https://i.pravatar.cc/150?img=32', '2022-10-08 19:29:36', '2026-01-16 15:31:04', NULL, 'active'),
(110, 'Sarah Davidson', 'christopherdavis@anderson-garcia.net', 'ba9326a1a89d01ff8e528f3d6b43b1f26a705b0e403936690fecbcd3a9bdaf07', 'editor', 'hi', 'https://i.pravatar.cc/150?img=25', '2021-10-10 05:13:23', '2026-01-21 09:47:29', NULL, 'active'),
(111, 'Amber Shaffer', 'ncarpenter@gmail.com', '0e4c21e8af2a2132b8894625a7d46397f7ef9ce44d719468656994798337d35a', 'editor', 'ta', 'https://i.pravatar.cc/150?img=48', '2021-02-26 16:59:42', '2026-01-08 06:32:22', NULL, 'active'),
(112, 'Charles Adams MD', 'nhood@yahoo.com', 'f0ce906a8e6eb3aa14f05bbc35be2180ef3d83a55335ed788ba211d9aad5916c', 'editor', 'ta', 'https://i.pravatar.cc/150?img=11', '2022-02-06 15:18:37', '2026-01-20 10:20:44', NULL, 'active'),
(113, 'Jordan Mahoney', 'drew01@montgomery.net', 'de5d706a9b89fc1462501005952a6c13672d9adcb6a6e841c482e52523df73b1', 'user', 'en', 'https://i.pravatar.cc/150?img=64', '2024-10-04 02:00:12', '2026-02-02 03:47:49', NULL, 'active'),
(114, 'Kimberly Horne', 'charles76@anderson.info', 'c90db3b388e0ae73f2cd8ed9eef0cf2893ac4f132d7e24559d9a55eb1f366bcf', 'user', 'en', 'https://i.pravatar.cc/150?img=37', '2025-01-06 13:56:43', '2026-01-10 03:02:41', NULL, 'active'),
(115, 'Megan Aguirre', 'uberry@jennings-hawkins.com', '075528e07f938651f48fb0125f65794e6f522fb0e8cfcd3dfa9f936fe49b1356', 'user', 'en', 'https://i.pravatar.cc/150?img=13', '2022-08-19 19:36:19', '2026-01-02 06:16:01', NULL, 'active'),
(116, 'Grace Reyes', 'amy42@yahoo.com', 'ec363e4006278b6abcee097eda81991c15917536c300d1c6c14fefa17526e87c', 'user', 'ta', 'https://i.pravatar.cc/150?img=43', '2025-03-25 10:04:27', '2026-01-30 00:14:37', NULL, 'active'),
(117, 'Jason Andrews', 'george96@hotmail.com', '3dd183fd045e5cfa7f814ebfb2ea182a91ad29c629bab09852e7aea5431b29eb', 'user', 'hi', 'https://i.pravatar.cc/150?img=17', '2022-08-28 19:03:31', '2026-02-03 23:08:48', NULL, 'active'),
(118, 'Nathaniel Zimmerman', 'csmith@clark.com', '83dcbc1d3f52565198f76ba23267e58cd7d0da4219d487c01349d24f12205b55', 'user', 'en', 'https://i.pravatar.cc/150?img=43', '2022-10-16 00:21:26', '2026-01-15 13:52:44', NULL, 'active'),
(119, 'Tina Smith', 'lcastillo@conner.com', '39e8c00025b655efd21dfc2ba8c04785c15b89411169d4004caf03bbdf8b1d91', 'editor', 'en', 'https://i.pravatar.cc/150?img=64', '2021-09-21 10:14:27', '2026-01-10 09:15:21', NULL, 'active'),
(120, 'Dr. Russell May', 'murphyelizabeth@walsh.info', '3424cede2cb8e114f659da19132a4802661564fc3aca332c4f7e1b7ace41b176', 'editor', 'gu', 'https://i.pravatar.cc/150?img=48', '2022-10-11 07:26:50', '2026-01-04 22:10:24', NULL, 'active'),
(121, 'Theresa Johnston', 'wayne51@yahoo.com', '5adbd78434f2b01fafc1da9f5b9b5f099faa9ae4ac5c7a18d35340ec5f30078d', 'user', 'mr', 'https://i.pravatar.cc/150?img=17', '2021-12-20 00:01:25', '2026-01-19 15:37:04', NULL, 'active'),
(122, 'Victor Collins', 'katherinesutton@gmail.com', '8b99e5b6f310ca8c5e4533eb7cd5b6efffb4760b5f2665fdc2b347f08e383a50', 'user', 'mr', 'https://i.pravatar.cc/150?img=21', '2021-08-12 12:23:48', '2026-01-04 06:26:37', NULL, 'active'),
(123, 'Erica Ortiz PhD', 'kevin01@glenn.org', 'd09e5260aff8012fd0eba77dff01b5ad1b681b9464ce277069637ba73a422412', 'user', 'hi', 'https://i.pravatar.cc/150?img=31', '2020-07-13 13:49:02', '2026-02-02 07:24:10', NULL, 'active'),
(124, 'James West', 'smithmaria@smith-higgins.com', '392117decf0d7ffe18e5f903809eb6337ef39e85c57699266d50cbeaf7e3db76', 'user', 'gu', 'https://i.pravatar.cc/150?img=41', '2021-06-16 09:09:08', '2026-01-14 14:23:01', NULL, 'active'),
(125, 'Scott Suarez', 'allencastillo@yahoo.com', 'b939b1edc8a913d9291867df26836efd6c08e7f50c30526e39dfb8150892caa5', 'user', 'hi', 'https://i.pravatar.cc/150?img=38', '2021-11-07 02:29:27', '2026-01-28 19:16:40', NULL, 'active'),
(126, 'Danielle Johnson', 'sarah83@hotmail.com', '423fb6274bd7efa319ec136bb98748080b5b573aff102b86cf0411ecae7c413f', 'editor', 'mr', 'https://i.pravatar.cc/150?img=33', '2024-12-25 00:46:20', '2026-01-28 11:48:09', NULL, 'active'),
(127, 'Leslie Smith', 'nicolecase@gmail.com', 'e13116b3df3b737e1123abca294705a30c476ebf6dde6faf691b2c7a8e219ad8', 'editor', 'gu', 'https://i.pravatar.cc/150?img=16', '2024-09-21 13:17:59', '2026-01-14 15:36:41', NULL, 'active'),
(128, 'Matthew Sanchez', 'lsmith@gmail.com', '66f51bb048777e7f8d3784de20d8e561a97ed657e733c3e45bfb2923ae3261e2', 'editor', 'en', 'https://i.pravatar.cc/150?img=34', '2024-08-22 17:57:51', '2026-01-04 09:40:34', NULL, 'active'),
(129, 'Carmen Adams', 'richardrivera@yahoo.com', '1f84df916d1ea2fbee7d1e2310431862b0bc79fc9d3cd8d5901fc88add9f29aa', 'user', 'mr', 'https://i.pravatar.cc/150?img=37', '2024-12-30 06:36:23', '2026-01-19 13:20:47', NULL, 'active'),
(130, 'Lauren Fitzpatrick', 'eric07@kelley-ortega.biz', 'd9a50fb50dcd7a72df5a0289ce6f4e6d17adac97fbe02fe0c46604504b341cbd', 'user', 'gu', 'https://i.pravatar.cc/150?img=58', '2022-06-14 18:48:50', '2026-01-28 20:33:26', NULL, 'active'),
(131, 'Kenneth Patterson', 'mgibson@yahoo.com', '0fb51c3d5a43f63637c2f10c73f9a45534ded229c09fdad6c354a116741da31e', 'user', 'hi', 'https://i.pravatar.cc/150?img=1', '2020-04-11 02:43:59', '2026-02-01 15:02:21', NULL, 'active'),
(132, 'Jonathan Lara', 'timothy69@lewis.com', '61deea7a20e08199fc475957a075bad11c059f7c30c46f446fbeb9a683aee4b7', 'user', 'ta', 'https://i.pravatar.cc/150?img=27', '2023-11-23 14:30:01', '2026-02-01 09:59:30', NULL, 'active'),
(133, 'Kathryn Harris', 'coopermichael@gmail.com', '5384510ef20ab07bb0c7222105cebfd1bfaa3d5f11817a5b69eeec6e578a98c8', 'editor', 'en', 'https://i.pravatar.cc/150?img=61', '2022-07-12 18:52:53', '2026-02-02 20:34:13', NULL, 'active'),
(134, 'Brent Bautista', 'akelly@hotmail.com', '6c226d68a2a04e2838f8fe170cc511a43d019e6fbe7b46fa80b089e152bfefe3', 'editor', 'hi', 'https://i.pravatar.cc/150?img=53', '2024-12-25 03:51:25', '2026-01-26 03:29:28', NULL, 'active'),
(135, 'Carlos Fowler', 'krogers@hartman.info', '6d81d354705ee78156b1576c18b2914f3602923526ccd0174b2410b4f6564f04', 'user', 'mr', 'https://i.pravatar.cc/150?img=10', '2023-05-18 10:13:44', '2026-01-27 16:55:29', NULL, 'active'),
(136, 'Robert Doyle', 'brandonhenson@wood-anderson.com', '8a509661c139df3ed52f196da827f36eac5daa9e4faa29c296da8af07bcc4068', 'editor', 'hi', 'https://i.pravatar.cc/150?img=30', '2021-05-03 16:19:58', '2026-01-13 20:07:36', NULL, 'active'),
(137, 'Carol Lester', 'robertowagner@douglas-phelps.com', '4a4fcb0d3da54cadcbd3b7920ad2153584cbcdc6474dd27b58d22d78be5174fa', 'editor', 'mr', 'https://i.pravatar.cc/150?img=13', '2023-10-22 14:53:44', '2026-01-07 23:16:16', NULL, 'active'),
(138, 'Cynthia Smith', 'davidclark@hotmail.com', 'e2fd29d8eaabb189c6b69853e8a85bfd5c136469b80f2f6c550e69809843bdb7', 'user', 'gu', 'https://i.pravatar.cc/150?img=66', '2024-01-18 15:58:20', '2026-01-25 16:34:36', NULL, 'active'),
(139, 'John Beard', 'parkermelissa@yahoo.com', '990ea0920cfe1dcaede9097b6a5711936ae1a9256b9986caa6549ce412fdae2c', 'user', 'hi', 'https://i.pravatar.cc/150?img=1', '2025-06-18 02:58:33', '2026-01-06 18:27:01', NULL, 'active'),
(140, 'Stephen West', 'diazjoshua@yates.com', '07b5e920b80de8d59c328628781a8d0a673db5977d219dd65f2f21ef9ef610bc', 'user', 'ta', 'https://i.pravatar.cc/150?img=28', '2024-06-24 23:48:35', '2026-01-28 23:37:38', NULL, 'active'),
(141, 'Charles Rubio', 'owensjulie@hotmail.com', '647e3713606e088c2dddc051c5dfd29c419eadfb4fe12c27cbdc9ed6b0a9cce7', 'user', 'gu', 'https://i.pravatar.cc/150?img=10', '2021-12-09 07:15:26', '2026-01-19 03:15:41', NULL, 'active'),
(142, 'Gabrielle Wise', 'rperez@oconnor.net', 'ad3f130b8c7e46d6f03293305320ad8a8766eeebed750668f1ef5ded8d115714', 'user', 'mr', 'https://i.pravatar.cc/150?img=42', '2025-11-24 03:04:30', '2026-01-24 08:42:47', NULL, 'active'),
(143, 'James Smith', 'masonallen@le.net', '0d2b3f62a085bf291fe00775eacf692556b18285c5a9497fe841513483d6003a', 'editor', 'hi', 'https://i.pravatar.cc/150?img=19', '2022-05-12 14:23:02', '2026-01-03 07:37:41', NULL, 'active'),
(144, 'Melissa Gilmore', 'kschaefer@richards.com', '50345cfe2249c6f3906f317164e5533a22fa2ca1f465c5103b9b42d38258c206', 'user', 'en', 'https://i.pravatar.cc/150?img=26', '2023-06-04 01:49:08', '2026-01-18 14:18:54', NULL, 'active'),
(145, 'Victor Hill', 'kathrynbryant@gmail.com', '034e50066c4d11b2644ee667df5174e045257a352525d3ba0689e84eca592c8e', 'user', 'gu', 'https://i.pravatar.cc/150?img=27', '2025-01-06 00:01:31', '2026-01-03 02:38:56', NULL, 'active'),
(146, 'Greg Dillon', 'jacqueline72@chandler.com', '9f83f968d854f7282feb91d1025f5690aa855dc962df344b07f5f145516d42fc', 'editor', 'mr', 'https://i.pravatar.cc/150?img=31', '2023-02-22 10:53:53', '2026-01-28 18:32:28', NULL, 'active'),
(147, 'Kim Huber', 'amanda17@yahoo.com', '9a42d1f8b977ab01c7992045e4371e01cf0bbe32bcf87583fe45b7846d3297cd', 'user', 'hi', 'https://i.pravatar.cc/150?img=42', '2021-02-11 07:47:29', '2026-01-06 21:11:11', NULL, 'active'),
(148, 'Joshua White', 'lmiranda@baldwin.com', 'c6f8c4be65d66a4d0135fe4e7ce1856f55195fd1028c64e8f861c1ac9dbd63c3', 'editor', 'mr', 'https://i.pravatar.cc/150?img=46', '2023-01-13 07:08:25', '2026-01-25 16:53:30', NULL, 'active'),
(149, 'Michael Foster', 'danielkennedy@yahoo.com', 'b4a124ad007d2189d2ba02b4f259316b302799a05bec7f6c5e6b226b8c91abb2', 'editor', 'hi', 'https://i.pravatar.cc/150?img=68', '2025-07-13 18:20:58', '2026-02-01 12:36:20', NULL, 'active'),
(150, 'Aimee Anderson', 'daniel46@guerra.com', '603c40c31e447674252b530359f4f9db9a2c705b5766233ac7e91dd79d2050f3', 'user', 'hi', 'https://i.pravatar.cc/150?img=38', '2024-05-31 05:56:42', '2026-01-07 11:44:41', NULL, 'active'),
(151, 'Melissa Nash PhD', 'normagonzalez@gmail.com', 'a15e092e5821cade7e8ecb80da7ead5add0a064a7be86f671cf9add324750121', 'user', 'ta', 'https://i.pravatar.cc/150?img=57', '2024-06-25 10:49:49', '2026-01-07 04:48:28', NULL, 'active'),
(152, 'Gabriel Brown', 'pateljeffrey@roberts-berg.com', 'e572a1546f8cf7c2c28cc09b16aae6189ba62bc04ac5655eedcaf196bd872470', 'user', 'hi', 'https://i.pravatar.cc/150?img=53', '2020-05-17 05:36:22', '2026-01-17 02:18:19', NULL, 'active'),
(153, 'Joseph Hill', 'murraymichael@bray.biz', '1ea752903cdeaed52326b325960843c24cbd8af24d95aa0a2cf25524b3c2fdac', 'user', 'ta', 'https://i.pravatar.cc/150?img=50', '2023-07-11 23:03:08', '2026-01-15 12:17:16', NULL, 'active'),
(154, 'Kevin Campos', 'christian02@gmail.com', '6af4de6ccacf0f58ad5a66720e9564a8a578fba76477751d43abfe8b13149995', 'user', 'gu', 'https://i.pravatar.cc/150?img=1', '2021-05-23 23:34:26', '2026-01-16 01:16:43', NULL, 'active'),
(155, 'Shane Walker', 'vincentlisa@gmail.com', '64c866ca54601c468e2764160fe3c562dcc9e9d0926b9c45671d7f383a6bf74f', 'user', 'gu', 'https://i.pravatar.cc/150?img=30', '2024-09-29 07:40:14', '2026-01-14 01:19:03', NULL, 'active'),
(156, 'Jose Brown', 'torresjohnny@gmail.com', 'e5d2108e588ded0d8115fb8323dd88807695d1b2a7b1ecf95a1a5bfbf34ddcd7', 'user', 'mr', 'https://i.pravatar.cc/150?img=17', '2025-11-24 06:40:01', '2026-01-30 01:26:48', NULL, 'active'),
(157, 'Crystal Meyers', 'cynthiaevans@gmail.com', '31eeb7c05e73f8bd13ee08307e3f9d82cb3044d527c52aac75f13fbf075dc020', 'editor', 'gu', 'https://i.pravatar.cc/150?img=27', '2022-12-31 18:47:54', '2026-01-30 13:24:28', NULL, 'active'),
(158, 'Craig Lucas', 'stephen38@gmail.com', '75319204097570cf59200d4e32d0afa113817d169e68920be3be17302b6e9d24', 'user', 'en', 'https://i.pravatar.cc/150?img=26', '2024-10-06 14:58:27', '2026-01-24 18:32:12', NULL, 'active'),
(159, 'Beth Martin', 'john05@yahoo.com', 'c9f9523f9302a23f7b7b4c709584698b70747c51591664fb38e091a0e3a889a0', 'user', 'en', 'https://i.pravatar.cc/150?img=12', '2020-07-12 14:07:02', '2026-01-10 19:49:07', NULL, 'active'),
(160, 'Janice Huff', 'scott38@hotmail.com', 'dab8d2b368d9e71c595edb13128b1369a4872eef801e49e47409a3d055ec7cd2', 'editor', 'en', 'https://i.pravatar.cc/150?img=49', '2025-10-23 08:38:55', '2026-01-16 16:34:29', NULL, 'active'),
(161, 'Lisa Huynh', 'mitchellbrandon@mercado.com', 'a896164db7733d11745013227378ae598b3d6dca8078165896026ddc47f4f6af', 'user', 'hi', 'https://i.pravatar.cc/150?img=25', '2023-03-26 23:16:21', '2026-01-08 22:12:36', NULL, 'active'),
(162, 'Jennifer Miller', 'walkerkelly@jackson-sherman.com', '37cd11981d01c4083d4eef8411da8f33d59245f4e55046e528ac2066c6060dfa', 'user', 'ta', 'https://i.pravatar.cc/150?img=68', '2020-12-08 22:52:07', '2026-01-04 02:20:49', NULL, 'active'),
(163, 'Laura Byrd', 'richardcarter@richardson-perry.net', '712f9a9b613bc59461f10846ffb0050e202b129d090151e7c378d09de87c66b5', 'user', 'en', 'https://i.pravatar.cc/150?img=4', '2025-08-03 14:21:39', '2026-01-03 23:23:30', NULL, 'active'),
(164, 'Scott Ortiz', 'joseph30@walker.info', '39a055ed65692ee26ba203344a2ef12df165b184172e980b3c0cbd71c70d4e70', 'user', 'hi', 'https://i.pravatar.cc/150?img=10', '2020-01-26 13:07:36', '2026-01-29 01:37:14', NULL, 'active'),
(165, 'Steven Curtis', 'moranmargaret@yahoo.com', '204ff8510384dd39078a7c6844cf4fa9a30cd17bfba5b105a0cb3d89aea6ae6b', 'editor', 'en', 'https://i.pravatar.cc/150?img=33', '2025-02-02 23:39:39', '2026-01-08 02:45:01', NULL, 'active'),
(166, 'Becky Lee', 'brittanygarcia@jones.org', '8158e2dc1e2124534ae69865887c49f76285d59e9fdcce73e1404ee09d47f6f6', 'user', 'ta', 'https://i.pravatar.cc/150?img=30', '2020-10-09 11:39:08', '2026-01-13 21:02:14', NULL, 'active'),
(167, 'Laura Arnold', 'richard49@hotmail.com', '85447e9a1670a9daf87e5084863f4fc1acd0d80d23990eff6fc71b848d5a6459', 'editor', 'ta', 'https://i.pravatar.cc/150?img=63', '2020-06-11 11:58:37', '2026-01-16 11:51:33', NULL, 'active'),
(168, 'Annette Cruz', 'justin47@vaughn.com', 'c13143847f727d5c12ff38be694c30b94bb67b916ee79db3243a863a5190f8ba', 'user', 'ta', 'https://i.pravatar.cc/150?img=10', '2023-01-06 12:18:54', '2026-01-21 14:15:53', NULL, 'active'),
(169, 'Dr. James Lee', 'anthonysparks@thompson-davis.org', 'cd5e4a991ea20db191591a6bd00cc033295e7153147951a10e6e76bc410aa250', 'user', 'en', 'https://i.pravatar.cc/150?img=52', '2022-08-20 10:24:42', '2026-01-23 11:07:45', NULL, 'active'),
(170, 'Emily Mckinney', 'marysmith@bass-baker.biz', '270ef1514699cdd52a792363ec49f96ab217dbe90121fb90f643c59d0f34c3b5', 'user', 'mr', 'https://i.pravatar.cc/150?img=59', '2023-06-10 12:53:58', '2026-01-25 08:21:13', NULL, 'active'),
(171, 'Robert Rice', 'molly65@smith-rose.net', '15defe33e77f64efb0a76dbde02c52f12f356b588bd644bb89a7b056714b150d', 'editor', 'en', 'https://i.pravatar.cc/150?img=63', '2024-06-25 07:52:43', '2026-01-28 00:55:55', NULL, 'active'),
(172, 'Raymond Kelly', 'iglover@gmail.com', 'b1d4ce4db3de1ec008f126991c389c4bd04de673002f3c05d5c9414f2f492b41', 'user', 'hi', 'https://i.pravatar.cc/150?img=24', '2020-10-03 01:24:03', '2026-01-06 13:53:32', NULL, 'active'),
(173, 'Jordan Pearson', 'john39@yahoo.com', 'b3fc9ff76ac66132f2c3b89e6447d5bac8ce7294034afbde50361829d4371437', 'user', 'en', 'https://i.pravatar.cc/150?img=29', '2020-01-15 12:29:58', '2026-01-31 12:07:48', NULL, 'active'),
(174, 'Robert Reid', 'jacksondouglas@tyler.info', '3b70365fe42a234e073eeceb8abdef06c4264b1f4e2cc76e5374dd3f1b6e0b11', 'user', 'ta', 'https://i.pravatar.cc/150?img=47', '2021-10-05 19:09:24', '2026-01-25 04:10:03', NULL, 'active'),
(175, 'Cassidy Sanders', 'sarathomas@hotmail.com', '97dc77e8890e8b227d5667d2781a5d1dc38fc1b871edd442134d147e57513a76', 'editor', 'gu', 'https://i.pravatar.cc/150?img=42', '2021-09-07 19:10:38', '2026-01-05 12:56:19', NULL, 'active'),
(176, 'Alexander Guzman', 'rscott@bailey-ruiz.org', '60b8fab29c93b88fbaf2a4e7114795d0aa136dd7a1ebe5633e92d81e353afb3d', 'editor', 'ta', 'https://i.pravatar.cc/150?img=32', '2023-04-06 19:45:08', '2026-01-14 13:53:23', NULL, 'active'),
(177, 'Gary Hickman', 'tiffany01@hotmail.com', 'bb6b55b3841332e4016a262cf85045974603df6e444ca75224f3f07ea8890234', 'user', 'gu', 'https://i.pravatar.cc/150?img=58', '2025-12-07 13:26:30', '2026-01-06 06:36:49', NULL, 'active'),
(178, 'Lindsey Wilkins', 'dlong@hotmail.com', 'a2d374d3ffa10daf846d82cf5ba6a221b586000b51edc8fc16a37137743a2c37', 'user', 'hi', 'https://i.pravatar.cc/150?img=20', '2023-06-24 05:55:27', '2026-01-15 16:47:58', NULL, 'active'),
(179, 'Nicholas Jackson', 'marshalljose@murray.com', '184a3a4a121b66dcffc443c23fb89e8b1a43c6b804b29294fa2e4ee21d200140', 'user', 'en', 'https://i.pravatar.cc/150?img=69', '2024-08-21 04:45:50', '2026-01-27 05:17:49', NULL, 'active'),
(180, 'Derek Hughes', 'rhondasmith@berry.net', 'e1745aedbf1b272b2195e00d3c9ced68e66d82a659c2bed499064eb0985eb948', 'editor', 'en', 'https://i.pravatar.cc/150?img=65', '2021-09-03 03:33:05', '2026-01-06 20:41:34', NULL, 'active'),
(181, 'Isaiah Young', 'phall@phelps.info', 'd5f000b377a47925a60f167cc20ab821bda9d6954f8cd75802fb490933c211b0', 'user', 'hi', 'https://i.pravatar.cc/150?img=2', '2023-10-23 17:56:38', '2026-01-04 23:42:42', NULL, 'active'),
(182, 'Kristine Taylor', 'andrewherrera@johnson-oneill.net', 'aaf10945b287a71b940abf5c7b0a4a726c4c8c669f42d985d79f64b451a96f1d', 'user', 'en', 'https://i.pravatar.cc/150?img=15', '2023-12-24 23:09:06', '2026-01-25 04:00:59', NULL, 'active'),
(183, 'Zachary Cunningham', 'joshua72@douglas.com', '2ffcd6b75c39c2f890bc0097d16cec507e9fdb2e22522c27e1392584778a115b', 'user', 'en', 'https://i.pravatar.cc/150?img=48', '2023-04-18 06:29:01', '2026-01-12 16:59:04', NULL, 'active'),
(184, 'Paul Jensen', 'yprice@yahoo.com', 'bbf035f8a26fff8c2c0019865f8e876c8749b7729e2bb19a2bc96ca7149b17f6', 'user', 'ta', 'https://i.pravatar.cc/150?img=21', '2023-07-16 15:40:57', '2026-01-16 14:30:37', NULL, 'active'),
(185, 'Michael Cox', 'colleenwhite@gmail.com', '53b41c19cff5ecdfa364d7e4e9dde485b537e0daf2df9b557704f38fdb628347', 'user', 'en', 'https://i.pravatar.cc/150?img=32', '2022-05-12 02:02:59', '2026-01-08 19:03:09', NULL, 'active'),
(186, 'John Williams', 'mckinneytabitha@brewer.com', '0853f30f25d3e51ab927964f1d7bafe759f9728e1d3869381a3755a0284892c3', 'user', 'mr', 'https://i.pravatar.cc/150?img=61', '2024-06-23 08:22:12', '2026-01-01 06:02:16', NULL, 'active'),
(187, 'Lori Tyler', 'wilsongabriel@foster.com', '13328738fba34a5052091a3afbbec9ebf2be0a80b0b5e0c1b90cde2c0e68d953', 'user', 'en', 'https://i.pravatar.cc/150?img=57', '2021-10-12 23:24:23', '2026-01-19 21:58:51', NULL, 'active'),
(188, 'Michael Lopez', 'emmarodriguez@green.com', 'db6122659c8fe11ac27eb940bebaa4613088ad6e03b3379fa73caf3911816dd9', 'user', 'hi', 'https://i.pravatar.cc/150?img=6', '2024-07-10 03:40:48', '2026-01-03 03:12:09', NULL, 'active'),
(189, 'Taylor Kelley', 'michaelmartinez@brady.com', 'e28e54f807039d774732fd5ca4615604beef28c74737f5b450d638af258d9482', 'user', 'mr', 'https://i.pravatar.cc/150?img=6', '2022-11-03 09:56:02', '2026-01-17 15:39:50', NULL, 'active'),
(190, 'Harry Mcconnell', 'uknight@hotmail.com', '1342190f77cb7c5716ed6f1d9c3b893d062a736035c6f26afe5efef2e17cd1e9', 'editor', 'hi', 'https://i.pravatar.cc/150?img=22', '2022-10-10 15:00:19', '2026-02-03 15:11:47', NULL, 'active'),
(191, 'Lauren Jimenez', 'xpope@hotmail.com', 'd49f98a08a5707110e870675724c07678db51059cf553dccee31215b4a49e152', 'user', 'mr', 'https://i.pravatar.cc/150?img=43', '2024-08-10 02:24:43', '2026-01-23 15:08:16', NULL, 'active'),
(192, 'Jay Pham', 'robinsontabitha@austin.info', '01f93130e51698c6f421b822634f9a861e786c4c77d31500ff22f37e6ea37ee9', 'user', 'en', 'https://i.pravatar.cc/150?img=5', '2022-06-30 12:12:18', '2026-02-03 21:51:54', NULL, 'active'),
(193, 'Amber Rowe', 'tgreen@lam.com', 'cb2ea9ae3360d658bfd35a341ac2f9a3243b032babb4154b2ecaa34caf215378', 'user', 'en', 'https://i.pravatar.cc/150?img=30', '2021-03-09 01:47:50', '2026-01-18 05:06:34', NULL, 'active'),
(194, 'Troy Mclaughlin', 'kennethsmith@hotmail.com', '015055463e7c7bbc967392d919fd417eb372fdcd7638045b6a7cfa6e7b1b7b15', 'user', 'en', 'https://i.pravatar.cc/150?img=37', '2023-03-02 19:53:32', '2026-02-03 22:18:51', NULL, 'active'),
(195, 'Monica Hughes', 'twilliams@norman-key.net', '53a1566b71955dfea1775ac0088b310c22d3806fa3f6e7818103361efec9c7c0', 'user', 'mr', 'https://i.pravatar.cc/150?img=46', '2024-09-16 12:38:45', '2026-01-08 03:21:59', NULL, 'active'),
(196, 'Mr. Craig Barnes', 'kylelewis@yahoo.com', 'db375040f2345c1a65727a6d36d23e2992d91e6f77fd70bb7bdd2d07f10ac14f', 'editor', 'gu', 'https://i.pravatar.cc/150?img=49', '2023-10-11 14:00:05', '2026-01-16 22:40:36', NULL, 'active'),
(197, 'Jesus Gonzalez', 'alyssanguyen@duke.com', '7ab9680159c372001fb78ab2c51973fd58ef6dded167d545b5f75f68b4c05f03', 'editor', 'gu', 'https://i.pravatar.cc/150?img=61', '2020-11-12 04:31:46', '2026-01-16 11:43:16', NULL, 'active'),
(198, 'Susan Jordan', 'ronaldwoods@flores-cowan.com', 'e667522880747830d7cd24513a168ecf76efd3342e4ca07dc768878fbe6cc6d0', 'editor', 'mr', 'https://i.pravatar.cc/150?img=32', '2025-11-07 18:00:03', '2026-01-15 14:52:39', NULL, 'active'),
(199, 'Marie Long', 'rhodesjimmy@hotmail.com', '1886c0a885f05f6e75e5f9c87570158dfa2fae4eae3690b0893ee36d81451a4a', 'editor', 'ta', 'https://i.pravatar.cc/150?img=46', '2021-12-29 09:21:34', '2026-01-17 23:36:16', NULL, 'active'),
(200, 'Sarah Contreras', 'hendersondavid@pearson.com', '3a18995640d46ba22684e26fe4222d49a9c0f9f75b580c56d4ffd1eed6d2a1bb', 'editor', 'ta', 'https://i.pravatar.cc/150?img=61', '2023-06-09 08:34:34', '2026-01-14 14:30:13', NULL, 'active'),
(203, 'Pooja', 'pooja@gmail.com', '$2y$12$o9h9EFiMgape9Jxhk1f/K.ti92.b4Wd0PRjvjc2fIGsLfcEr3Ndo2', 'editor', 'english , hindi', '1772448496_Screenshot 2025-12-29 113020.png', '2026-02-23 06:25:28', '2026-03-02 04:59:40', 'IIgKPtuVjR6K3V0ZMyJVyREvNOpQumADsODfdtEDUa96NJGkyIc4FJfaMJ1k', 'active'),
(204, 'admin12', 'admin12@gmail.com', '$2y$12$xxylnfzI/wk2k9QQw4rkeOXE9QgehG89wLRAMmUhB3We2TYzGudgW', 'admin', 'en', '1772447342_69a5666ef423c.png', '2026-02-24 06:46:10', '2026-03-02 05:24:27', NULL, 'active'),
(205, 'kruti', 'krutipankajkumar@gmail.com', '$2y$12$3GBang2Om5Ht27.c3QDifewp/BnuF8nu.CubpqwJAtCCjZQetwJ6m', 'user', 'en', 'avatars/1772443538_69a557929f3c3.png', '2026-02-28 06:10:48', '2026-03-02 04:18:05', NULL, 'active');

-- --------------------------------------------------------

--
-- Table structure for table `user_interests`
--

CREATE TABLE `user_interests` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `subcategory_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_interests`
--

INSERT INTO `user_interests` (`id`, `user_id`, `category_id`, `subcategory_id`, `created_at`) VALUES
(1, 2, 1, 1, '2026-02-04 09:41:43'),
(2, 2, 2, 19, '2026-02-04 09:41:43'),
(3, 2, 3, 36, '2026-02-04 09:41:43'),
(4, 4, 1, 2, '2026-02-04 09:41:43'),
(5, 4, 2, 20, '2026-02-04 09:41:43'),
(6, 4, 3, 37, '2026-02-04 09:41:43'),
(7, 12, 1, 3, '2026-02-04 09:41:43'),
(8, 12, 2, 21, '2026-02-04 09:41:43'),
(9, 12, 3, 38, '2026-02-04 09:41:43'),
(10, 14, 1, 4, '2026-02-04 09:41:43'),
(12, 14, 3, 39, '2026-02-04 09:41:43'),
(13, 15, 1, 5, '2026-02-04 09:41:43'),
(14, 15, 2, 23, '2026-02-04 09:41:43'),
(15, 15, 3, 40, '2026-02-04 09:41:43'),
(16, 16, 1, 6, '2026-02-04 09:41:43'),
(17, 16, 2, 24, '2026-02-04 09:41:43'),
(18, 16, 3, 41, '2026-02-04 09:41:43'),
(19, 17, 1, 7, '2026-02-04 09:41:43'),
(21, 19, 1, 8, '2026-02-04 09:41:43'),
(23, 22, 1, 9, '2026-02-04 09:41:43'),
(24, 22, 2, 27, '2026-02-04 09:41:43'),
(25, 23, 1, 10, '2026-02-04 09:41:43'),
(27, 25, 1, 11, '2026-02-04 09:41:43'),
(29, 30, 1, 12, '2026-02-04 09:41:43'),
(31, 34, 1, 13, '2026-02-04 09:41:43'),
(32, 34, 2, 31, '2026-02-04 09:41:43'),
(33, 36, 1, 14, '2026-02-04 09:41:43'),
(34, 36, 2, 32, '2026-02-04 09:41:43'),
(35, 37, 1, 15, '2026-02-04 09:41:43'),
(36, 37, 2, 33, '2026-02-04 09:41:43'),
(37, 41, 1, 16, '2026-02-04 09:41:43'),
(38, 41, 2, 34, '2026-02-04 09:41:43'),
(40, 42, 2, 35, '2026-02-04 09:41:43'),
(42, 45, 2, 19, '2026-02-04 09:41:43'),
(43, 47, 1, 1, '2026-02-04 09:41:43'),
(44, 47, 2, 20, '2026-02-04 09:41:43'),
(45, 49, 1, 2, '2026-02-04 09:41:43'),
(46, 49, 2, 21, '2026-02-04 09:41:43'),
(47, 50, 1, 3, '2026-02-04 09:41:43'),
(49, 52, 1, 4, '2026-02-04 09:41:43'),
(50, 52, 2, 23, '2026-02-04 09:41:43'),
(51, 2, 4, 19, '2026-02-04 09:41:43'),
(52, 2, 5, 20, '2026-02-04 09:41:43'),
(53, 2, 1, 1, '2026-02-04 09:41:43'),
(54, 4, 4, 21, '2026-02-04 09:41:43'),
(56, 4, 1, 2, '2026-02-04 09:41:43'),
(57, 12, 4, 23, '2026-02-04 09:41:43'),
(58, 12, 5, 24, '2026-02-04 09:41:43'),
(59, 12, 1, 3, '2026-02-04 09:41:43'),
(62, 14, 1, 4, '2026-02-04 09:41:43'),
(63, 15, 4, 27, '2026-02-04 09:41:43'),
(65, 15, 1, 5, '2026-02-04 09:41:43'),
(68, 16, 1, 6, '2026-02-04 09:41:43'),
(69, 17, 4, 31, '2026-02-04 09:41:43'),
(70, 17, 5, 32, '2026-02-04 09:41:43'),
(71, 19, 4, 33, '2026-02-04 09:41:43'),
(72, 19, 5, 34, '2026-02-04 09:41:43'),
(73, 22, 4, 35, '2026-02-04 09:41:43'),
(74, 22, 5, 19, '2026-02-04 09:41:43'),
(75, 23, 4, 20, '2026-02-04 09:41:43'),
(76, 23, 5, 21, '2026-02-04 09:41:43'),
(78, 25, 5, 23, '2026-02-04 09:41:43'),
(79, 30, 4, 24, '2026-02-04 09:41:43'),
(82, 34, 5, 27, '2026-02-04 09:41:43'),
(86, 37, 5, 31, '2026-02-04 09:41:43'),
(87, 41, 4, 32, '2026-02-04 09:41:43'),
(88, 41, 5, 33, '2026-02-04 09:41:43'),
(89, 42, 4, 34, '2026-02-04 09:41:43'),
(90, 42, 5, 35, '2026-02-04 09:41:43'),
(91, 45, 4, 19, '2026-02-04 09:41:43'),
(92, 45, 5, 20, '2026-02-04 09:41:43'),
(93, 47, 4, 21, '2026-02-04 09:41:43'),
(95, 49, 4, 23, '2026-02-04 09:41:43'),
(96, 49, 5, 24, '2026-02-04 09:41:43'),
(99, 52, 4, 27, '2026-02-04 09:41:43'),
(101, 2, 1, 1, '2026-02-04 09:41:43'),
(103, 2, 3, 39, '2026-02-04 09:41:43'),
(104, 4, 1, 4, '2026-02-04 09:41:43'),
(106, 4, 3, 41, '2026-02-04 09:41:43'),
(107, 12, 1, 7, '2026-02-04 09:41:43'),
(109, 12, 3, 36, '2026-02-04 09:41:43'),
(110, 14, 1, 10, '2026-02-04 09:41:43'),
(111, 14, 2, 31, '2026-02-04 09:41:43'),
(112, 14, 3, 37, '2026-02-04 09:41:43'),
(113, 15, 1, 13, '2026-02-04 09:41:43'),
(114, 15, 2, 34, '2026-02-04 09:41:43'),
(115, 15, 3, 38, '2026-02-04 09:41:43'),
(116, 16, 1, 16, '2026-02-04 09:41:43'),
(117, 16, 2, 19, '2026-02-04 09:41:43'),
(118, 16, 3, 39, '2026-02-04 09:41:43'),
(119, 17, 1, 1, '2026-02-04 09:41:43'),
(120, 17, 2, 20, '2026-02-04 09:41:43'),
(121, 19, 1, 2, '2026-02-04 09:41:43'),
(122, 19, 2, 21, '2026-02-04 09:41:43'),
(123, 22, 1, 3, '2026-02-04 09:41:43'),
(125, 23, 1, 4, '2026-02-04 09:41:43'),
(126, 23, 2, 23, '2026-02-04 09:41:43'),
(127, 25, 1, 5, '2026-02-04 09:41:43'),
(128, 25, 2, 24, '2026-02-04 09:41:43'),
(129, 30, 1, 6, '2026-02-04 09:41:43'),
(131, 34, 1, 7, '2026-02-04 09:41:43'),
(133, 36, 1, 8, '2026-02-04 09:41:43'),
(134, 36, 2, 27, '2026-02-04 09:41:43'),
(135, 37, 1, 9, '2026-02-04 09:41:43'),
(137, 41, 1, 10, '2026-02-04 09:41:43'),
(139, 42, 1, 11, '2026-02-04 09:41:43'),
(141, 45, 1, 12, '2026-02-04 09:41:43'),
(142, 45, 2, 31, '2026-02-04 09:41:43'),
(143, 47, 1, 13, '2026-02-04 09:41:43'),
(144, 47, 2, 32, '2026-02-04 09:41:43'),
(145, 49, 1, 14, '2026-02-04 09:41:43'),
(146, 49, 2, 33, '2026-02-04 09:41:43'),
(147, 50, 1, 15, '2026-02-04 09:41:43'),
(148, 50, 2, 34, '2026-02-04 09:41:43'),
(149, 52, 1, 16, '2026-02-04 09:41:43'),
(150, 52, 2, 35, '2026-02-04 09:41:43'),
(151, 2, 3, 41, '2026-02-04 09:41:43'),
(152, 2, 4, 20, '2026-02-04 09:41:43'),
(154, 4, 3, 36, '2026-02-04 09:41:43'),
(155, 4, 4, 23, '2026-02-04 09:41:43'),
(157, 12, 3, 37, '2026-02-04 09:41:43'),
(160, 14, 3, 38, '2026-02-04 09:41:43'),
(162, 14, 5, 31, '2026-02-04 09:41:43'),
(163, 15, 3, 39, '2026-02-04 09:41:43'),
(164, 15, 4, 32, '2026-02-04 09:41:43'),
(165, 15, 5, 34, '2026-02-04 09:41:43'),
(166, 16, 3, 40, '2026-02-04 09:41:43'),
(167, 16, 4, 35, '2026-02-04 09:41:43'),
(168, 16, 5, 19, '2026-02-04 09:41:43'),
(169, 17, 3, 41, '2026-02-04 09:41:43'),
(170, 17, 4, 21, '2026-02-04 09:41:43'),
(171, 19, 3, 36, '2026-02-04 09:41:43'),
(173, 22, 3, 37, '2026-02-04 09:41:43'),
(174, 22, 4, 23, '2026-02-04 09:41:43'),
(175, 23, 3, 38, '2026-02-04 09:41:43'),
(176, 23, 4, 24, '2026-02-04 09:41:43'),
(177, 25, 3, 39, '2026-02-04 09:41:43'),
(179, 30, 3, 40, '2026-02-04 09:41:43'),
(181, 34, 3, 41, '2026-02-04 09:41:43'),
(182, 34, 4, 27, '2026-02-04 09:41:43'),
(183, 36, 3, 36, '2026-02-04 09:41:43'),
(185, 37, 3, 37, '2026-02-04 09:41:43'),
(187, 41, 3, 38, '2026-02-04 09:41:43'),
(189, 42, 3, 39, '2026-02-04 09:41:43'),
(190, 42, 4, 31, '2026-02-04 09:41:43'),
(191, 45, 3, 40, '2026-02-04 09:41:43'),
(192, 45, 4, 32, '2026-02-04 09:41:43'),
(193, 47, 3, 41, '2026-02-04 09:41:43'),
(194, 47, 4, 33, '2026-02-04 09:41:43'),
(195, 49, 3, 36, '2026-02-04 09:41:43'),
(196, 49, 4, 34, '2026-02-04 09:41:43'),
(197, 50, 3, 37, '2026-02-04 09:41:43'),
(198, 50, 4, 35, '2026-02-04 09:41:43'),
(199, 52, 3, 38, '2026-02-04 09:41:43'),
(200, 52, 4, 19, '2026-02-04 09:41:43'),
(201, 205, 1, 1, '2026-03-02 07:04:38'),
(202, 205, 1, 2, '2026-03-02 07:04:38'),
(203, 205, 2, 19, '2026-03-02 07:04:38'),
(204, 205, 2, 20, '2026-03-02 07:04:38'),
(205, 205, 2, 32, '2026-03-02 07:04:38');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_activity_user` (`user_id`);

--
-- Indexes for table `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_articles_category` (`category_id`),
  ADD KEY `fk_articles_subcategory` (`subcategory_id`),
  ADD KEY `fk_articles_author` (`author_id`);

--
-- Indexes for table `article_media`
--
ALTER TABLE `article_media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_article_media_article` (`article_id`);

--
-- Indexes for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_article` (`user_id`,`article_id`),
  ADD KEY `fk_bookmarks_article` (`article_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_comments_article` (`article_id`),
  ADD KEY `fk_comments_user` (`user_id`),
  ADD KEY `fk_comments_parent` (`parent_id`);

--
-- Indexes for table `indices`
--
ALTER TABLE `indices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stocks`
--
ALTER TABLE `stocks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_watchlist`
--
ALTER TABLE `stock_watchlist`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_interests`
--
ALTER TABLE `user_interests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `subcategory_id` (`subcategory_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `articles`
--
ALTER TABLE `articles`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=206;

--
-- AUTO_INCREMENT for table `article_media`
--
ALTER TABLE `article_media`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=210;

--
-- AUTO_INCREMENT for table `bookmarks`
--
ALTER TABLE `bookmarks`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=208;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=204;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=206;

--
-- AUTO_INCREMENT for table `indices`
--
ALTER TABLE `indices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stocks`
--
ALTER TABLE `stocks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `stock_watchlist`
--
ALTER TABLE `stock_watchlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `subcategories`
--
ALTER TABLE `subcategories`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=204;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=206;

--
-- AUTO_INCREMENT for table `user_interests`
--
ALTER TABLE `user_interests`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=206;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `fk_activity_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `articles`
--
ALTER TABLE `articles`
  ADD CONSTRAINT `fk_articles_author` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_articles_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `fk_articles_subcategory` FOREIGN KEY (`subcategory_id`) REFERENCES `subcategories` (`id`);

--
-- Constraints for table `article_media`
--
ALTER TABLE `article_media`
  ADD CONSTRAINT `fk_article_media_article` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD CONSTRAINT `fk_bookmarks_article` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_bookmarks_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_comments_article` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_comments_parent` FOREIGN KEY (`parent_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_comments_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD CONSTRAINT `subcategories_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `user_interests`
--
ALTER TABLE `user_interests`
  ADD CONSTRAINT `user_interests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_interests_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_interests_ibfk_3` FOREIGN KEY (`subcategory_id`) REFERENCES `subcategories` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
