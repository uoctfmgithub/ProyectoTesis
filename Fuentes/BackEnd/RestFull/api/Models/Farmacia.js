'user strict';
var sql = require('../conexionDB');
//Farmacia object constructor
const Farmacia = function(farmacia){
    this.NOMBRE = farmacia.NOMBRE;
    this.DIRECCION = farmacia.DIRECCION;
    this.TELEFONO = farmacia.TELEFONO;
    this.MOVIL = farmacia.MOVIL;
    this.LATITUD=farmacia.LATITUD;
    this.LONGITUD = farmacia.LONGITUD;
    this.PROVINCIA=farmacia.PROVINCIA;
    this.CORREO=farmacia.CORREO;
    this.ID_PAIS=farmacia.ID_PAIS;
    this.CODIGO_POSTAL=farmacia.CODIGO_POSTAL;
};

Farmacia.getAll = function (result) {
    try {
        sql.query("call USP_Farmacia(1,null,'','','','','','','','',null,'',null)", function (err, res) {

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

Farmacia.getById = function (id, result) {
    try {
        console.log("Este es el id:"+id);
    sql.query("call USP_Farmacia('5','"+ id +"','','','','','','','','',null,'',null)",id, function (err, res) {             
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

Farmacia.deleteById = function(id, result){
    try {
        sql.query("call USP_Farmacia('4','"+id+"','','','','','','','','',null,'',null)", [id], function (err, res) {

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


Farmacia.create = function (newFarmacia, result) {    
 try {
    sql.query("call USP_Farmacia(2,0,'"+
    newFarmacia.NOMBRE+"','"+
    newFarmacia.DIRECCION+"','"+
    newFarmacia.TELEFONO+"','"+
    newFarmacia.MOVIL+"','"+
    newFarmacia.LATITUD+"','"+
    newFarmacia.LONGITUD+"','"+
    newFarmacia.PROVINCIA+"','"+
    newFarmacia.CORREO+"',"+
    newFarmacia.ID_PAIS+",'"+
    newFarmacia.CODIGO_POSTAL+"','2019-12-11')", newFarmacia, function (err, res) {
            
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

Farmacia.updateById = function(id, dataFarmacia, result){
   try {
    sql.query("call USP_Farmacia(3,"+id+",'"+
    dataFarmacia.NOMBRE+"','"+
    dataFarmacia.DIRECCION+"','"+
    dataFarmacia.TELEFONO+"','"+
    dataFarmacia.MOVIL+"','"+
    dataFarmacia.LATITUD+"','"+
    dataFarmacia.LONGITUD+"','"+
    dataFarmacia.PROVINCIA+"','"+
    dataFarmacia.CORREO+"',"+
    dataFarmacia.ID_PAIS+",'"+
    dataFarmacia.CODIGO_POSTAL+"','2019-12-11')", dataFarmacia, function (err, res) {
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


module.exports= Farmacia;