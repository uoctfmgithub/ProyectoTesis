import { Component, OnInit , Inject, ViewChild, ChangeDetectorRef} from '@angular/core';
import {MatTableDataSource} from '@angular/material/table';
import {MatDialog, MatDialogRef, MAT_DIALOG_DATA} from '@angular/material/dialog';

import Swal from 'sweetalert2';
import {RegistrarService} from './Registrar.Service';
import {Categoria} from './categoria.model';
import {CategoriaClass} from './categoria.class';
import {FormControl, Validators} from '@angular/forms';

let ELEMENT_DATA: Categoria[] = [

];

@Component({
  selector: 'app-registrarcategoria',
  templateUrl: './registrarcategoria.component.html',
  styleUrls: ['./registrarcategoria.component.css']
})


export class RegistrarcategoriaComponent implements OnInit {
  displayedColumns: string[] = ['ID_CATEGORIA', 'NOMBRE_CATEGORIA' , 'modificar', 'eliminar'];
  dataSource = new MatTableDataSource(ELEMENT_DATA);

  applyFilter(filterValue: string) {
    this.dataSource.filter = filterValue.trim().toLowerCase();
  }


  constructor(public dialog: MatDialog,private RegistrarService: RegistrarService) {}

  NOMBRE_CATEGORIA : string;


  dataLength: any= ELEMENT_DATA.length;
  newDataID: any;
  dataValue:any;



  ngOnInit() {
    this.refrescar();
  }

  refrescar(){
    this.DataComparar();
  }

  mensaje(){
    Swal.fire ('','Se elimino correctamente','success')
  }

  public CompararFound:any[];
  DataComparar(){

    this.RegistrarService.getCategorias().subscribe(res=>{
      this.CompararFound=res;
      this.dataSource = new MatTableDataSource();
      this.dataSource.data =  this.CompararFound[0];
      ELEMENT_DATA=this.CompararFound[0];
    });
    
  }
  

  public CompararFoundById:any[];
  DataCompararById(data): void{ 
    this.RegistrarService.getCategoriasId(data).subscribe(res=>{
      this.CompararFoundById=res;
      this.dataValue = this.CompararFoundById[0];
       this.dialog.open(DialogoModificarCategoria, {
        width: '60%',
        data: this.dataValue
      }).afterClosed().subscribe(result => {
        if(result){
          if(!data){
            // TodoData.push(result);
          }else{
          this.CompararFoundById[0].ID_CATEGORIA = result.ID_CATEGORIA;
          this.CompararFoundById[0].NOMBRE_CATEGORIA = result.NOMBRE_CATEGORIA;
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
        this.RegistrarService.deleteCategoriaId(data).subscribe(res=>{
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

NuevaCategoria(): void {

 this.dialog.open(DialogoAgregarCategoria, {
    width: '70%',
  }).afterClosed().subscribe(result => {
    this.refrescar();
  });
}

}

//Para modificar Categoria
@Component({
  selector: 'dialog-modificar-categoria',
  templateUrl: 'DialogoModificarCategoria.html',
})
export class DialogoModificarCategoria {

  constructor(private RegistrarService: RegistrarService,
    public dialogRef: MatDialogRef<DialogoModificarCategoria>,
    @Inject(MAT_DIALOG_DATA) public data: any) { }

    IdCategoria:number;
    public noCate:string;

    public Categoria = new CategoriaClass
    
  onNoClick(): void {
    this.dialogRef.close();
  }


  mensaje(){
    Swal.fire ('','Se Actualizo correctamente','success')
  }
  mensajeRellenarData(){
    Swal.fire({
      type: 'error',
      title: 'Ups ...',
      text: 'Verifique los datos'
    })
  }

    ActualizarCategoria(Categoria): void{
      let categoria: Categoria;
      var ID_CATEGORIA:number;
      ID_CATEGORIA=this.data[0].ID_CATEGORIA;
      categoria = {
        ID_CATEGORIA:this.data[0].ID_CATEGORIA,
        NOMBRE_CATEGORIA:Categoria[0].NOMBRE_CATEGORIA,
    };

    if (!Categoria[0].NOMBRE_CATEGORIA ) {
      this.mensajeRellenarData();
    } else {
      this.RegistrarService.updateCategoria(ID_CATEGORIA,categoria).subscribe(res=>{
        this.mensaje(); 
        this.onNoClick();
      });
    }
  }
}

//Para registrar producto
@Component({
  selector: 'dialog-agregar-categoria',
  templateUrl: 'DialogoAgregarCategoria.html',
})
export class DialogoAgregarCategoria {
 
  constructor(private RegistrarService: RegistrarService,
    public dialogRefAgregar: MatDialogRef<DialogoAgregarCategoria>,
    @Inject(MAT_DIALOG_DATA) public data: any,private changeDetectorRefs: ChangeDetectorRef) { }

  NOMBRE_CATEGORIA : string;

  CloseDialog(): void {
    this.dialogRefAgregar.close();
  }

  mensaje(){
    Swal.fire ('','Se grabo correctamente','success')
  }

  mensajeRellenarData(){
    Swal.fire({
      type: 'error',
      title: 'Ups ...',
      text: 'Verifique los datos'
    })
  }

  InsertarCategoria(){

    try {
      let categoria: Categoria;
      categoria = {
        ID_CATEGORIA:0,
        NOMBRE_CATEGORIA: this.NOMBRE_CATEGORIA,
    };

    if (!this.NOMBRE_CATEGORIA ) {
        this.mensajeRellenarData();
    } else{
      
      this.RegistrarService.postCategoria(categoria).subscribe(res=>{
        let array=res;
         console.log("array : "+ JSON.stringify(array));
        this.mensaje();
        this.CloseDialog();
      });

    }

    } catch (error) {
      console.log(error);
    }
    
  }
}