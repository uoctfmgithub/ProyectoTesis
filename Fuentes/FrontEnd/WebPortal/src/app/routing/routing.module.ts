import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Routes, RouterModule } from '@angular/router';
import { HomeComponent } from '../Pages/home/home.component';
import {ComparacionComponent} from '../Pages/home/ComparacionMedicamento/comparacion.medicamento'
import {ServiceService} from '../Pages/home/ServiciosEnvioData/service.service'

const routes: Routes = [
  
  { path: '', redirectTo: '/home', pathMatch: 'full' },
  { path: 'home', component: HomeComponent},
  { path: 'comparacion', component: ComparacionComponent}
];
 
@NgModule({
  imports: [  
    CommonModule,
    RouterModule.forRoot(routes)
  ],  
  exports: [
    RouterModule
  ],
  declarations: [],
  providers:[ServiceService]
})
export class RoutingModule { }
export const routingComponents=[
  HomeComponent,
  ComparacionComponent,
]