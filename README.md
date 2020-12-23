### Delilah Restó

This project shows all the backend development of a platform capable of managing some important functions for a restaurant such as:

- Register and update users
- Login
- Create and update products
- Generate, update and delete orders
- View options menu

All of the above divided into two roles which according to their level of accessibility may or may not take specific actions in each of the modules:

- Administrators
- Costumers

The platform was developed and supported with the following technologies and libraries:

- Backend
  o Node.js
- Libraries
  o Express
  o Sequelize
  o Body Parser
  o Jwt
  o Bcrypt
- Platforms
  o Postman
- Xampp
- PHPMyAdmin

In order for you to test it locally, we recommend that you follow the steps below:

1. Have Node.js, Xampp, or Mamp installed on your computer to simulate a local server, git, and code editor such as Visual Studio Code and Postman for use and testing of each endpoint.
2. Clone the repository from https://github.com/Alpacorp/delilah-resto.git
3. Unzip the folder to view the files.
4. Open and lift your local server with Xampp or Mamp, then open the database manager in PHPMyAdmin.
5. Create a database named "delilah_resto".
6. Import the database from the file "delilah_resto.sql" into PHPMyAdmin
7. Open Postman and import the file "Delilah Restó.postman_collection.json"
8. Open the "index.js" file from Visual Studio Code.
9. Through the built-in console or separately, locate yourself in the path where the downloaded folder with the files is located, and, type in console "npm i" to install all the packages configured in the package.json
10. After the entire installation, type in the console "nodemon index.js" to start listening for the platform and raise the local server with Node.js
11. Go to Postman and start with your own new user registration at the endpoint located in the "Users / All Users / POST " user register".
12. Once you register you will need to go to the route "Users / All Users / POST user login" where you log in and the system responds with a token which you will need to copy.
13. Paste it into the preset settings by accessing the "Presets" option on the middle right, then go to "Manage Presets" and in the "Costumer" option in the "Value" field you paste the token from the word "Bearer" onwards and to the end.
14. The above will allow you to have a session configured to validate access to each of the endpoints.
15. If you do not wish to register, you can use the users already created and available for testing which I indicate below and access the login option mentioned above:
    A. Administrator: with all features and accesses:
    i. Email: testadmin@gmail.com Password: Colombia2021
    B. Customer: With limited access features:
    i. Email: testcostumer@gmail.com Password: Colombia2021
16. Once you access you can now interact with the endpoint options tree, but, it is important to note that each time you go to make a query you must enable the token in the "Headers" using the "Presets" settings. You will be able to choose the Administrator, Customer or the token that you have created, this will allow you to access the functionalities or not by applying the segmentation of user roles.
17. All official API documentation can be found at the following https://app.swaggerhub.com/apis-docs/Alpacorp/delilahresto/1.0.0 link or in the file "delilahresto-1.0.0.yaml"
