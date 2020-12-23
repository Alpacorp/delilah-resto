const express = require("express");
const server = express();
const port = 5000;
const bodyparser = require("body-parser");
const jwt = require("jsonwebtoken");
const signature = "hjtahsujlslppebIU";
const { sequelize } = require("./db_connect");
const bcrypt = require("bcrypt");
const {
    validateUserLogin,
    validateToken,
    fieldsEmptyOrderCostumer,
    fieldsEmptySignUp,
    validateRolUser,
    validateUserExisting
} = require("./middlewares");

server.use(bodyparser.json());

/*======================================================================================================
END POINTS | ORDERS
=======================================================================================================*/

/*==================
ADMINISTRATORS
==================*/

//Create

server.post('/orders', [validateToken, validateRolUser], (req, res) => {
    const { q_product, status_order, method_paid_order, id_product, id_user } = req.body;
    sequelize.query('SELECT price_product FROM resto_products WHERE id_product = ?', {
            type: sequelize.QueryTypes.SELECT,
            replacements: [id_product]
        })
        .then((product) => {
            sequelize.query('INSERT INTO resto_orders VALUES(null,null,?,?,?,?,?,?)', {
                    replacements: [q_product, q_product * product[0].price_product, status_order, method_paid_order, id_product, id_user]
                })
                .then((orders) => {
                    res.status(201).json({ message: "Data order insert successfully" });
                })
                .catch((error) => {
                    res.status(404).json({ error: "One or more fields have erroneous or non-existing information, please review the information you submit again." });
                });
        })
        .catch((error) => {
            res.status(404).json({ error: "One or more fields have erroneous or non-existing information, please review the information you submit again." });
        });
});

//Get

server.get('/orders', [validateToken, validateRolUser], (req, res) => {
    sequelize.query('SELECT id_order, date_order, name_status, type_cash, q_product, price_product, total_order, name_product, description_product, name_user, email_user, phone_user, adress_user FROM resto_orders INNER JOIN resto_status_order ON resto_orders.status_order = resto_status_order.id_status INNER JOIN resto_method_paid_order ON resto_orders.method_paid_order = resto_method_paid_order.id_cash INNER JOIN resto_products ON resto_orders.id_product = resto_products.id_product INNER JOIN resto_users ON resto_orders.id_user = resto_users.id_user ORDER BY id_order ASC', {
            type: sequelize.QueryTypes.SELECT
        })
        .then((orders) => {
            res.json({
                message: `The total number of orders registered in delilah resto is '${orders.length}' `,
                orders: orders});
        })
        .catch((error) => {
            res.json(error);
        });
});

//Update

server.put('/orders/:id', [validateToken, validateRolUser], (req, res) => {
    const id = req.params.id;
    const { q_product, status_order, method_paid_order, id_product } = req.body;
    sequelize.query('SELECT price_product FROM resto_products WHERE id_product = ?', {
            type: sequelize.QueryTypes.SELECT,
            replacements: [id_product]
        })
        .then((product) => {
            sequelize.query('SELECT * FROM resto_orders WHERE id_order = ?', {
                    type: sequelize.QueryTypes.SELECT,
                    replacements: [id]
                })
                .then((order) => {
                    if (order[0].id_order == id) {
                        sequelize.query('UPDATE resto_orders SET q_product = ?, total_order = ?, status_order = ?, method_paid_order = ?, id_product = ? WHERE id_order = ?', {
                                replacements: [q_product, product[0].price_product * q_product, status_order, method_paid_order, id_product, id]
                            })
                            .then((order) => {
                                res.status(200).json({ message: "Order update successfully" });
                            })
                            .catch((error) => {
                                res.json({ error: "One or more fields have erroneous or non-existing information, please review the information you submit again." });
                            });
                    };
                })
                .catch((error) => {
                    res.status(404).json({ message: "There was an error in the order update, the indicated 'id' does not exist" });
                });
        })
});

//Delete

