import { Component, Output, EventEmitter } from '@angular/core';
import {NgModule} from '@angular/core';
import {Globals} from '../../Global';
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
 
  @Output() public sidenavToggle = new EventEmitter();
  
  constructor(private globals: Globals ) { }
 

 
  public onToggleSidenav = () => {
    this.sidenavToggle.emit();
  }
 
}