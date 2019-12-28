import { Component, OnInit,ViewChild } from '@angular/core';
import {homeService} from './home.Service';
import { Router } from '@angular/router';
import {ServiceService} from './ServiciosEnvioData/service.service';
import {ComparacionModelo} from '../home/ComparacionMedicamento/comparacionPrecios.modelo';
// import {ComparacionComponent} from './ComparacionMedicamento/comparacion.medicamento';
import {NgModule} from '@angular/core';
import {Globals} from '../../Share/Global';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
@NgModule({
  providers: [Globals ], // this depends on situation, see below
  imports: [
  
  ]
})


export class HomeComponent implements OnInit {
  data:string;

  public dataBuscarProducto:any[];
  public dataBuscarProductoR:any[];

  public mostrar=false;

  // public ocultar = false;

  public dataComparacionSeleccionado: Array<ComparacionModelo> = [];
  
  
  resultadoTexto:String;
  mensajeNoFound:String;
  
  name:string;

  // @ViewChild('child2') childTwo:ComparacionComponent;

  // @ViewChild(ComparacionComponent, {static: false}) Component


  
  constructor(private homeService: homeService,private router: Router,private _service: ServiceService, private globals: Globals ) {}

  
  
  ruta_imagen = '../../../assets/imagenes_producto/';
  keyword = 'NOMBRE';
  states = this.dataBuscarProducto;
  dataMedicamentos = this.dataBuscarProductoR;


  dataByName(){
    
    // if (this.data = null) {
    //   this.data = 'null'
    // } 

    this.homeService.getBuscarMedicamento().subscribe(res=>{
        this.dataBuscarProducto=res[0];
      // console.log(JSON.stringify(this.dataBuscarProducto))
      this.states = this.dataBuscarProducto;
    });
  }

  ngOnInit() {

    this.globals.ocultar = false;
    this.dataByName();
  }

  public selected(value:any):void {
    // console.log('Selected value is: ', value['NOMBRE']);
    this.resultadoSeleccionado(value['NOMBRE']);
  }

  resultadoEnter(){
    this.mostrar=true
    // console.log(this.name)
    if (!this.name) {
      alert("inserte un dato")
    } else{
      this.resultadoTexto=this.name
      this.homeService.getBuscarMedicamentoTexto(this.name).subscribe(res=>{
        this.dataBuscarProductoR=res[0];
        this.dataMedicamentos = this.dataBuscarProductoR;
        // console.log("DATA ENTER"+JSON.stringify(this.dataMedicamentos))
        this.name = ""
      });
    }
  }

  resultadoSeleccionado(nombre){
    // console.log(nombre)
      this.homeService.getBuscarMedicamentoTexto(nombre).subscribe(res=>{
        this.dataBuscarProductoR=res[0];
        this.dataMedicamentos = this.dataBuscarProductoR;
        // console.log("DATA SELECCIONADO"+JSON.stringify(this.dataMedicamentos))
        this.name = ""
      });
  }
  

  



  // VERDADERO
//   btnClick= function () {
//     this.sendArray(this.dataMedicamentos);
//     this.router.navigateByUrl('/comparacion');
// };

  btnClick(i){
    this.name=this.dataMedicamentos[i].NOMBRE_PRODUCTO
    this.homeService.getBuscarMedicamentoTexto(this.name).subscribe(res=>{
      this.dataBuscarProductoR=res[0];
      this.dataMedicamentos = this.dataBuscarProductoR;
      this.name = ""
      this.obtenerPrecioMinimo();
      this.sendArray(this.dataComparacionSeleccionado);
      this.router.navigateByUrl('/comparacion');
    });
}
  sendArray(datos) {
    this._service.setArray(datos);
  }

  obtenerPrecioMinimo(){
    var i=0;
      var precioMin=this.dataMedicamentos[i].PRECIO;
      for (i ; i < this.dataMedicamentos.length; i++) {
        // console.log('Precio : '+this.dataMedicamentos[i].PRECIO + 'precio Min. : ' + precioMin)
        if (precioMin<this.dataMedicamentos[i].PRECIO) {   
          // delete this.dataFletes[i]
         // this.dataComparacionSeleccionado.push(this.dataMedicamentos[i])         
        } else{
          precioMin=this.dataMedicamentos[i].PRECIO
        }
      }

    var i=0;
      for (i ; i < this.dataMedicamentos.length; i++) {
        if (this.dataMedicamentos[i].PRECIO==precioMin) {   
          // delete this.dataFletes[i]
          this.dataComparacionSeleccionado.push(this.dataMedicamentos[i]) 
        } else{
        
      }     
    }
  }
}