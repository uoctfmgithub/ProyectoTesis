'use strict'
// Cargamos el módulo de express para poder crear rutas
const express = require('express');
// Cargamos el controlador
const MedicamentoController = require('../Controllers/Medicamento');
// Llamamos al router
const router = express.Router();
// const checkAuth = require('../Middlewares/authenticated'); 
// Creamos una ruta para los métodos que tenemos en nuestros controladores
router.post('/',MedicamentoController.postRegistrarMedicamento)
router.get('/',MedicamentoController.getMedicamento)
router.get('/:id',MedicamentoController.getMedicamentoById)
router.delete('/:id',MedicamentoController.deleteRegistrarMedicamento)
router.patch('/:id',MedicamentoController.updateMedicamento)
router.get('/buscar/:texto',MedicamentoController.getMedicamentoByTexto)

// Exportamos la configuración
module.exports = router;