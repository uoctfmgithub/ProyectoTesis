'user strict';

var mysql = require('mysql');

const config=require('./config')

//local mysql db connection
var connection = mysql.createConnection(config.db);

connection.connect(function(err) {
    if (err) throw err
    else{
      console.log("Conectado Correctamente");
    };
});

module.exports = connection;