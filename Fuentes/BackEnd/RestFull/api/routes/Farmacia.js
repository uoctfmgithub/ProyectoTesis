'use strict'
// Cargamos el módulo de express para poder crear rutas
const express = require('express');
// Cargamos el controlador
const FarmaciaController = require('../Controllers/Farmacia');
// Llamamos al router
const router = express.Router();
//const checkAuth = require('../Middlewares/authenticated'); 
// Creamos una ruta para los métodos que tenemos en nuestros controladores
router.get('/',FarmaciaController.getFarmacia)
router.get('/:id',FarmaciaController.getFarmaciaById)
router.post('/',FarmaciaController.postRegistrarFarmacia)
router.delete('/:id',FarmaciaController.deleteRegistrarFarmacia)
router.patch('/:id',FarmaciaController.updateFarmacia)
// Exportamos la configuración
module.exports = router;