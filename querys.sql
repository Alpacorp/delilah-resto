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