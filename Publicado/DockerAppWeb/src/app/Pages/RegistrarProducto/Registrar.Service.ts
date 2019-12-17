import { Injectable} from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import { Medicamento } from './medicamento.model';
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
export class RegistrarService{
   
    constructor(private http: HttpClient,private globals : Globals){ }
    configUrl=this.globals.urlService +'medicamentos';
      getMedicamento(){
        return this.http.get<any>(this.configUrl,httpOptions);
      }

      getMedicamentoId(id){
        return this.http.get<any>(this.configUrl+"/"+id,httpOptions);
      }
      deleteMedicamentoId(id){

        return this.http.delete<any>(this.configUrl+"/"+id,httpOptions);
      }
      postMedicamento(medicamento: Medicamento){
        let body = JSON.stringify(medicamento);
        return this.http.post<any>(this.configUrl,body,httpOptions);
      }

      updateMedicamento(id,medicamento: Medicamento){
        let body = JSON.stringify(medicamento);
        return this.http.patch<any>(this.configUrl+"/"+id,body,httpOptions);
      }
    }