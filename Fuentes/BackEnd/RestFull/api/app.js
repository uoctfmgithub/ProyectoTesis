'use strict'
const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const morgan = require("morgan");
const MySQL= require('./conexionDB');

//cargar  routes
const MedicamentoRoutes=require('./routes/Medicamento');
const FarmaciaRoutes=require('./routes/Farmacia');
const CategoriaRoutes=require('./routes/Categoria');


// Middlewares
app.use(bodyParser.urlencoded({extended : false }));
app.use(bodyParser.json());
app.use(bodyParser.json({extended:true}))
app.use(express.json());
app.use(morgan("dev"));

//Settings
const config=require('./config');
//app.set('GeneraToken',config.ClaveToken)
//Headers
app.use((req, res, next) => {
  // res.header("Access-Control-Allow-Origin", "*");
  // res.header(
  //   "Access-Control-Allow-Headers",
  //   "Origin, X-Requested-With, Content-Type, Accept, Authorization"
  // );
  // if (req.method === "OPTIONS") {
  //   res.header("Access-Control-Allow-Methods", "PUT, POST, PATCH, DELETE, GET");
  //   return res.status(200).json({});
  // }
  next();
});


// Routes
app.use("/medicamentos",MedicamentoRoutes);
app.use("/farmacias",FarmaciaRoutes);
app.use("/categorias",CategoriaRoutes);

module.exports = app;