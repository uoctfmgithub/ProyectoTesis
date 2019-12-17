'user strict';
var sql = require('../conexionDB');
//Categoria object constructor
const Categoria = function(categoria){
    this.NOMBRE_CATEGORIA  = categoria.NOMBRE_CATEGORIA;
};

Categoria.getAll = function (result) {
    try {
        sql.query("call USP_Categoria(1,null,'',null)", function (err, res) {

            if(err) {
                console.log("error: ", err);
                result(null, err);
            }
            else{
              console.log('tasks : ', res);  

             result(null, res);
            }
        });   
    } catch (error) {
        console.log(error);
    }
    
};

Categoria.getById = function (id, result) {
    try {
        console.log("Este es el id:"+id);
    sql.query("call USP_Categoria('5','"+ id +"','',null)",id, function (err, res) {             
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

Categoria.deleteById = function(id, result){
    try {
        sql.query("call USP_Categoria('4','"+id+"','',null)", [id], function (err, res) {

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


Categoria.create = function (newCategoria, result) {    
 try {
    sql.query("call USP_Categoria(2,0,'"+
    newCategoria.NOMBRE_CATEGORIA+"','2019-12-11')", newCategoria, function (err, res) {
            
            if(err) {
                console.log("error: ", err);
                result(err, null);
            }
            else{
                console.log(res.NOMBRE_CATEGORIA);
                result(null, res.NOMBRE_CATEGORIA);
            }
        });    
 } catch (error) {
     console.log(error);
 }       
};

Categoria.updateById = function(id, dataCategoria, result){
   try {
    sql.query("call USP_Categoria(3,"+id+",'"+
    dataCategoria.NOMBRE_CATEGORIA+"','2019-12-11')", dataCategoria, function (err, res) {
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


module.exports= Categoria;