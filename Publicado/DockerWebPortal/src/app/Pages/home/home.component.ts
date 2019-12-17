import { Component, OnInit } from '@angular/core';
import {homeService} from './home.Service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})



export class HomeComponent implements OnInit {
  data:string;

  constructor(private homeService: homeService) {}

  public dataBuscarProducto:any[];
  
  ruta_imagen = '../../../assets/imagenes_producto/';
  keyword = 'NOMBRE_PRODUCTO';
  states = this.dataBuscarProducto;

  dataByName(){
    if (this.data = null) {
      this.data = 'null'
    } 
    this.homeService.getBuscarMedicamentoTexto(this.data).subscribe(res=>{
      this.dataBuscarProducto=res[0];
      console.log(JSON.stringify(this.dataBuscarProducto))
      this.states = this.dataBuscarProducto;
    });
  }

  ngOnInit() {
    this.dataByName();
  }

}