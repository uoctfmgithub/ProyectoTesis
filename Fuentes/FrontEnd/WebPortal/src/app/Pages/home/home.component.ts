import { Component, OnInit,ViewChild } from '@angular/core';
import {homeService} from './home.Service';
import { Router } from '@angular/router';
import {ServiceService} from './ServiciosEnvioData/service.service';
import {ComparacionModelo} from '../home/ComparacionMedicamento/comparacionPrecios.modelo';
// import {ComparacionComponent} from './ComparacionMedicamento/comparacion.medicamento';


@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})



export class HomeComponent implements OnInit {
  data:string;

  public dataBuscarProducto:any[];
  public dataBuscarProductoR:any[];

  public mostrar=false;

  public dataComparacionSeleccionado: Array<ComparacionModelo> = [];
  
  
  resultadoTexto:String;
  mensajeNoFound:String;
  
  name:string;

  // @ViewChild('child2') childTwo:ComparacionComponent;

  // @ViewChild(ComparacionComponent, {static: false}) Component


  
  constructor(private homeService: homeService,private router: Router,private _service: ServiceService) {}

  
  
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
    this.dataByName();
  }

  public selected(value:any):void {
    console.log('Selected value is: ', value['NOMBRE']);
    this.resultadoSeleccionado(value['NOMBRE']);
  }

  resultadoEnter(){
    this.mostrar=true
    console.log(this.name)
    if (!this.name) {
      alert("inserte un dato")
    } else{
      this.resultadoTexto=this.name
      this.homeService.getBuscarMedicamentoTexto(this.name).subscribe(res=>{
        this.dataBuscarProductoR=res[0];
        this.dataMedicamentos = this.dataBuscarProductoR;
        console.log("DATA ENTER"+JSON.stringify(this.dataMedicamentos))
        this.name = ""
      });
    }
  }

  resultadoSeleccionado(nombre){
    console.log(nombre)
      this.homeService.getBuscarMedicamentoTexto(nombre).subscribe(res=>{
        this.dataBuscarProductoR=res[0];
        this.dataMedicamentos = this.dataBuscarProductoR;
        console.log("DATA SELECCIONADO"+JSON.stringify(this.dataMedicamentos))
        this.name = ""
      });

  }
  
  // VERDADERO
//   btnClick= function () {
//     this.sendArray(this.dataMedicamentos);
//     this.router.navigateByUrl('/comparacion');
// };

  btnClick(DATA){
    // alert(JSON.stringify(DATA))

    var i=0;
    for (i ; i < this.dataMedicamentos.length; i++) {
      if (this.dataMedicamentos[i].PRECIO==DATA) {   
        // delete this.dataFletes[i]
        this.dataComparacionSeleccionado.push(this.dataMedicamentos[i]) 
      } else{
        
      }
}
// console.log("Esta es la data seleccionada Mary"+JSON.stringify(this.dataComparacionSeleccionado))

      this.sendArray(this.dataComparacionSeleccionado);
    this.router.navigateByUrl('/comparacion');
  }


  sendArray(datos) {
    this._service.setArray(datos);
  }

}