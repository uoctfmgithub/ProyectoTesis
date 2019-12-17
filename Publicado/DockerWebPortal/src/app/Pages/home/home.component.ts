import { Component, OnInit } from '@angular/core';
import {homeService} from './home.Service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})



export class HomeComponent implements OnInit {
  data:string;

  public dataBuscarProducto:any[];
  public dataBuscarProductoR:any[];
 
name:string;


  
  constructor(private homeService: homeService) {}

  
  
  ruta_imagen = '../../../assets/imagenes_producto/';
  keyword = 'NOMBRE_PRODUCTO';
  states = this.dataBuscarProducto;
  fetchData = this.dataBuscarProductoR;

  dataByName(){
    
    if (this.data = null) {
      this.data = 'null'
    } 

    this.homeService.getBuscarMedicamentoTexto(this.data).subscribe(res=>{
      this.dataBuscarProducto=res[0];
      // console.log(JSON.stringify(this.dataBuscarProducto))
      this.states = this.dataBuscarProducto;
    });
  }

  ngOnInit() {
    this.dataByName();
  }

  resultado(){
    console.log("Hola");
    // console.log("Hola")
    if (this.name == "") {
      this.name = "null"
    } 
    this.homeService.getBuscarMedicamentoTexto(this.name).subscribe(res=>{
      this.dataBuscarProductoR=res[0];
      // console.log(JSON.stringify(this.dataBuscarProductoR))
      this.fetchData = this.dataBuscarProductoR;
      this.name = ""
    });

  }

}