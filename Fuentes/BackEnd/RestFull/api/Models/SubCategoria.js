'user strict';
var sql = require('../conexionDB');
//Producto object constructor
const SubCategoria = function(subcategoria){
    this.ID_SUB_CATEGORIA = subcategoria.ID_SUB_CATEGORIA
    this.ID_CATEGORIA = subcategoria.ID_CATEGORIA
    this.NOMBRE = subcategoria.NOMBRE
};

SubCategoria.getAll = function (result) {
    try {
        sql.query("call USP_Sub_Categoria(1,null,'')", function (err, res) {

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




module.exports= SubCategoria;