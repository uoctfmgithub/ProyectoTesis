import { Component, OnInit } from '@angular/core';
import {ServiceService} from '../ServiciosEnvioData/service.service';
import {homeService} from '../../home/home.Service';
import {ComparacionModelo} from './comparacionPrecios.modelo';



@Component({
  selector: 'app-comparacion',
  templateUrl: './comparacion.medicamento.html',
  styleUrls: ['./comparacion.medicamento.css']
})

export class ComparacionComponent implements OnInit {

  textoCompleto:String;
  cantidadconsultaprecio:number;

  public dataComparacionPreciosAll:any[];

  dataSugerencias:any =[];


  public arrayDesdeService: Array<any>;

  public dataComparacionPrecios: Array<ComparacionModelo> = [];

  mostrar=false;
  

  ruta_imagen = '../../../assets/imagenes_producto/';


  // _service: ServiceService nos pasara el json del componente 1 al componente 2
  constructor (private _service: ServiceService,private homeService: homeService) {
  }

      ngOnInit() {
        console.log("Hola");
        this.arrayDesdeService = this._service.getArray();
        console.log("COMPONENTE 2 "+ JSON.stringify(this.arrayDesdeService))

        // this.cantidadconsultaprecio=this.arrayDesdeService.length;
       


        if (this.arrayDesdeService != undefined ) {
          this.mostrarComparacion();
        } else {
          
        }
        
      }


      mostrarComparacion(){
        var i=0;
        this.textoCompleto=this.arrayDesdeService[0].NOMBRE_PRODUCTO;
        
        
    
        this.homeService.getComparacionPrecio(this.textoCompleto).subscribe(res=>{

          this.dataComparacionPreciosAll=res[0];

          this.mostrar=true

          for (i ; i < this.dataComparacionPreciosAll.length; i++) {
            if (this.dataComparacionPreciosAll[i].PRECIO==this.arrayDesdeService[0].PRECIO) {   
              // delete this.dataFletes[i]
               
            } else{
              this.dataComparacionPrecios.push(this.dataComparacionPreciosAll[i]) 
            }
      }

            // this.dataComparacionPrecios=res[0];
          console.log(JSON.stringify(this.dataComparacionPrecios))
        });

        this.BuscarComparacion();
      }

      BuscarComparacion(){
        // let sugerencia1="";
        // let sugerencia2="";
        // let sugerencia3="";
        // let nombreProducto= this.arrayDesdeService[0].NOMBRE_PRODUCTO;
        // sugerencia1 = nombreProducto.split(' ')[0] // "Bienvenidos"
        // sugerencia2 = nombreProducto.split(' ')[1]
        // sugerencia3 = nombreProducto.split(' ')[2]
        // this.dataSugerencias.push({
        //   "sugerencia1":sugerencia1,
        //   "sugerencia2":sugerencia2,
        //   "sugerencia3":sugerencia3,
        // });

        this.homeService.getSugerencias(this.arrayDesdeService[0].NOMBRE_CATEGORIA).subscribe(res=>{

          this.dataSugerencias=res[0];

            // this.dataComparacionPrecios=res[0];
          console.log(JSON.stringify(this.dataSugerencias))
        });

        
      }
        // console.log(JSON.stringify(this.dataSugerencias));

      }
