'use strict'
// Cargamos los modelos para usarlos posteriormente
const SubCategoriaModel = require('../Models/SubCategoria');
//Declaramos el controller
let SubCategoriaController = {};

//Metodos
SubCategoriaController.getSubCategoria = function(req, res){
    try {
        SubCategoriaModel.getAll(function(err, task) {
       // console.log('controller')
        if (err)
          res.send(err);
       //   console.log('res', task);
        res.send(task);
      });
    } catch (error) {
      console.log(error);
    }
};




module.exports = SubCategoriaController;