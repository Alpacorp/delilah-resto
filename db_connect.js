const Sequelize = require("sequelize");
// const sequelize = new Sequelize('mysql://root@localhost:3306/delila_resto');
const sequelize = new Sequelize('mysql://admin:Estefany2021**..@delilah-resto.csajcgloo6ru.us-east-2.rds.amazonaws.com:3306/delila_resto');
const mysql2 = require("mysql2");

module.exports = {sequelize};