server.delete('/orders/:id', [validateToken, validateRolUser], (req, res) => {
    const id = req.params.id;
    sequelize.query('SELECT * FROM resto_orders WHERE id_order = ?', {
            type: sequelize.QueryTypes.SELECT,
            replacements: [id]
        })
        .then((order) => {
            let checkOrder = false
            for (let i = 0; i < order.length; i++) {
                const element = order[i];
                if (element.id_order == id) {
                    checkOrder = true;
                };
            };
            if (checkOrder) {
                sequelize.query('DELETE FROM resto_orders WHERE id_order = ?', {
                        replacements: [id]
                    })
                    .then((order) => {
                        res.json({ message: "Order deleted successfully" });
                    })
            } else {
                res.status(404).json({ message: "There was an error deleting the requested order with the 'id' as it does not exist in the database" });
            };
        });
});

/*======================================================================================================
END POINTS | ORDERS
=======================================================================================================*/

/*==================
COSTUMERS
==================*/

//Create order costumer

server.post('/order', [fieldsEmptyOrderCostumer, validateToken], (req, res) => {
    const { q_product, method_paid_order, id_product } = req.body;
    sequelize.query('SELECT * FROM resto_products WHERE id_product = ?', {
            type: sequelize.QueryTypes.SELECT,
            replacements: [id_product]
        })
        .then((product) => {
            sequelize.query('INSERT INTO resto_orders VALUES(null, null, ?, ?, DEFAULT, ?, ?, ?)', {
                    replacements: [q_product, product[0].price_product * q_product, method_paid_order, id_product, req.token[0].id_user, req.token[0].id]
                })
                .then((order) => {
                    res.json({ message: "Order created successfully" });
                })
                .catch((error) => {
                    res.status(404).json({
                        message: "One or more fields have erroneous or non-existing information, please review the information you submit again."});
                });
        })
        .catch((error) => {
            res.status(404).json({
                message: "One or more fields have erroneous or non-existing information, please review the information you submit again."});
        });
});

//Get order costumer

server.get('/order', [validateToken], (req, res) => {
    sequelize.query('SELECT id_order, date_order, q_product, total_order, name_status, type_cash, name_product, description_product FROM resto_orders INNER JOIN resto_status_order ON resto_orders.status_order = resto_status_order.id_status INNER JOIN resto_method_paid_order ON resto_orders.method_paid_order = resto_method_paid_order.id_cash INNER JOIN resto_products ON resto_orders.id_product = resto_products.id_product WHERE id_user = ? ORDER BY id_order ASC', {
            type: sequelize.QueryTypes.SELECT,
            replacements: [req.token[0].id_user]
        })
        .then((order) => {
            if (order[0]) {
                res.json({
                    message: `Hi '${req.token[0].name_user}', these are your '${order.length}' orders`,
                    order: order
                });
            } else {
                res.status(404).json({ message: "You don't have orders generated, you can go to 'POST' order costumer create' and create your first order, go!!" });
            };
        })
        .catch((error) => {
            res.status(404).json({ message: error });
        });
});

//Update order costumer

server.put('/order/:id', [fieldsEmptyOrderCostumer, validateToken], (req, res) => {
    const id = req.params.id;
    const { q_product, method_paid_order, id_product } = req.body;
    sequelize.query('SELECT * FROM resto_orders WHERE id_user = ? AND id_order = ?', {
            type: sequelize.QueryTypes.SELECT,
            replacements: [req.token[0].id_user, id]
        })
        .then((order) => {
            sequelize.query('SELECT price_product FROM resto_products WHERE id_product = ?', {
                    type: sequelize.QueryTypes.SELECT,
                    replacements: [id_product]
                })
                .then((product) => {
                    if (order[0].id_order) {
                        sequelize.query('UPDATE resto_orders SET q_product = ?, total_order = ?, method_paid_order = ?, id_product = ? WHERE id_order = ? AND id_user = ?', {
                                replacements: [q_product, product[0].price_product * q_product, method_paid_order, id_product, id, req.token[0].id_user]
                            })
                            .then((order) => {
                                res.status(200).json({ message: "Order update successfully, check it out in endpoint 'GET | order costumer'" });
                            })
                            .catch((error) => {
                                res.status(409).json({ error: `Hi ${req.token[0].name_user}, one or more fields have erroneous or non-existing information, please review the information you submit again.` });
                            });
                    };
                })
                .catch((error) => {
                    res.status(404).json({ message: "There was an error updating the order, the 'id' indicated does not correspond to orders placed on your own" });
                });
        });
});

