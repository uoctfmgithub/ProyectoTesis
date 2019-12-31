'use strict'
var sql = require('../conexionDB');

// Cargamos los modelos para usarlos posteriormente
const MedicamentoModel = require('../Models/Medicamento');
const fs = require('fs');
//Declaramos el controller
let MedicamentoController = {};

//Metodos



MedicamentoController.getMedicamento = function(req, res){
  try {
    MedicamentoModel.getAll(function(err, task) {
     // console.log('controller')
      if (err){
        res.send(err);
      }else{
    //    console.log('res', task);
        res.send(task);
      }
        
       
    });
  } catch (error) {
    console.log(error);
  }
};

MedicamentoController.getMedicamentoById = function(req, res){
  try {
    MedicamentoModel.getById(req.params.id, function(err, task) {
      if (err)
        res.send(err);
      res.json(task);
    });
  } catch (error) {
    console.log(error);
  }
};

MedicamentoController.deleteRegistrarMedicamento = function(req, res){
  try {
    MedicamentoModel.deleteById( req.params.id, function(err, task) {
      if (err)
        res.send(err);
      res.json({ message: 'Producto Eliminado Correctamente' });
    });
  } catch (error) {
    console.log(error);
  }
};

MedicamentoController.postRegistrarMedicamento = function(req, res){
  try {
    console.log("id"+req.body.ID_SUB_CATEGORIA)
    var nuevo_medicamento = new MedicamentoModel(req.body);

  //handles null error 
   if(!nuevo_medicamento.NOMBRE){

        res.status(400).send({ error:true, message: 'Please provide task/status' });

        }
else{
  
  MedicamentoModel.create(nuevo_medicamento, function(err, task) {
  //  console.log("backend medicamento" + JSON.stringify(nuevo_medicamento));
    if (err){
      res.send(err);
    }else{}
 
    
    const file = nuevo_medicamento.FILE;
    const name = nuevo_medicamento.ARCHIVO_IMAGEN;
    // console.log("Esta es la data"+(file))
  
    const binaryData = new Buffer(file.replace(/^data:image\/jpeg;base64,/,""), 'base64').toString('binary');
    fs.writeFile('./Api/public/imagenes/medicamentos/'+name, binaryData, "binary", (err) => {
        console.log(err);
    })



    res.json(task);
  });
}
  } catch (error) {
    console.log(error);
  }
};

MedicamentoController.updateMedicamento = function(req, res){
  try {
    MedicamentoModel.updateById(req.params.id, new MedicamentoModel(req.body), function(err, task) {
      if (err)
        res.send(err);
      res.json(task);
    });
  } catch (error) {
    console.log(error);
  }
};


MedicamentoController.getMedicamentoByTexto = function(req, res){
  try {
  //  console.log('texto: '+req.params.texto)
    if (req.params.texto=="null")
    {
      req.params.texto="";
    }
    MedicamentoModel.getByTexto(req.params.texto, function(err, task) {
     
      if (err)
        res.send(err);
      res.json(task);
    });
  } catch (error) {
    console.log(error);
  }
};

MedicamentoController.getComparacionPrecioTexto = function(req, res){
  try {
 //   console.log('texto: '+req.params.texto)
    if (req.params.texto=="null")
    {
      req.params.texto="";
    }
    MedicamentoModel.getComparacionPrecio(req.params.texto, function(err, task) {
     
      if (err)
        res.send(err);
      res.json(task);
    });
  } catch (error) {
    console.log(error);
  }
};

MedicamentoController.getSugerenciasMedicamentos = function(req, res){
  try {
 //   console.log('texto: '+req.params.texto)
    if (req.params.texto=="null")
    {
      req.params.texto="";
    }
    MedicamentoModel.getSugerencias(req.params.texto, function(err, task) {
     
      if (err)
        res.send(err);
      res.json(task);
    });
  } catch (error) {
    console.log(error);
  }
};



module.exports = MedicamentoController;