import { Component, OnInit, Inject, ViewChild } from '@angular/core';
import {MatTableDataSource} from '@angular/material/table';
import {MatDialog, MatDialogRef, MAT_DIALOG_DATA} from '@angular/material/dialog';

import Swal from 'sweetalert2';
import {RegistrarService} from './Registrar.Service';
import {Farmacia} from './farmacia.model';
import {FarmaciaClass} from './farmacia.class';
import {FormControl, Validators} from '@angular/forms';

let ELEMENT_DATA: Farmacia[] = [

];

@Component({
  selector: 'app-registrarfarmacia',
  templateUrl: './registrarfarmacia.component.html',
  styleUrls: ['./registrarfarmacia.component.css']
})


export class RegistrarfarmaciaComponent implements OnInit {
    displayedColumns: string[] = ['ID_FARMACIA', 'NOMBRE' , 'DIRECCION', 'PROVINCIA' , 'CORREO' ,'modificar', 'eliminar'];
    dataSource = new MatTableDataSource(ELEMENT_DATA);
  
    applyFilter(filterValue: string) {
      this.dataSource.filter = filterValue.trim().toLowerCase();
    }
  
  
    constructor(public dialog: MatDialog,private RegistrarService: RegistrarService) {}
    
    dataLength: any= ELEMENT_DATA.length;
    newDataID: any;
    dataValue:any;
  

    ngOnInit() {
      this.DataFarmacia();
    }

    refrescar(){
      this.DataFarmacia();
    }

    //GET
    public CompararFound:any[];
    DataFarmacia(){
  
      this.RegistrarService.getFarmacias().subscribe(res=>{
        this.CompararFound=res;
        this.dataSource = new MatTableDataSource();
        this.dataSource.data =  this.CompararFound[0];
        ELEMENT_DATA=this.CompararFound[0];
        
  
      });
      
    }
    // GET POR ID
    public CompararFoundById:any[];
    DataCompararById(data): void{
      this.RegistrarService.getFarmaciasId(data).subscribe(res=>{
        this.CompararFoundById=res;
        this.dataValue = this.CompararFoundById[0];
        this.dialog.open(DialogModificarFarmacia, {
          width: '70%',
          data: this.dataValue
        }).afterClosed().subscribe(result => {
          if(result){
            if(!data){
              // TodoData.push(result);
            }else{
            this.CompararFoundById[0].ID_FARMACIA = result.ID_FARMACIA;
            this.CompararFoundById[0].NOMBRE = result.NOMBRE;
            this.CompararFoundById[0].DIRECCION = result.DIRECCION;
            this.CompararFoundById[0].TELEFONO = result.TELEFONO;   
            this.CompararFoundById[0].MOVIL = result.MOVIL;
            this.CompararFoundById[0].LATITUD = result.LATITUD;   
            this.CompararFoundById[0].LONGITUD = result.LONGITUD;
            this.CompararFoundById[0].PROVINCIA = result.PROVINCIA;
            this.CompararFoundById[0].CORREO = result.CORREO;
            this.CompararFoundById[0].ID_PAIS = result.ID_PAIS;
            this.CompararFoundById[0].CODIGO_POSTAL = result.CODIGO_POSTAL;   
            }
          }
          this.refrescar();
        });
        
      });
      
    }

    DataCompararDeleteById(data): void{

      Swal.fire({
        title: '¿Estás seguro?',
        text: "¡No podrás revertir esto!",
        showCancelButton: true,
        type: 'warning',
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Sí, bórralo!'
      }).then((result) => {
        if (result.value) {
          this.RegistrarService.deleteFarmaciaId(data).subscribe(res=>{
            this.refrescar();
        });
          Swal.fire(
            '¡Eliminado!',
            'Su producto ha sido eliminado.',
            'success'
          )
        }
      })
  
      
  
  }
    NuevaFarmacia(): void {

      this.dialog.open(DialogAgregarFarmacia, {
         width: '65%',
       }).afterClosed().subscribe(result => {
         this.refrescar();
       });
     }
}

//Modificar Farmacia

@Component({
  selector: 'dialog-modificar-farmacia',
  templateUrl: 'DialogoModificarFarmacia.html',
})
export class DialogModificarFarmacia {

  constructor(private RegistrarService: RegistrarService,
    public dialogRef: MatDialogRef<DialogModificarFarmacia>,
    @Inject(MAT_DIALOG_DATA) public data: any) { }

    public Farmacia = new FarmaciaClass
    
  onNoClick(): void {
    this.dialogRef.close();
  }

  mensajeExito(){
    Swal.fire ('','Se Actualizo correctamente','success')
  }

