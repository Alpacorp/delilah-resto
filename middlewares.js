const jwt = require("jsonwebtoken");
const signature = "hjtahsujlslppebIU";
const { sequelize } = require("./db_connect");
const bcrypt = require("bcrypt");

/*======================================================================================================
MIDDLEWARES
=======================================================================================================*/

exports.validateUserLogin = (req, res, next) => {
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
                };
            };
            if (check == true) {
                next();
            } else {
                res.json({ message: "invalid email or password" });
            };
        });
};

exports.validateToken = (req, res, next) => {
    try {
        const token = req.headers.authorization.split(' ')[1];
        const checkToken = jwt.verify(token, signature);
        if (checkToken) {
            req.token = checkToken;
            next();
        } else {
            res.json({ message: "Dont exist token in Headers" });
        }
    } catch (error) {
        function notFound(res) {
            res.status(404).json({ error: "You're not authenticated or your token is wrong to view this content" });
        };
        notFound(res);
    };
};

exports.fieldsEmptyOrderCostumer = (req, res, next) => {
    const { q_product, method_paid_order, id_product } = req.body;
    if (!q_product || !method_paid_order || !id_product) {
        res.json({ error: "One or more fields have erroneous or non-existing information, please review the information you submit again." });
    } else {
        res.status(201);
        next();
    };
};

exports.fieldsEmptySignUp = (req, res, next) => {
    const { name_user, email_user, phone_user, adress_user, pass_user } = req.body;
    if (!name_user || !email_user || !phone_user || !adress_user || !pass_user) {
        res.json({ error: "One or more fields have erroneous or non-existing information, please review the information you submit again." });
    } else {
        res.status(201);
        next();
    };
};

exports.validateRolUser = (req, res, next) => {
    const token = req.headers.authorization.split(" ")[1];
    const checkToken = jwt.verify(token, signature);
    if (checkToken[0].id == 1) {
        next();
    } else {
        res.json({ message: "You don't have the necessary permissions to access this content :(" });
    };
};

exports.validateUserExisting = (req, res, next) => {
    const { email_user } = req.body;
    sequelize.query('SELECT email_user FROM resto_users', {
            type: sequelize.QueryTypes.SELECT,
        })
        .then((mail) => {
            let emailCheck = false;
            for (let i = 0; i < mail.length; i++) {
                const element = mail[i];
                if (element.email_user == email_user) {
                    emailCheck = true;
                };
            };
            if (emailCheck == true) {
                res.json({ message: "The user registered with the email already exists, your request is not valid, please check again." })
            } else {
                next();
            };
        });
};