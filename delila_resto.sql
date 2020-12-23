-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 23-12-2020 a las 19:58:51
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
(2, '2020-12-23 18:57:24', 10, 8970, 1, 1, 15, 35),
(3, '2020-12-23 18:58:10', 5, 1600, 1, 2, 17, 35);

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
(14, 'Bagel del Salmón', 'Ensalada de lechuga, zanahoria y salmón servidos a 10 grados de temperatura con aderezo sabor a limón.', 320, 10, '2020-12-23 18:54:17'),
(15, 'Hamburguesa clásica mediana', 'Hamburguesa mediana con una porción de carne de res, lechuga fresca, queso doble crema tajado por dos porciones, tomate, un huevo frito, cebolla cocinada y salsas al gusto.', 897, 100, '2020-12-23 18:54:55'),
(16, 'Sandwich veggie', 'Auténtico sandwich vegetariano con la receta origianl delilah que contiene tomate, cebolla, pepino, huevo cocido, vinagre, apio, lechuga, aguacate y zanahoria rayada, baÒado en limón.', 100, 120, '2020-12-23 18:55:34'),
(17, 'Arroz con pollo', 'Arroz combinado con pollo cocinado desmechado, habichuelas, arbejas, zanahoria y huevo de codornis', 320, 80, '2020-12-23 18:56:09');

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
(2, 'Costumer');

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
(34, 'testadmin', 'testadmin@gmail.com', 32112345678, 'Call 3 # 12 - 09', '$2b$10$S7luvbD/Zje6f.jlah58gODxJm5utUfP.1tiuGAeG9W2bTKURZRaS', '2020-12-23 18:28:01', 1),
(35, 'testcostumer', 'testcostumer@gmail.com', 32112345678, 'Call 3 # 12 - 09', '$2b$10$dIJNNFProZDpSNjzLhjPP.3UVXdszXg5/wqbHeFn06evsd/ZLSkWe', '2020-12-23 18:27:50', 2);

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
  MODIFY `id_order` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `resto_products`
--
ALTER TABLE `resto_products`
  MODIFY `id_product` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

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
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

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
