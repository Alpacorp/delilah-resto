const Sequelize = require("sequelize");
const sequelize = new Sequelize('mysql://root@localhost:3306/delila_resto');

module.exports = {sequelize};