'user strict';
var sql = require('../conexionDB');
//Producto object constructor
const Medicamento = function(medicamento){
    this.NOMBRE = medicamento.NOMBRE
    this.DESCRIPCION = medicamento.DESCRIPCION
    this.LABORATORIO = medicamento.LABORATORIO
    this.MARCA = medicamento.MARCA
    this.ID_CATEGORIA = medicamento.ID_CATEGORIA
    this.ID_SUB_CATEGORIA = medicamento.ID_SUB_CATEGORIA
    this.ARCHIVO_IMAGEN = medicamento.ARCHIVO_IMAGEN
    this.FILE = medicamento.FILE
};

Medicamento.getAll = function (result) {
    try {
        sql.query("call USP_Medicamento(1,null,'','','','',null,null,'')", function (err, res) {

            if(err) {
                console.log("error: ", err);
                result(null, err);
            }
            else{
              console.log('res : ', res);  

             result(null, res);
            }
        });   
    } catch (error) {
        console.log(error);
    }
};

Medicamento.getById = function (id, result) {
    try {
        console.log("Este es el id:"+id);
    sql.query("call USP_Medicamento('5','"+ id +"','','','','',null,null,'')",id, function (err, res) {             
            if(err) {
                console.log("error: ", err);
                result(err, null);
            }
            else{
                result(null, res);         
            }
        });   
    } catch (error) {
        console.log(error);
    }
};

Medicamento.deleteById = function(id, result){
    try {
        sql.query("call USP_Medicamento('4','"+id+"','','','','',null,null,'')", [id], function (err, res) {

            if(err) {
                console.log("error: ", err);
                result(null, err);
            }
            else{          
             result(null, res);
            }
        }); 
    } catch (error) {
        console.log(error);
    }
};

Medicamento.create = function (newMedicamento, result) {    
    try {
        sql.query("call USP_Medicamento(2,0,'"+
    newMedicamento.NOMBRE+"','"+
    newMedicamento.DESCRIPCION+"','"+
    newMedicamento.LABORATORIO+"','"+
    newMedicamento.MARCA+"',"+
    newMedicamento.ID_CATEGORIA+","+
    newMedicamento.ID_SUB_CATEGORIA+",'"+
    newMedicamento.ARCHIVO_IMAGEN+"')", newMedicamento, function (err, res) {
            
            if(err) {
                console.log("error: ", err);
                result(err, null);
            }
            else{
                console.log(res.NOMBRE);
                result(null, res.NOMBRE);
            }
        });  
    } catch (error) {
        console.log(error);
    }         
};

Medicamento.updateById = function(id, dataMedicamento, result){
    try {
        sql.query("call USP_Medicamento(3,"+id+",'"+
    dataMedicamento.NOMBRE +"','"+
    dataMedicamento.DESCRIPCION +"','"+
    dataMedicamento.LABORATORIO +"','"+
    dataMedicamento.MARCA +"',"+
    dataMedicamento.ID_CATEGORIA+","+
    dataMedicamento.ID_SUB_CATEGORIA+",'"+
    dataMedicamento.ARCHIVO_IMAGEN+"')", dataMedicamento, function (err, res) {
            if(err) {
                console.log("error: ", err);
                  result(null, err);
               }
             else{   
               result(null, res);
                  }
              }); 
    } catch (error) {
        console.log(error);
    }
  };


  Medicamento.getByTexto = function (texto, result) {
    try {
        console.log("Este es el texto:"+texto);
    sql.query("call USP_Buscar_Producto(2,'"+ texto +"')",texto, function (err, res) {             
            if(err) {
                console.log("error: ", err);
                result(err, null);
            }
            else{
                result(null, res);
            }
        });   
    } catch (error) {
        console.log(error);
    }
};

Medicamento.getComparacionPrecio = function (texto, result) {
    try {
        console.log("Este es el texto:"+texto);
    sql.query("call USP_Buscar_Producto(2,'"+ texto +"')",texto, function (err, res) {             
            if(err) {
                console.log("error: ", err);
                result(err, null);
            }
            else{
                result(null, res);
            }
        });   
    } catch (error) {
        console.log(error);
    }
};

Medicamento.getSugerencias = function (texto, result) {
    try {
        console.log("Este es el texto:"+texto);
    sql.query("call USP_SUGERENCIAS('"+ texto +"')",texto, function (err, res) {             
            if(err) {
                console.log("error: ", err);
                result(err, null);
            }
            else{
                result(null, res);
            }
        });   
    } catch (error) {
        console.log(error);
    }
};

module.exports= Medicamento;