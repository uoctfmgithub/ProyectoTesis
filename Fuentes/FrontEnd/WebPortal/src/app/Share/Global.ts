import { Injectable } from "@angular/core";

@Injectable()
export class Globals {
  token : string = "";
  hidetoolbar: boolean=true;
  idUsuario: string="";
  Usuario: string="";
  urlService: string = "https://apirestfulfarmacias.azurewebsites.net/";
  // urlService: string = "http://localhost:3000/";
  ocultar: boolean=false;
}