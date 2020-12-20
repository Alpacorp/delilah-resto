const express = require("express");
const server = express();
const port = 5000;
const bodyparser = require("body-parser");
const jwt = require("jsonwebtoken");
const signature = "hjtahsujlslppebIU";
const { sequelize } = require("./db_connect");
const bcrypt = require("bcrypt");

server.use(bodyparser.json());

//ORDERS

//Create

server.post('/orders', (req, res) => {
    const { q_product, total_order, status_order, method_paid_order, id_product, id_user } = req.body;
    sequelize.query('INSERT INTO resto_orders VALUES(null,null,?,?,?,?,?,?)', {
            replacements: [q_product, total_order, status_order, method_paid_order, id_product, id_user]
        })
        .then((orders) => {
            res.status(201).json({ message: "Data order insert successfully" });
        })
        .catch((err) => {
            res.json({ error: err });
        })
});

//Get

server.get('/orders', (req, res) => {
    sequelize.query('SELECT id_order, date_order, name_status, type_cash, total_order, name_product, description_product, name_user, email_user, phone_user, adress_user FROM resto_orders INNER JOIN resto_status_order ON resto_orders.status_order = resto_status_order.id_status INNER JOIN resto_method_paid_order ON resto_orders.method_paid_order = resto_method_paid_order.id_cash INNER JOIN resto_products ON resto_orders.id_product = resto_products.id_product INNER JOIN resto_users ON resto_orders.id_user = resto_users.id_user ORDER BY id_order ASC', {
            type: sequelize.QueryTypes.SELECT
        })
        .then((orders) => {
            res.json(orders);
        })
        .catch(err => {
            res.json({ error: err });
        })
});

//PRODUCTS

//Create

server.post('/products', (req, res) => {
    const { name_product, description_product, price_product, available_q_product } = req.body;
    sequelize.query('INSERT INTO resto_products VALUES(null,?,?,?,?,null)', {
            replacements: [name_product, description_product, price_product, available_q_product]
        })
        .then((products) => {
            res.status(401).json({ message: "Product added successfully" });
        })
});

//Get

server.get('/products', (req, res) => {
    sequelize.query('SELECT * FROM resto_products', {
            type: sequelize.QueryTypes.SELECT
        })
        .then((products) => {
            res.json(products);
        })
})

//Update

server.put('/products/:id', (req, res) => {
    const { name_product, description_product, price_product, available_q_product } = req.body;
    const id = req.params.id;
    sequelize.query('UPDATE resto_products SET name_product = ?, description_product = ?, price_product = ?, available_q_product = ? WHERE id_product = ?', {
            replacements: [name_product, description_product, price_product, available_q_product, id]
        })
        .then((products) => {
            res.json({ message: "Product update successfully" });
        });
});

//Delete

server.delete('/products/:id', (req, res) => {
    const id = req.params.id;
    sequelize.query('DELETE FROM resto_products WHERE id_product = ?', {
            replacements: [id]
        })
        .then((product) => {
            res.json({ message: "Product deleted successfully" });
        });
});

//USERS

//Create

server.post('/users', (req, res) => {
    const { name_user, email_user, phone_user, adress_user, pass_user } = req.body;
    const pass_encripted = bcrypt.hashSync(pass_user, 10);
    sequelize.query('INSERT INTO resto_users VALUES(null,?,?,?,?,?,null,DEFAULT)', {
            replacements: [name_user, email_user, phone_user, adress_user, pass_encripted]
        })
        .then((users) => {
            res.status(401).json({ message: "user created sucessfully" });
        });
});

//Login

const validateUserMd = (req, res, next) => {
    const { email, pass } = req.body;
    sequelize.query('SELECT * FROM resto_users', {
            type: sequelize.QueryTypes.SELECT
        })
        .then((users) => {
            let check = false;
            for (i of users) {
                var pass_check = bcrypt.compareSync(pass, i.pass_user);
                if (email == i.email_user && pass_check == true) {
                    check = true;
                }
            }
            if (check == true) {
                next()
            } else {
                res.json({ message: "invalid email or password" });
            }
        });
};

server.post('/login', [validateUserMd], (req, res) => {
    const { email, pass } = req.body;
    sequelize.query('SELECT id_user, name_user, email_user, rol FROM resto_users INNER JOIN resto_rol_id ON resto_users.rol_id = resto_rol_id.id WHERE email_user = ?', {
            type: sequelize.QueryTypes.SELECT,
            replacements: [email]
        })
        .then((user) => {
            let passJson = JSON.stringify(user);
            let token = jwt.sign(passJson, signature);
            res.json({
                message: "login sucess",
                information: `Un gusto tenerte por acá '${user[0].name_user}', tu rol asignado es '${user[0].rol}', con el podrás acceder a las opciones habilitadas para ti en Delilah Restó. Por favor copia el siguiente Token desde la palabra 'Bearer' hasta el final y pégalo en la parte de Header en la sección 'Value', en la sección 'Key' debes colocar 'Authorization', esto para todas las páginas que vas a visitar`,
                token: `Bearer ${token}`
            });
        })
});

const validateTokenMd = (req, res, next) => {
    try {
        const token = req.headers.authorization.split(' ')[1];
        const checkToken = jwt.verify(token, signature);
        if (checkToken) {
            req.token = checkToken;
            next();
        }
    } catch (error) {
        res.json({ message: error });
    }
};

server.get('/login/authenticate', [validateTokenMd], (req, res) => {
    res.send(`Un gusto tenerte por acá '${req.token[0].name_user}', tu rol asignado es '${req.token[0].rol}', con el podrás acceder a las opciones habilitadas para ti en Delilah Restó.`);
})


server.listen(port, () => {
    console.log(`running delilah in server port ${port}`);
})