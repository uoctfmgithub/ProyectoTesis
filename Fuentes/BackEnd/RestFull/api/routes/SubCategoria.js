'use strict'
// Cargamos el módulo de express para poder crear rutas
const express = require('express');
// Cargamos el controlador
const SubCategoriaController = require('../Controllers/SubCategoria');
// Llamamos al router
const router = express.Router();
//const checkAuth = require('../Middlewares/authenticated'); 
// Creamos una ruta para los métodos que tenemos en nuestros controladores
router.get('/',SubCategoriaController.getSubCategoria)

// Exportamos la configuración
module.exports = router;