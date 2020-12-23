-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 23-12-2020 a las 02:08:35
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `delila_resto`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resto_method_paid_order`
--

CREATE TABLE `resto_method_paid_order` (
  `id_cash` int(11) NOT NULL,
  `type_cash` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `resto_method_paid_order`
--

INSERT INTO `resto_method_paid_order` (`id_cash`, `type_cash`) VALUES
(1, 'Cash'),
(2, 'Credit Card');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resto_orders`
--

CREATE TABLE `resto_orders` (
  `id_order` int(11) NOT NULL,
  `date_order` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `q_product` int(11) NOT NULL DEFAULT 1,
  `total_order` int(11) NOT NULL,
  `status_order` int(11) NOT NULL DEFAULT 1,
  `method_paid_order` int(11) NOT NULL,
  `id_product` int(11) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `resto_orders`
--

INSERT INTO `resto_orders` (`id_order`, `date_order`, `q_product`, `total_order`, `status_order`, `method_paid_order`, `id_product`, `id_user`) VALUES
(1, '2020-12-20 05:55:05', 1, 1200, 1, 1, 1, 2),
(4, '2020-12-22 23:23:46', 1, 5, 4, 1, 1, 3),
(6, '2020-12-20 21:44:14', 4, 10000, 3, 1, 1, 1),
(7, '2020-12-22 23:31:58', 1, 5, 4, 1, 1, 3),
(8, '2020-12-20 21:44:14', 3, 1500, 3, 2, 3, 2),
(9, '2020-12-20 21:44:14', 3, 1500, 3, 2, 3, 8),
(11, '2020-12-22 22:27:49', 3, 2691, 1, 1, 2, 12),
(12, '2020-12-20 21:44:14', 2, 1794, 2, 2, 6, 12),
(14, '2020-12-22 22:50:58', 3, 2691, 1, 1, 2, 12),
(16, '2020-12-22 22:40:16', 3, 2691, 1, 1, 2, 12),
(17, '2020-12-20 21:46:44', 8, 7176, 1, 1, 2, 12),
(18, '2020-12-20 21:48:30', 8, 7176, 1, 2, 6, 12),
(19, '2020-12-22 22:57:18', 3, 2691, 1, 1, 2, 12),
(20, '2020-12-22 22:31:54', 3, 2691, 1, 1, 2, 12),
(21, '2020-12-21 00:21:14', 90, 80730, 1, 2, 2, 12),
(22, '2020-12-21 00:35:06', 1, 897, 1, 2, 6, 4),
(23, '2020-12-22 22:21:53', 3, 2691, 1, 1, 2, 12),
(26, '2020-12-21 06:31:31', 1, 5, 4, 1, 1, 3),
(27, '2020-12-22 20:04:39', 5, 50, 1, 2, 5, 1),
(28, '2020-12-22 23:23:25', 1, 5, 4, 1, 1, 3),
(29, '2020-12-22 20:32:49', 6, 5382, 1, 1, 2, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resto_products`
--

CREATE TABLE `resto_products` (
  `id_product` int(11) NOT NULL,
  `name_product` varchar(200) NOT NULL,
  `description_product` varchar(240) NOT NULL,
  `price_product` int(11) NOT NULL,
  `available_q_product` int(11) NOT NULL,
  `date_created_product` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `resto_products`
--

INSERT INTO `resto_products` (`id_product`, `name_product`, `description_product`, `price_product`, `available_q_product`, `date_created_product`) VALUES
(1, 'Bagel del Salmón', 'Ensalada de lechuga, zanahoria y salmón servidos a 10 grados de temperatura con aderezo sabor a limón.', 425, 10, '2020-12-19 18:51:03'),
(2, 'Hamburguesa clásica mediana', 'Hamburguesa mediana con una porción de carne de res, lechuga fresca, queso doble crema tajado por dos porciones, tomate, un huevo frito, cebolla cocinada y salsas al gusto.', 897, 100, '2020-12-19 20:45:32'),
(3, 'Sandwich veggie', 'Auténtico sandwich vegetariano con la receta origianl delilah que contiene tomate, cebolla, pepino, huevo cocido, vinagre, apio, lechuga, aguacate y zanahoria rayada, bañado en limón.', 320, 120, '2020-12-19 19:11:30'),
(5, 'Sandwich de carne', 'Auténtico sandwich de tres carnes, pollo, res y cerdo incluyendo un huevo cocido, con tomate, cebolla y lechuga.', 479, 100, '2020-12-20 07:12:29'),
(6, 'Hamburguesa clásica mediana y a medias', 'Hamburguesa mediana con una porción de carne de res, lechuga fresca, queso doble crema tajado por dos porciones, tomate, un huevo frito, cebolla cocinada y salsas al gusto.', 897, 100, '2020-12-20 07:13:30'),
(8, 'Arroz con pollo', 'Arroz combinado con pollo cocinado desmechado, habichuelas, arbejas, zanahoria y huevo de codornis', 320, 10, '2020-12-21 06:15:55'),
(11, 'Aguja, punta de anca', 'Hamburguesa mediana con una porción de carne de res, lechuga fresca, queso doble crema tajado por dos porciones, tomate, un huevo frito, cebolla cocinada y salsas al gusto.', 320, 100, '2020-12-23 00:00:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resto_rol_id`
--

CREATE TABLE `resto_rol_id` (
  `id` int(11) NOT NULL,
  `rol` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `resto_rol_id`
--

INSERT INTO `resto_rol_id` (`id`, `rol`) VALUES
(1, 'Administrator'),
(2, 'Costumer'),
(3, 'Waiter');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resto_status_order`
--

CREATE TABLE `resto_status_order` (
  `id_status` int(11) NOT NULL,
  `name_status` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `resto_status_order`
--

INSERT INTO `resto_status_order` (`id_status`, `name_status`) VALUES
(1, 'Confirmed'),
(2, 'Preparation'),
(3, 'Comming'),
(4, 'Delivered');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resto_users`
--

CREATE TABLE `resto_users` (
  `id_user` int(11) NOT NULL,
  `name_user` varchar(100) NOT NULL,
  `email_user` varchar(50) NOT NULL,
  `phone_user` bigint(20) NOT NULL,
  `adress_user` varchar(120) NOT NULL,
  `pass_user` varchar(100) NOT NULL,
  `date_register` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `rol_id` int(100) NOT NULL DEFAULT 2
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `resto_users`
--

INSERT INTO `resto_users` (`id_user`, `name_user`, `email_user`, `phone_user`, `adress_user`, `pass_user`, `date_register`, `rol_id`) VALUES
(1, 'Alejandro Magno', 'alejandro.palacios88@gmail.com', 3164738344, 'Cra 14 este Soacha', '$2b$10$z.XZcLWu2sS9Q10wXFi.NuAz8b/EmGte9t8ZV19vee2FmyWL115K6', '2020-12-20 18:41:48', 2),
(2, 'Alejandro Magno', 'alejandro.palacios88@gmail.com', 3164738344, 'Cra 14 este Soacha', '$2b$10$W3yGy44AHkup9UzIga3hne1A2QO0J5Po/ZLKVoyvW2y8BmSujycbi', '2020-12-22 23:41:34', 1),
(3, 'Diana Luna Poveda', 'diana@gmail.com', 3203681911, 'Cra 14 este # 32b - 09', '$2b$10$z.XZcLWu2sS9Q10wXFi.NuAz8b/EmGte9t8ZV19vee2FmyWL115K6', '2020-12-21 02:12:49', 2),
(4, 'Kevin Alejandro Palacios Luna', 'kevin@gmail.com', 3178542311, 'Cra 7 # 32-09', '$2b$10$z.XZcLWu2sS9Q10wXFi.NuAz8b/EmGte9t8ZV19vee2FmyWL115K6', '2020-12-21 01:57:33', 1),
(8, 'Edgar Vivar como el señor Barriga', 'senorbarriga@chespirito.com', 3178542311, 'Mexico colonia 12', '$2b$10$CmtBUif5TzD9byqtjFQlmeXQoKxtXgc9GPqwplo2uipl7x8jpX.eG', '2020-12-21 06:25:31', 1),
(12, 'Pruebas', 'pruebas@gmail.com', 3178542311, 'Cra 7 # 32-09', '$2b$10$lQYdYZo8Ya0EtrUp0BUIZeTkZFPTIlNzMrVN1h6TnJOTbMIlylAhq', '2020-12-20 16:55:35', 2),
(30, 'Alejandro Magno', 'alejandro.palacios88@gmail.com', 3164738344, 'Cra 14 este Soacha', '$2b$10$7P9Ue9tbodyowXFOpHNxIeNWdTr.lqJRZB6aL/WwTTmpj4AbD.jwe', '2020-12-22 20:51:14', 2),
(31, 'testadmin', 'testadmin2@gmail.com', 32112345678, 'Call 3 # 12 - 09', '$2b$10$1QxKdiQSRutXateqnWAxquf/1TArmr40pE.Mk0LmWMR1WbBMhLr7W', '2020-12-22 04:18:18', 2),
(32, 'testadmin', 'testadmin3@gmail.com', 32112345678, 'Call 3 # 12 - 09', '$2b$10$Q87RG50LdM8xgJEs6eddcOGzqO8epG/rhVibPL7/DjYYxJ/Y4727O', '2020-12-22 04:19:37', 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `resto_method_paid_order`
--
ALTER TABLE `resto_method_paid_order`
  ADD PRIMARY KEY (`id_cash`);

--
-- Indices de la tabla `resto_orders`
--
ALTER TABLE `resto_orders`
  ADD PRIMARY KEY (`id_order`),
  ADD KEY `status_order` (`status_order`),
  ADD KEY `method_paid_order` (`method_paid_order`),
  ADD KEY `id_product` (`id_product`),
  ADD KEY `id_user` (`id_user`);

--
-- Indices de la tabla `resto_products`
--
ALTER TABLE `resto_products`
  ADD PRIMARY KEY (`id_product`);

--
-- Indices de la tabla `resto_rol_id`
--
ALTER TABLE `resto_rol_id`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `resto_status_order`
--
ALTER TABLE `resto_status_order`
  ADD PRIMARY KEY (`id_status`);

--
-- Indices de la tabla `resto_users`
--
ALTER TABLE `resto_users`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `fk_rol_id` (`rol_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `resto_method_paid_order`
--
ALTER TABLE `resto_method_paid_order`
  MODIFY `id_cash` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `resto_orders`
--
ALTER TABLE `resto_orders`
  MODIFY `id_order` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `resto_products`
--
ALTER TABLE `resto_products`
  MODIFY `id_product` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `resto_rol_id`
--
ALTER TABLE `resto_rol_id`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `resto_status_order`
--
ALTER TABLE `resto_status_order`
  MODIFY `id_status` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `resto_users`
--
ALTER TABLE `resto_users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `resto_orders`
--
ALTER TABLE `resto_orders`
  ADD CONSTRAINT `resto_orders_ibfk_1` FOREIGN KEY (`status_order`) REFERENCES `resto_status_order` (`id_status`),
  ADD CONSTRAINT `resto_orders_ibfk_2` FOREIGN KEY (`method_paid_order`) REFERENCES `resto_method_paid_order` (`id_cash`),
  ADD CONSTRAINT `resto_orders_ibfk_3` FOREIGN KEY (`id_product`) REFERENCES `resto_products` (`id_product`),
  ADD CONSTRAINT `resto_orders_ibfk_4` FOREIGN KEY (`id_user`) REFERENCES `resto_users` (`id_user`);

--
-- Filtros para la tabla `resto_users`
--
ALTER TABLE `resto_users`
  ADD CONSTRAINT `fk_rol_id` FOREIGN KEY (`rol_id`) REFERENCES `resto_rol_id` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
