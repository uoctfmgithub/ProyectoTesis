import { Injectable} from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import { Categoria } from './categoria.model';
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
export class RegistrarCategoriaService{
    //configUrl='http://localhost:3000/farmacias';
    constructor(private http: HttpClient, private globals : Globals){ }
    configUrl=this.globals.urlService + 'categorias';
    configUrl2=this.globals.urlService + 'subcategorias';

    getCategorias(){
        return this.http.get<any>(this.configUrl,httpOptions);
      }

      getCategoriasId(id){
        return this.http.get<any>(this.configUrl+"/"+id,httpOptions);
      }
      deleteCategoriaId(id){
        return this.http.delete<any>(this.configUrl+"/"+id,httpOptions);
      }
      postCategoria(Categoria: Categoria){
        let body = JSON.stringify(Categoria);
        console.log("body :"+body);

        return this.http.post<any>(this.configUrl,body,httpOptions);
      }

      updateCategoria(id,categoria: Categoria){
        let body = JSON.stringify(categoria);
        console.log("body :"+body);

        return this.http.patch<any>(this.configUrl+"/"+id,body,httpOptions);
      }

      getSubCategorias(){
        return this.http.get<any>(this.configUrl2,httpOptions);
      }

    }