/*======================================================================================================
END POINTS | PRODUCTS
=======================================================================================================*/

/*==================
ADMINISTRATORS
==================*/

//Create

server.post('/products', [validateToken, validateRolUser], (req, res) => {
    const { name_product, description_product, price_product, available_q_product } = req.body;
    sequelize.query('INSERT INTO resto_products VALUES(null,?,?,?,?,null)', {
            replacements: [name_product, description_product, price_product, available_q_product]
        })
        .then((products) => {
            res.status(201).json({ message: "Product added successfully" });
        })
});

//Get

server.get('/products', [validateToken, validateRolUser], (req, res) => {
    sequelize.query('SELECT * FROM resto_products', {
            type: sequelize.QueryTypes.SELECT
        })
        .then((products) => {
            res.json({
                message: `The total number of products registered in delilah resto is '${products.length}' `,
                products: products});
        });
});

//Update

server.put('/products/:id', [validateToken, validateRolUser], (req, res) => {
    const { name_product, description_product, price_product, available_q_product } = req.body;
    const id = req.params.id;
    sequelize.query('SELECT * FROM resto_products WHERE id_product = ?', {
            type: sequelize.QueryTypes.SELECT,
            replacements: [id]
        })
        .then((product) => {
            if (product[0].id_product == id) {
                sequelize.query('UPDATE resto_products SET name_product = ?, description_product = ?, price_product = ?, available_q_product = ? WHERE id_product = ?', {
                        replacements: [name_product, description_product, price_product, available_q_product, id]
                    })
                    .then((products) => {
                        res.json({ message: "Product update successfully" });
                    });
            }
        })
        .catch((error) => {
            res.status(404).json({ message: "There was an error in the product update, the indicated 'id' does not exist" });
        });
});

//Delete

server.delete('/products/:id', [validateToken, validateRolUser], (req, res) => {
    const id = req.params.id;
    sequelize.query('SELECT * FROM resto_products WHERE id_product = ?', {
            type: sequelize.QueryTypes.SELECT,
            replacements: [id]
        })
        .then((product) => {
            let checkProduct = false;
            for (let i = 0; i < product.length; i++) {
                const element = product[i];
                if (element.id_product = id) {
                    checkProduct = true;
                };
            };
            if (checkProduct) {
                sequelize.query('DELETE FROM resto_products WHERE id_product = ?', {
                        replacements: [id]
                    })
                    .then((product) => {
                        res.json({ message: "Product deleted successfully" });
                    })
                    .catch((error) => {
                        res.json(error);
                    });
            } else {
                res.status(404).json({ message: "There was an error deleting the requested product with the 'id' as it does not exist in the database" });
            };
        })
});

/*======================================================================================================
END POINTS | PRODUCTS
=======================================================================================================*/

/*==================
COSTUMERS
==================*/

//Get products costumer

server.get('/menu', [validateToken], (req, res) => {
    sequelize.query('SELECT id_product, name_product, description_product, price_product FROM resto_products', {
            type: sequelize.QueryTypes.SELECT
        })
        .then((menu) => {
            res.json({
                message: `Hi '${req.token[0].name_user}', delight in our food menu`,
                menu: menu
            });
        })
        .catch((error) => {
            res.json(error);
        });
});

/*======================================================================================================
END POINTS | USERS
=======================================================================================================*/

/*==================
ADMINISTRATORS
==================*/

//Create

server.post('/users', [fieldsEmptySignUp, validateUserExisting], (req, res) => {
    const { name_user, email_user, phone_user, adress_user, pass_user } = req.body;
    const pass_encripted = bcrypt.hashSync(pass_user, 10);
    sequelize.query('INSERT INTO resto_users VALUES(null,?,?,?,?,?,null,DEFAULT)', {
            replacements: [name_user, email_user, phone_user, adress_user, pass_encripted]
        })
        .then((users) => {
            res.status(201).json({ message: "User created successfully, go to 'POST' user login' to log in =>" });
        });
});

//Get

server.get('/users', [validateToken, validateRolUser], (req, res) => {
    sequelize.query('SELECT * FROM resto_users', {
            type: sequelize.QueryTypes.SELECT
        })
        .then((users) => {
            res.json({
                message: `The total number of registered users in delilah resto is '${users.length}' :) `,
                users: users});
        })
        .catch((error) => {
            res.json(error);
        });
});

