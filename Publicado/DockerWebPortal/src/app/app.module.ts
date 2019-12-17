//core
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { AppComponent } from './app.component';
import {AutocompleteLibModule} from 'angular-ng-autocomplete';
//rounting
import { RoutingModule } from './routing/routing.module';
//Material Module
import { MaterialModule } from './material.module';
import { LayoutModule } from '@angular/cdk/layout';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { FlexLayoutModule } from '@angular/flex-layout';
//Http
import { HttpClientModule } from '@angular/common/http';
//componentes
import { HomeComponent } from './Pages/home/home.component';

import { HeaderComponent } from './Share/navigation/header/header.component';
import { SidenavListComponent } from './Share/navigation/sidenav-list/sidenav-list.component';
import { LayoutComponent } from './Share/layout/layout.component';

//variable Global
import {Globals} from './Share/Global';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
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
    AutocompleteLibModule
  ],
  entryComponents: [
 
  ],
  providers: [Globals],
  bootstrap: [AppComponent]
})
export class AppModule { }