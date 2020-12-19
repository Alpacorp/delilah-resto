const express = require("express");
const server = express();
const port = 5000;
const bodyparser = require("body-parser");
const jwt = require("jsonwebtoken");
const { sequelize } = require("./db_connect");

server.use(bodyparser.json());

//ORDERS

//Create

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

//Get

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

//PRODUCTS

//Create

server.post('/products', (req, res)=>{
    const { name_product, description_product, price_product, available_q_product} = req. body;
    sequelize.query('INSERT INTO resto_products VALUES(null,?,?,?,?,null)', {
        replacements: [name_product, description_product, price_product, available_q_product]
    })
    .then((products)=>{
        res.status(401).json({message: "Product added sucessfull"});
    })
});

//Get

server.get('/products', (req, res)=>{
    sequelize.query('SELECT * FROM resto_products', {
        type: sequelize.QueryTypes.SELECT
    })
    .then((products)=>{
        res.json(products);
    })
})

//Update

server.put('/products/:id', (req, res)=>{
    const { name_product, description_product, price_product, available_q_product} = req. body;
    const id = req.params.id;
    sequelize.query('UPDATE resto_products SET name_product = ?, description_product = ?, price_product = ?, available_q_product = ? WHERE id_product = ?', {
        replacements: [name_product, description_product, price_product, available_q_product, id]
    })
    .then((products)=>{
        res.json({message: "product update sucessfully"});
    });
});

//Delete

server.delete('/products/:id', (req, res)=>{
    const id = req.params.id;
    sequelize.query('DELETE FROM resto_products WHERE id_product = ?',{
        replacements: [id]
    })
    .then((product)=>{
        res.json({message: "product deleted sucessfully"});
    });
});

//USERS

//Create

server.post('/users', (req, res)=>{
    const {name_user, email_user, phone_user, adress_user, pass_user} = req.body;
    sequelize.query('INSERT INTO resto_users VALUES(null,?,?,?,?,?,null,DEFAULT)', {
        replacements: [name_user, email_user, phone_user, adress_user, pass_user]
    })
    .then((users)=>{
        res.status(401).json({message: "user created sucessfully"})
    })
})

server.listen(port, () => {
    console.log(`running server port ${port}`);
})