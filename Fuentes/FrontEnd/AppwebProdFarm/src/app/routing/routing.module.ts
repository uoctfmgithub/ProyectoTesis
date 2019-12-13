import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Routes, RouterModule } from '@angular/router';
import { HomeComponent } from '../Pages/home/home.component';
import { RegistrarComponent } from '../Pages/RegistrarProducto/registrar.component';
import { RegistrarfarmaciaComponent } from '../Pages/RegistrarFarmacia/registrarfarmacia.component';
import { RegistrarcategoriaComponent } from '../Pages/RegistrarCategoria/registrarcategoria.component';

const routes: Routes = [
  
  { path: '', redirectTo: '/home', pathMatch: 'full' },
  { path: 'home', component: HomeComponent},
  { path: 'registrar', component: RegistrarComponent},
  { path: 'registrarfarmacia', component: RegistrarfarmaciaComponent},
  { path: 'registrarcategoria', component: RegistrarcategoriaComponent}
];
 
@NgModule({
  imports: [  
    CommonModule,
    RouterModule.forRoot(routes)
  ],  
  exports: [
    RouterModule
  ],
  declarations: []
})
export class RoutingModule { }
export const routingComponents=[
  HomeComponent,
  RegistrarComponent,
  RegistrarfarmaciaComponent,
  RegistrarcategoriaComponent
]