'use strict'
// Cargamos el módulo de express para poder crear rutas
const express = require('express');
// Cargamos el controlador
const CategoriaController = require('../Controllers/Categoria');
// Llamamos al router
const router = express.Router();
//const checkAuth = require('../Middlewares/authenticated'); 
// Creamos una ruta para los métodos que tenemos en nuestros controladores
router.get('/',CategoriaController.getCategoria)
router.get('/:id',CategoriaController.getCategoriaById)
router.post('/',CategoriaController.postRegistrarCategoria)
router.delete('/:id',CategoriaController.deleteRegistrarCategoria)
router.patch('/:id',CategoriaController.updateCategoria)
// Exportamos la configuración
module.exports = router;