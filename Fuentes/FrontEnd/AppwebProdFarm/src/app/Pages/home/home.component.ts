import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})



export class HomeComponent implements OnInit {


  fetchData = [{"title":"IBUPROFENO","description":"Ibuprofeno 600mg","ruta":"../../../assets/imagenes_producto/ibuprofeno.png"},
  {"title":"IBUPROFENO","description":"Ibuprofeno 200mg","ruta":"../../../assets/imagenes_producto/ibuprofeno200.png"},
  {"title":"IBUPROFENO","description":"Ibuprofeno 200mg","ruta":"../../../assets/imagenes_producto/ibuprofenopirac.png"},
  {"title":"IBUPROFENO","description":"Ibuprofeno 200mg","ruta":"../../../assets/imagenes_producto/ibuprofeno800.png"},
  {"title":"IBUPROFENO","description":"Ibuprofeno 300mg","ruta":"../../../assets/imagenes_producto/ibuprofeno400.png"},
  {"title":"IBUPROFENO","description":"Ibuprofeno 400mg","ruta":"../../../assets/imagenes_producto/ibuprofeno5.png"}];


  constructor() { 
    
  }
 public mostrar = false;

  ngOnInit() {

  }

  resultado(){
  // this.mostrar=true;
  console.log("Hola");
  if(this.mostrar==false){
    this.mostrar = true;
  }else{
    this.mostrar = false;
  }

  }

}

