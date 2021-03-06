import { Injectable} from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import {NgModule} from '@angular/core';
import {Globals} from '../../Share/Global';
const httpOptions = {
  headers: new HttpHeaders({
  'content-Type': 'application/json'
})
};
@NgModule({
  providers: [Globals ], // this depends on situation, see below
  imports: [
  
  ]
})
@Injectable({
    providedIn: 'root'
})
export class homeService{
    //configUrl='http://localhost:3000/farmacias';
    constructor(private http: HttpClient, private globals : Globals){ }
    configUrl=this.globals.urlService + 'medicamentos';

    getBuscarMedicamento(){
      return this.http.get<any>(this.configUrl,httpOptions);
    }

      getBuscarMedicamentoTexto(texto){
        return this.http.get<any>(this.configUrl+"/buscar/"+texto,httpOptions);
      }

      getComparacionPrecio(texto){
        return this.http.get<any>(this.configUrl+"/comparar/"+texto,httpOptions);
      }

      getSugerencias(texto){
        return this.http.get<any>(this.configUrl+"/sugerencias/"+texto,httpOptions);
      }

    }