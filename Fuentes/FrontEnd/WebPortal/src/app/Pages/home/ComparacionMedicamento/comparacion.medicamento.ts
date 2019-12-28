import { Component, OnInit} from '@angular/core';
import {ServiceService} from '../ServiciosEnvioData/service.service';
import {homeService} from '../../home/home.Service';
import {ComparacionModelo} from './comparacionPrecios.modelo';
import { Router } from '@angular/router';
import {Globals} from '../../../Share/Global';
import {NgModule} from '@angular/core';


@Component({
  selector: 'app-comparacion',
  templateUrl: './comparacion.medicamento.html',
  styleUrls: ['./comparacion.medicamento.css']
})
@NgModule({
  providers: [Globals ], // this depends on situation, see below
  imports: [
  
  ]
})
export class ComparacionComponent implements OnInit {
  ///////////////////////////////
  data:string;

  public dataBuscarProducto:any[];
  public dataBuscarProductoR:any[];

  public mostrar=false;

  public dataComparacionSeleccionado: Array<ComparacionModelo> = [];
    
  resultadoTexto:String;
  mensajeNoFound:String;
  
  name:string;

  // showScroll: boolean;
  // showScrollHeight = 300;
  // hideScrollHeight = 10;

  // @HostListener('window:scroll')
  // onWindowScroll() 
  // {
  //   if (( window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop) > this.showScrollHeight) 
  //   {
  //       this.showScroll = true;
  //   } 
  //   else if ( this.showScroll && (window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop) < this.hideScrollHeight) 
  //   { 
  //     this.showScroll = false; 
  //   }
  // }

////////////////////////////

  textoCompleto:String;
  cantidadconsultaprecio:number;

  latitud_actual: number;
  longitud_actual: number;
  zoom:number;

  public dataComparacionPreciosAll:any[];

  dataSugerencias:any =[];
 
  public ocultar = true;

  public arrayDesdeService: Array<any>;

  public dataComparacionPrecios: Array<ComparacionModelo> = [];



  ruta_imagen = '../../../assets/imagenes_producto/';


  // _service: ServiceService nos pasara el json del componente 1 al componente 2
  constructor (private _service: ServiceService,private homeService: homeService,private router: Router, private globals: Globals) {
  }
  dataMedicamentos = this.dataBuscarProductoR;
ngOnInit() {
       
        this.CargarComparacion();
      }

      CargarComparacion()
      {
        this.dataComparacionSeleccionado=[];
        this.arrayDesdeService=[];
        this.dataComparacionPrecios=[];
        this.setCurrentLocation();
        this.globals.ocultar = true;
        this.arrayDesdeService = this._service.getArray();
        if (this.arrayDesdeService != undefined ) {
          this.mostrarComparacion();
        } else {
          this.router.navigateByUrl('/home');
        }
      }
mostrarComparacion(){
        this.ocultar = true;
        var i=0;
        this.textoCompleto=this.arrayDesdeService[0].NOMBRE_PRODUCTO;
        this.homeService.getComparacionPrecio(this.textoCompleto).subscribe(res=>{
        this.dataComparacionPreciosAll=res[0];
        this.mostrar=true
          for (i ; i < this.dataComparacionPreciosAll.length; i++) {
            if (this.dataComparacionPreciosAll[i].PRECIO==this.arrayDesdeService[0].PRECIO) {   
              
            } else{
              this.dataComparacionPrecios.push(this.dataComparacionPreciosAll[i]) 
              }
      }
      });

        this.BuscarComparacion();
      }

      BuscarComparacion(){
        this.homeService.getSugerencias(this.arrayDesdeService[0].ID_SUB_CATEGORIA).subscribe(res=>{

          this.dataSugerencias=res[0];
        });
      }

  geolocalizacion(lt,lg):number{
        var resultado = this.getKilometros(this.latitud_actual,this.longitud_actual,lt,lg)
          return resultado
    }

  setCurrentLocation() {
    if ('geolocation' in navigator) {
        navigator.geolocation.getCurrentPosition((position) => {
          this.latitud_actual = position.coords.latitude;
          this.longitud_actual = position.coords.longitude;
          this.zoom = 15;
        });
      }
    }

  getKilometros(lat1,lon1,lat2,lon2):number{
        var rad = function(x) {return x*Math.PI/180;}
       var R = 6378.137; //Radio de la tierra en km
        var dLat = rad( lat2 - lat1 );
     //   console.log( "diferencia lat" + dLat);
        var dLong = rad( lon2 - lon1 );
      //  console.log("deferencia lon" + dLong);
       var a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(rad(lat1)) * Math.cos(rad(lat2)) * Math.sin(dLong/2) * Math.sin(dLong/2);
        var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        var d = R * c;
        var resultado = + d.toFixed(3)
      //  console.log(d.toFixed(3)+" Km");
        return resultado;
        // console.log(d.toFixed(3)+" Km");
        // return d.toFixed(3);//Retorna tres decimales
    }

    btnSelecionarSugerencia(i){
      
      this.name=this.dataSugerencias[i].NOMBRE
      this.homeService.getBuscarMedicamentoTexto(this.name).subscribe(res=>{
        this.dataBuscarProductoR=res[0];
       this.dataMedicamentos = this.dataBuscarProductoR;  
       console.log(this.dataMedicamentos)
        this.name = ""
        this.obtenerPrecioMinimo();
       this.sendArray(this.dataComparacionSeleccionado);
        this.CargarComparacion();
        this.scrollToTop();
        });
  
      }

      sendArray(datos) {
        this._service.setArray(datos);
      }
    
      obtenerPrecioMinimo(){
        var i=0;
          var precioMin=this.dataMedicamentos[i].PRECIO;
          for (i ; i < this.dataMedicamentos.length; i++) {
         
            if (precioMin<this.dataMedicamentos[i].PRECIO) {   
                
            } else{
              precioMin=this.dataMedicamentos[i].PRECIO
            }
          }
    
        var i=0;
          for (i ; i < this.dataMedicamentos.length; i++) {
            if (this.dataMedicamentos[i].PRECIO==precioMin) {   

              this.dataComparacionSeleccionado.push(this.dataMedicamentos[i]) 
            } else{
            
          }     
        }
      }
    scrollToTop() 
    { 
      var elmnt = document.getElementById("myDIV");
          elmnt.scrollLeft = 0;
          elmnt.scrollTop = 0;
        //  this.router.navigate(['comparacion']);
    }
}
