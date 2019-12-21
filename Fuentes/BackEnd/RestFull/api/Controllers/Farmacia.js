'use strict'
// Cargamos los modelos para usarlos posteriormente
const FarmaciaModel = require('../Models/Farmacia');
//Declaramos el controller
let FarmaciaController = {};

//Metodos
FarmaciaController.getFarmacia = function(req, res){
    try {
      FarmaciaModel.getAll(function(err, task) {
        console.log('controller')
        if (err)
          res.send(err);
          console.log('res', task);
        res.send(task);
      });
    } catch (error) {
      console.log(error);
    }
};

FarmaciaController.getFarmaciaById = function(req, res){
  try {
    FarmaciaModel.getById(req.params.id, function(err, task) {
      if (err)
        res.send(err);
      res.json(task);
    });
  } catch (error) {
    console.log(error);
  }
};

FarmaciaController.deleteRegistrarFarmacia = function(req, res){
  try {
    FarmaciaModel.deleteById( req.params.id, function(err, task) {
      if (err)
        res.send(err);
      res.json({ message: 'Producto Eliminado Correctamente' });
    });
  } catch (error) {
    console.log(error);
  }
};


FarmaciaController.postRegistrarFarmacia = function(req, res){
  try {
    var nuevo_Farmacia = new FarmaciaModel(req.body);

  //handles null error 
   if(!nuevo_Farmacia.NOMBRE){
            res.status(400).send({ error:true, message: 'Please provide task/status' });
        }
else{
  
  FarmaciaModel.create(nuevo_Farmacia, function(err, task) {
    
    if (err)
      res.send(err);
    res.json(task);
  });
}
  } catch (error) {
    console.log(error)
  }
};

FarmaciaController.updateFarmacia = function(req, res){
  try {
    FarmaciaModel.updateById(req.params.id, new FarmaciaModel(req.body), function(err, task) {
      if (err)
        res.send(err);
      res.json(task);
    });
  } catch (error) {
    console.log(error);
  }
};

module.exports = FarmaciaController;