import { Component, Output, EventEmitter } from '@angular/core';
import {NgModule} from '@angular/core';
import {Globals} from '../../Global';
import {homeService} from 'src/app/Pages/home/home.Service';
import { Router } from '@angular/router';
import {ServiceService} from '../../../Pages/home/ServiciosEnvioData/service.service';



@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
@NgModule({
  providers: [Globals ], // this depends on situation, see below
  imports: [
  
  ]
})
export class HeaderComponent {
  data:string;

  public dataBuscarProducto:any[];
  public dataBuscarProductoR:any[];

  name:string;

  @Output() public sidenavToggle = new EventEmitter();
  
  constructor(private homeService: homeService,private router: Router,private _service: ServiceService , public globals: Globals ) { }
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
    // this.dataByName();
  }
  
// public flagbusqueda = false;
 
  public onToggleSidenav = () => {
    this.sidenavToggle.emit();
  }
  activarbusqueda(){
    // if (this.flagbusqueda) {
    //   this.flagbusqueda = false;
    // }else{
    //   this.flagbusqueda = true;
    // }

    this.router.navigateByUrl('/home');
  }

}