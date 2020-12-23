INSERT INTO resto_users
VALUES(null, "Alejandro Palacios", "pacho.ale@hotmail.com", "3164738344", "Calle falsa 123", "estefany05", null, 2)

INSERT INTO resto_orders
VALUES(null, 985, null, 2, 2, 1, 1);

INSERT INTO products
VALUES(null, "Bagel del Salmón", "Ensalada de lechuga, zanahoria y salmón servidos a 10 grados de temperatura con aderezo sabor a limón.", 425, 10);


CREATE TABLE resto_orders(
	id_order INT PRIMARY KEY AUTO_INCREMENT,
    total_order INT NOT NULL,
    date_order TIMESTAMP NOT NULL,
    status_order INT NOT NULL,
    method_paid_order INT NOT NULL,
    id_product INT NOT NULL,
    id_user INT NOT NULL,
    FOREIGN KEY
(status_order) REFERENCES resto_status_order
(id_status),
    FOREIGN KEY
(method_paid_order) REFERENCES resto_method_paid_order
(id_cash),
    FOREIGN KEY
(id_product) REFERENCES resto_products
(id_product),
    FOREIGN KEY
(id_user) REFERENCES resto_users
(id_user)
);

type_cash, name_product, description_product, price_product, rol

, resto_orders.method_paid_order = resto_method_paid_order.type_cash, resto_orders.id_product = resto_products.id_product, resto_orders.id_user = resto_users.id_user

SELECT id_order, date_order, name_status, type_cash, total_order, name_product, description_product, price_product, name_user, email_user, phone_user, adress_user
FROM resto_orders
    INNER JOIN resto_status_order ON resto_orders.status_order = resto_status_order.id_status
    INNER JOIN resto_method_paid_order ON resto_orders.method_paid_order = resto_method_paid_order.id_cash
    INNER JOIN resto_products ON resto_orders.id_product = resto_products.id_product
    INNER JOIN resto_users ON resto_orders.id_user = resto_users.id_user
ORDER BY id_order ASC


SELECT id_order, date_order, q_product, total_order, name_status, type_cash, name_product, description_product
FROM resto_orders
    INNER JOIN resto_status_order ON resto_orders.status_order = resto_status_order.id_status
    INNER JOIN resto_method_paid_order ON resto_orders.method_paid_order = resto_method_paid_order.id_cash
    INNER JOIN resto_products ON resto_orders.id_product = resto_products.id_product

INSERT INTO resto_orders
VALUES(null, null, 2, 100, 2, 2, 2, 2, (q_product*total_order))