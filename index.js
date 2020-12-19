const express = require("express");
const server = express();
const port = 5000;
const bodyparser = require("body-parser");
const jwt = require("jsonwebtoken");
const { sequelize } = require("./db_connect");

server.use(bodyparser.json());

server.get('/orders', (req, res) => {
    sequelize.query('SELECT resto_orders.*, resto_products.*, resto_method_paid_order.* FROM resto_orders INNER JOIN resto_method_paid_order, resto_products', {
            type: sequelize.QueryTypes.SELECT
        })
        .then((orders) => {
            res.json(orders);
        })
        .catch(err => {
            res.json({ error: err });
        })
});

server.post('/orders', (req, res) => {
    const { total_order, status_order, method_paid_order, id_product, id_user } = req.body;
    sequelize.query('INSERT INTO resto_orders VALUES(null,?,null,?,?,?,?)', {
            replacements: [total_order, status_order, method_paid_order, id_product, id_user]
        })
        .then((orders) => {
            res.status(201).json({ message: "Data insert sucessfully" });
        })
        .catch((err) => {
            res.json({ error: err });
        })
});

server.get('/menu', (req, res) => {
    sequelize.query('SELECT * FROM resto_products', {
            type: sequelize.QueryTypes.SELECT
        })
        .then((menu) => {
            res.json({ menu });
        })
})

server.listen(port, () => {
    console.log(`running server port ${port}`);
})