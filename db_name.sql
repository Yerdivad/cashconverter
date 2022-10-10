-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-10-2022 a las 20:10:20
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.0.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_name`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `attributes`
--

CREATE TABLE `attributes` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_priority` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL,
  `input_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `attributes`
--

INSERT INTO `attributes` (`id`, `name`, `description`, `order_priority`, `required`, `input_type`) VALUES
(1, 'Marca', 'Identificación comercial que usa el fabricante para vender sus productos', 100, 1, 'select'),
(2, 'Modelo', 'Nombre comercial para el producto.', 90, 1, 'select'),
(3, 'Título', 'Nombre del producto', 90, 1, 'text'),
(4, 'Plataforma', 'Nombre de la plataforma en la cual se ejecuta el producto', 80, 1, 'radius'),
(5, 'EAN', 'Código identificador de la obra', 70, 0, 'text'),
(6, 'IMEI', 'Código identificador del terminal', 70, 0, 'text');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `attributes_category`
--

CREATE TABLE `attributes_category` (
  `attributes_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `attributes_category`
--

INSERT INTO `attributes_category` (`attributes_id`, `category_id`) VALUES
(1, 3),
(1, 4),
(2, 3),
(2, 4),
(3, 1),
(4, 1),
(5, 1),
(6, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `attribute_value`
--

CREATE TABLE `attribute_value` (
  `id` int(11) NOT NULL,
  `attribute_id_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dependents_values` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '(DC2Type:json)',
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `attribute_value`
--

INSERT INTO `attribute_value` (`id`, `attribute_id_id`, `name`, `dependents_values`, `category_id`) VALUES
(1, 1, 'Apple', NULL, 4),
(2, 1, 'Samsung', NULL, 4),
(3, 1, 'Sony', NULL, 3),
(4, 2, 'PlayStation 5', '3', 3),
(5, 2, 'PlayStation 4', '3', 3),
(6, 2, 'PlayStation 3', '3', 3),
(7, 1, 'Nintendo', NULL, 3),
(8, 2, 'Switch 2020', '7', 3),
(9, 2, 'Switch 2022 OLED', '7', 3),
(10, 2, 'Galaxy 11', '2', 4),
(11, 2, 'Galaxy Edge', '2', 4),
(12, 2, 'Galaxy X Plus', '2', 4),
(13, 2, 'iPhone 14', '1', 4),
(14, 2, 'iPhone 13', '1', 4),
(15, 2, 'iPhone 13 Plus', '1', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `category`
--

INSERT INTO `category` (`id`, `name`) VALUES
(1, 'Videojuegos'),
(3, 'Consolas'),
(4, 'Smartphones');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20221009094450', '2022-10-09 11:45:20', 68),
('DoctrineMigrations\\Version20221009101233', '2022-10-09 12:12:41', 178),
('DoctrineMigrations\\Version20221009102459', '2022-10-09 12:25:08', 90),
('DoctrineMigrations\\Version20221009162303', '2022-10-09 18:23:10', 110);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `attributes`
--
ALTER TABLE `attributes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `attributes_category`
--
ALTER TABLE `attributes_category`
  ADD PRIMARY KEY (`attributes_id`,`category_id`),
  ADD KEY `IDX_C0CCCF79BAAF4009` (`attributes_id`),
  ADD KEY `IDX_C0CCCF7912469DE2` (`category_id`);

--
-- Indices de la tabla `attribute_value`
--
ALTER TABLE `attribute_value`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_FE4FBB829C7C7DE1` (`attribute_id_id`),
  ADD KEY `IDX_FE4FBB8212469DE2` (`category_id`);

--
-- Indices de la tabla `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indices de la tabla `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `attributes`
--
ALTER TABLE `attributes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `attribute_value`
--
ALTER TABLE `attribute_value`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `attributes_category`
--
ALTER TABLE `attributes_category`
  ADD CONSTRAINT `FK_C0CCCF7912469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_C0CCCF79BAAF4009` FOREIGN KEY (`attributes_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `attribute_value`
--
ALTER TABLE `attribute_value`
  ADD CONSTRAINT `FK_FE4FBB8212469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `FK_FE4FBB829C7C7DE1` FOREIGN KEY (`attribute_id_id`) REFERENCES `attributes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
