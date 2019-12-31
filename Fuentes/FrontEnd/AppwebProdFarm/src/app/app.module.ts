//core
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { AppComponent } from './app.component';
//rounting
import { RoutingModule } from './routing/routing.module';
//Material Module
import { MaterialModule } from './material.module';
import { LayoutModule } from '@angular/cdk/layout';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { FlexLayoutModule } from '@angular/flex-layout';
import { ImageUploadModule}  from 'angular2-image-upload';
//Http
import { HttpClientModule } from '@angular/common/http';
//componentes
import { HomeComponent } from './Pages/home/home.component';
import { RegistrarComponent,DialogoAgregarMedicamento, DialogoModificarMedicamento} from './Pages/RegistrarProducto/registrar.component';

import { RegistrarfarmaciaComponent,DialogModificarFarmacia,DialogAgregarFarmacia} from './Pages/RegistrarFarmacia/registrarfarmacia.component';

import { RegistrarcategoriaComponent,DialogoModificarCategoria,DialogoAgregarCategoria} from './Pages/RegistrarCategoria/registrarcategoria.component';

import { HeaderComponent } from './Share/navigation/header/header.component';
import { SidenavListComponent } from './Share/navigation/sidenav-list/sidenav-list.component';
import { LayoutComponent } from './Share/layout/layout.component';
//variable Global
import {Globals} from './Share/Global';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    RegistrarComponent,
    DialogoModificarMedicamento,
    DialogoAgregarMedicamento,
    DialogModificarFarmacia,
    DialogAgregarFarmacia,
    RegistrarfarmaciaComponent,
    RegistrarcategoriaComponent,
    DialogoAgregarCategoria,
    DialogoModificarCategoria,
    HeaderComponent,
    SidenavListComponent,
    LayoutComponent,
  ],
  imports: [
    BrowserModule,
    RoutingModule,
    FormsModule,
    MaterialModule,
    BrowserAnimationsModule,
    LayoutModule,
    FlexLayoutModule,  
    HttpClientModule,
    ImageUploadModule.forRoot()
  ],
  entryComponents: [
    DialogoModificarMedicamento,
    DialogoAgregarMedicamento,
    DialogModificarFarmacia,
    DialogAgregarFarmacia,
    DialogoAgregarCategoria,
    DialogoModificarCategoria
  ],
  providers: [Globals],
  bootstrap: [AppComponent]
})
export class AppModule { }
