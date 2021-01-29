const Sequelize = require("sequelize");
const sequelize = new Sequelize('mysql://root@localhost:3306/delila_resto');
const mysql2 = require("mysql2");

module.exports = {sequelize};
