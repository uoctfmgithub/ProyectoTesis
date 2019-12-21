'use strict'
// Cargamos los modelos para usarlos posteriormente
const CategoriaModel = require('../Models/Categoria');
//Declaramos el controller
let CategoriaController = {};

//Metodos
CategoriaController.getCategoria = function(req, res){
    try {
        CategoriaModel.getAll(function(err, task) {
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

CategoriaController.getCategoriaById = function(req, res){
  try {
    CategoriaModel.getById(req.params.id, function(err, task) {
      if (err)
        res.send(err);
      res.json(task);
    });
  } catch (error) {
    console.log(error);
  }
};

CategoriaController.deleteRegistrarCategoria = function(req, res){
  try {
    CategoriaModel.deleteById( req.params.id, function(err, task) {
      if (err)
        res.send(err);
      res.json({ message: 'Categoria Eliminada Correctamente' });
    });
  } catch (error) {
    console.log(error);
  }
};


CategoriaController.postRegistrarCategoria = function(req, res){
  try {
    var nueva_Categoria = new CategoriaModel(req.body);

  //handles null error 
   if(!nueva_Categoria.NOMBRE_CATEGORIA){
            res.status(400).send({ error:true, message: 'Please provide task/status' });
        }
else{
    CategoriaModel.create(nueva_Categoria, function(err, task) {
    
    if (err)
      res.send(err);
    res.json(task);
  });
}
  } catch (error) {
    console.log(error)
  }
};

CategoriaController.updateCategoria = function(req, res){
  try {
    CategoriaModel.updateById(req.params.id, new CategoriaModel(req.body), function(err, task) {
      if (err)
        res.send(err);
      res.json(task);
    });
  } catch (error) {
    console.log(error);
  }
};

module.exports = CategoriaController;