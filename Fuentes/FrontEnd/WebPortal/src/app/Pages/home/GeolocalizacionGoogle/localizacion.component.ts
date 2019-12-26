import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';



@Component({
  selector: 'app-localizacion',
  templateUrl: './localizacion.component.html',
  styleUrls: ['./localizacion.component.css']
})



export class LocalizacionComponent implements OnInit {
  title: string = 'AGM project';
  latitude: number;
  longitude: number;
  zoom:number;
  address: string;

  lat1: number= -12.0496128;
  lon1: number=-76.9753088;
  lat2: number=-8.406691;
  lon2: number=-74.618114;


  // @ViewChild('search', {static: false}) public searchElementRef: ElementRef;

    ngOnInit() {
      this.setCurrentLocation();
      this.getKilometros(this.lat1,this.lon1,this.lat2,this.lon2);
      }
      
      private setCurrentLocation() {
        if ('geolocation' in navigator) {
          navigator.geolocation.getCurrentPosition((position) => {
            this.latitude = position.coords.latitude;
            this.longitude = position.coords.longitude;
            this.zoom = 15;
          });
        }
      }
  

    //   getKilometros = function(lat1,lon1,lat2,lon2)
    //   {
    //   var rad = function(x) {return x*Math.PI/180;}
    //  var R = 6378.137; //Radio de la tierra en km
    //   var dLat = rad( lat2 - lat1 );
    //   var dLong = rad( lon2 - lon1 );
    //  var a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(rad(lat1)) * Math.cos(rad(lat2)) * Math.sin(dLong/2) * Math.sin(dLong/2);
    //   var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    //   var d = R * c;
    //   return d.toFixed(3);//Retorna tres decimales
    //   var ce=d.toFixed(3);
    //   console.log(ce);
    //   }

    getKilometros(lat1,lon1,lat2,lon2)
      {
      var rad = function(x) {return x*Math.PI/180;}
     var R = 6378.137; //Radio de la tierra en km
      var dLat = rad( lat2 - lat1 );
      var dLong = rad( lon2 - lon1 );
     var a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(rad(lat1)) * Math.cos(rad(lat2)) * Math.sin(dLong/2) * Math.sin(dLong/2);
      var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
      var d = R * c;
      console.log(d.toFixed(3)+" Km");
      // return d.toFixed(3);//Retorna tres decimales
      }

    }