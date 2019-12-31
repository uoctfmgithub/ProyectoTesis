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
const SubCategorias=require('./routes/SubCategoria');

//ruta publica estatica
var publicDir = require('path').join(__dirname,'/public');
app.use(express.static(publicDir));

// Middlewares
app.use (bodyParser.json ({limit: '10mb', extended: true}))
app.use (bodyParser.urlencoded ({limit: '10mb', extended: true}))
//Settings

// const config=require('./config');
// app.set('GeneraToken',config.ClaveToken)
//Headers
app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept, Authorization"
  );
  if (req.method === "OPTIONS") {
    res.header("Access-Control-Allow-Methods", "PUT, POST, PATCH, DELETE, GET");
    return res.status(200).json({});
  }
  next();
});

// app.use(function(req, res, next) {
//     res.header("Access-Control-Allow-Origin", "*");
//     res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
//     next();
// });


// Routes
app.use("/medicamentos",MedicamentoRoutes);
app.use("/farmacias",FarmaciaRoutes);
app.use("/categorias",CategoriaRoutes);
app.use("/subcategorias",SubCategorias);

module.exports = app;