  mensajeRellenarData(){
    Swal.fire({
      type: 'error',
      title: 'Ups ...',
      text: 'Verifique los datos'
    })
  }

  

    ActualizarFarmacia(Farmacia): void{
      let farmacia: Farmacia;
      var ID_FARMACIA:number;
      ID_FARMACIA=this.data[0].ID_FARMACIA;
      farmacia = {
        ID_FARMACIA:this.data[0].ID_FARMACIA,
        NOMBRE: this.data[0].NOMBRE,
        DIRECCION:this.data[0].DIRECCION,
        TELEFONO:Farmacia[0].TELEFONO,
        MOVIL:Farmacia[0].MOVIL,
        LATITUD:Farmacia[0].LATITUD,
        LONGITUD:Farmacia[0].LONGITUD,
        PROVINCIA:Farmacia[0].PROVINCIA,
        CORREO:Farmacia[0].CORREO,
        ID_PAIS:Farmacia[0].ID_PAIS,
        CODIGO_POSTAL:Farmacia[0].CODIGO_POSTAL,
    };
   
    if (!Farmacia[0].NOMBRE || !Farmacia[0].DIRECCION || !Farmacia[0].LATITUD || 
        !Farmacia[0].LONGITUD || !Farmacia[0].PROVINCIA || !Farmacia[0].ID_PAIS || 
        !Farmacia[0].CODIGO_POSTAL) {
      this.mensajeRellenarData();
    } else {
      this.RegistrarService.updateFarmacia(ID_FARMACIA,farmacia).subscribe(res=>{
        this.mensajeExito(); 
        this.onNoClick();
      });
    }
  

    
    }

}

//Agregar Farmacia
@Component({
  selector: 'dialog-agregar-farmacia',
  templateUrl: 'DialogoAgregarFarmacia.html',
})
export class DialogAgregarFarmacia {

  emailFormControl = new FormControl('', [
    Validators.required,
    Validators.email,
  ]);

  telefonoFormControl = new FormControl('', [
    Validators.required,
    Validators.maxLength(15),
  ]);

  movilFormControl= new FormControl('', [
    Validators.required,
    Validators.maxLength(15),
  ]);

  postalFormControl = new FormControl('', [
    Validators.required,
    Validators.maxLength(10),
  ]);

  nombreFormControl= new FormControl('', [
    Validators.required,
    
  ]);

  direccionFormControl= new FormControl('', [
    Validators.required,
    
  ]);

  latitudFormControl= new FormControl('', [
    Validators.required,
  ]);

  longitudFormControl= new FormControl('', [
    Validators.required,
  ]);

  provinciaFormControl= new FormControl('', [
    Validators.required,
  ]);



  constructor(private RegistrarService: RegistrarService,
    public dialogRef: MatDialogRef<DialogAgregarFarmacia>,
    @Inject(MAT_DIALOG_DATA) public data: any) { }

    NOMBRE : string;
    DIRECCION : string;
    TELEFONO : string;
    MOVIL : string;
    LATITUD : string ;
    LONGITUD: string;
    PROVINCIA: string;
    CORREO: string;
    ID_PAIS: number;
    CODIGO_POSTAL: string;
    


    public Farmacia = new FarmaciaClass
    
  onNoClick(): void {
    this.dialogRef.close();
  }

  mensajeExito(){
    Swal.fire ('','Se Agrego correctamente','success')
  }
  CloseDialog(): void {
    this.dialogRef.close();
  }

  mensajeRellenarData(){
    Swal.fire({
      type: 'error',
      title: 'Ups ...',
      text: 'Verifique los datos'
    })
  }

  InsertarFarmacia(){
    try {
      let farmacia: Farmacia;
      farmacia = {
          ID_FARMACIA:0,
          NOMBRE: this.NOMBRE,
          DIRECCION:this.DIRECCION,
          TELEFONO:this.TELEFONO,
          MOVIL:this.MOVIL,
          LATITUD:this.LATITUD,
          LONGITUD:this.LONGITUD,
          PROVINCIA:this.PROVINCIA,
          CORREO:this.CORREO,
          ID_PAIS:this.ID_PAIS,
          CODIGO_POSTAL:this.CODIGO_POSTAL
      };
  
      if (!this.NOMBRE || !this.DIRECCION || !this.TELEFONO 
        || !this.MOVIL || !this.LATITUD || !this.LONGITUD
        || !this.PROVINCIA || !this.CORREO || !this.ID_PAIS
        || !this.CODIGO_POSTAL) {
          this.mensajeRellenarData();
      } else{
        
        this.RegistrarService.postFarmacia(farmacia).subscribe(res=>{ 
          this.mensajeExito();
          this.CloseDialog();
        });
      }
    } catch (error) {
      
    }
  }
}
 