//Update

server.put('/users/:id', [validateToken, validateRolUser], (req, res) => {
    const id = req.params.id;
    const { name_user, email_user, phone_user, adress_user, rol_id } = req.body;
    sequelize.query('SELECT * FROM resto_users WHERE id_user = ?', {
            type: sequelize.QueryTypes.SELECT,
            replacements: [id]
        })
        .then((user) => {
            if (user[0].id_user == id) {
                sequelize.query('UPDATE resto_users SET name_user = ?, email_user = ?, phone_user = ?, adress_user = ?, rol_id = ? WHERE id_user = ?', {
                        replacements: [name_user, email_user, phone_user, adress_user, rol_id, id]
                    })
                    .then((user) => {
                        res.status(200).json({ message: "User update successfully" })
                    })
                    .catch((error) => {
                        res.json(error);
                    });
            };
        })
        .catch((error) => {
            res.status(404).json({ message: "There was an error in the user update, the indicated 'id' does not exist" });
        });
});

//Delete

server.delete('/users/:id', [validateToken, validateRolUser], (req, res) => {
    const id = req.params.id;
    sequelize.query('SELECT * FROM resto_users WHERE id_user = ?', {
            type: sequelize.QueryTypes.SELECT,
            replacements: [id]
        })
        .then((user) => {
            let checkUser = false;
            for (let i = 0; i < user.length; i++) {
                const element = user[i];
                if (element.id_user == id) {
                    checkUser = true;
                };
            };
            if (checkUser) {
                sequelize.query('DELETE FROM resto_users WHERE id_user = ?', {
                        replacements: [id]
                    })
                    .then((user) => {
                        res.json({ message: "User deleted successfully" });
                    })
                    .catch((error) => {
                        res.status(409).json({ error: "You can't delete this user because it has associated information in the 'resto_order' table" });
                    });
            } else {
                res.status(404).json({ message: "There was an error deleting the requested user with the 'id' as it does not exist in the database" })
            }
        })
});

/*======================================================================================================
END POINTS | USERS
=======================================================================================================*/

/*==================
COSTUMERS
==================*/

//Update user costumer

server.put('/user', [validateToken], (req, res) => {
    const { name_user, email_user, phone_user, adress_user, pass_user } = req.body;
    const pass_encripted = bcrypt.hashSync(pass_user, 10);
    sequelize.query('UPDATE resto_users SET name_user = ?, email_user = ?, phone_user = ?, adress_user = ?, pass_user = ? WHERE id_user = ?', {
            replacements: [name_user, email_user, phone_user, adress_user, pass_encripted, req.token[0].id_user]
        })
        .then((user) => {
            res.status(200).json({ message: "User update successfully" });
        })
        .catch((error) => {
            res.json(error);
        });
});

/*======================================================================================================
END POINTS
=======================================================================================================*/

/*==================
ALL USERS
==================*/

//Login

server.post('/login', [validateUserLogin], (req, res) => {
    const { email, pass } = req.body;
    sequelize.query('SELECT id_user, name_user, email_user, id, rol FROM resto_users INNER JOIN resto_rol_id ON resto_users.rol_id = resto_rol_id.id WHERE email_user = ?', {
            type: sequelize.QueryTypes.SELECT,
            replacements: [email]
        })
        .then((user) => {
            let passJson = JSON.stringify(user);
            let token = jwt.sign(passJson, signature);
            res.json({
                message: "login success.",
                information: `Un gusto tenerte por acá '${user[0].name_user}', tu rol asignado es '${user[0].rol}', con el podrás acceder a las opciones habilitadas para ti en Delilah Restó. La forma como lo puedes hacer es la siguiente, en cada ruta que vayas acceder deberás crear en la pestaña 'Headers' una nueva fila con un 'Key' d nombre 'Authorization' y un 'Value' con la información del token a continuación copia desde la palabra 'Bearer' hasta el final y pégalo en ese campo.`,
                token: `Bearer ${token}`
            });
        })
});

/*======================================================================================================
SERVER RUNNING
=======================================================================================================*/

server.listen(port, () => {
    console.log(`running delilah in server port ${port}`);
})