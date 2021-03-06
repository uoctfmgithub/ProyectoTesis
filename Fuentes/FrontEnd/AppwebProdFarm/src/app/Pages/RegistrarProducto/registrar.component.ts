import { Component, OnInit, Inject, ViewChild, ChangeDetectorRef } from '@angular/core';
import {MatTableDataSource} from '@angular/material/table';
import {MatDialog, MatDialogRef, MAT_DIALOG_DATA} from '@angular/material/dialog';
import Swal from 'sweetalert2';
import {RegistrarService} from './Registrar.Service';
import {RegistrarCategoriaService} from '../RegistrarCategoria/Registrar.Service';
import {Medicamento} from './medicamento.model';
import {medicamentoClase} from './medicamento.class';
import { JsonPipe } from '@angular/common';
// import { writeFile } from 'fs';
// import { join } from 'path';
let ELEMENT_DATA: Medicamento[] = [

];


@Component({
  selector: 'app-registrar',
  templateUrl: './registrar.component.html',
  styleUrls: ['./registrar.component.css']
})


export class RegistrarComponent implements OnInit {

  private image:ImageSelected=null;

  applyFilter(filterValue: string) {
    this.dataSource.filter = filterValue.trim().toLowerCase();
  }


  constructor(public dialog: MatDialog,private RegistrarService: RegistrarService) {}
  

  NOMBRE : string;
  DESCRIPCION : string;
  LABORATORIO : string;
  MARCA : string;
  ID_CATEGORIA : number ;
  ID_SUB_CATEGORIA : number;

 

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

  
  displayedColumns: string[] = ['ID_MEDICAMENTO','NOMBRE', 'DESCRIPCION', 'ID_CATEGORIA', 'modificar', 'eliminar'];
  dataSource = new MatTableDataSource(ELEMENT_DATA);


  public CompararFound:any[];
  DataComparar(){

    this.RegistrarService.getMedicamento().subscribe(res=>{
      this.CompararFound=res;
      this.dataSource = new MatTableDataSource();
      this.dataSource.data =  this.CompararFound[0];
      ELEMENT_DATA=this.CompararFound[0];
    });
    
  }
  

  public CompararFoundById:any[];
  DataCompararById(data): void{ 
    this.RegistrarService.getMedicamentoId(data).subscribe(res=>{
      this.CompararFoundById=res;
      this.dataValue = this.CompararFoundById[0];
       this.dialog.open(DialogoModificarMedicamento, {
        width: '60%',
        data: this.dataValue
      }).afterClosed().subscribe(result => {
        if(result){
          if(!data){
            // TodoData.push(result);
          }else{
          this.CompararFoundById[0].ID_MEDICAMENTO = result.ID_MEDICAMENTO;
          this.CompararFoundById[0].NOMBRE = result.NOMBRE;
          this.CompararFoundById[0].DESCRIPCION = result.DESCRIPCION;
          this.CompararFoundById[0].LABORATORIO = result.LABORATORIO;   
          this.CompararFoundById[0].MARCA = result.MARCA;
          this.CompararFoundById[0].ID_CATEGORIA = result.ID_CATEGORIA;
          this.CompararFoundById[0].ID_SUB_CATEGORIA = result.ID_SUB_CATEGORIA;    
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
        this.RegistrarService.deleteMedicamentoId(data).subscribe(res=>{
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

NuevoMedicamento(): void {

 this.dialog.open(DialogoAgregarMedicamento, {
    width: '70%',
  }).afterClosed().subscribe(result => {
    this.refrescar();
  });
}

}

//Para modificar Producto
@Component({
  selector: 'dialog-modificar-medicamento',
  templateUrl: 'DialogoModificarMedicamento.html',
})
export class DialogoModificarMedicamento {

  constructor(private RegistrarService: RegistrarService,private RegistrarCategoriaService: RegistrarCategoriaService,
    public dialogRef: MatDialogRef<DialogoModificarMedicamento>,
    @Inject(MAT_DIALOG_DATA) public data: any) { }

    IdMedicamento:number;
    public noMedi:string;

    public Medicamento = new medicamentoClase
    
  onNoClick(): void {
    this.dialogRef.close();
  }

  ngOnInit() {
    this.ListarCategorias();
    this.ListarSubCategorias();
   }

   public ListaCategoria:any[];
   public ListaSubCategoria:any[];
   public SelectedListaCategoria={ID_CATEGORIA:1,NOMBRE_CATEGORIA:''};
   public SelectedListaSubCategoria= {ID_SUB_CATEGORIA:1,NOMBRE:''};
 
    ListarCategorias(){
       this.RegistrarCategoriaService.getCategorias().subscribe(res=>{
         this.ListaCategoria=res;
         this.ListaCategoria=this.ListaCategoria[0];
       }); 
   }
 
   ListarSubCategorias(){
     this.RegistrarCategoriaService.getSubCategorias().subscribe(res=>{
       this.ListaSubCategoria=res;
       this.ListaSubCategoria=this.ListaSubCategoria[0];
      //  console.log("subcategoria"+ JSON.stringify(this.ListaSubCategoria));
     }); 
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

    ActualizarMedicamento(Medicamento): void{
      let medicamento: Medicamento;
      var ID_MEDICAMENTO:number;
      ID_MEDICAMENTO=this.data[0].ID_MEDICAMENTO;
      medicamento = {
        ID_MEDICAMENTO:this.data[0].ID_MEDICAMENTO,
        NOMBRE:Medicamento[0].NOMBRE,
        DESCRIPCION:Medicamento[0].DESCRIPCION,
        LABORATORIO:Medicamento[0].LABORATORIO,
        MARCA:Medicamento[0].MARCA,
        ID_CATEGORIA:this.SelectedListaCategoria.ID_CATEGORIA,
        ID_SUB_CATEGORIA:this.SelectedListaSubCategoria.ID_SUB_CATEGORIA,
        ARCHIVO_IMAGEN:Medicamento[0].ARCHIVO_IMAGEN,
        FILE:''
    };

    if (!Medicamento[0].NOMBRE || !Medicamento[0].DESCRIPCION || !Medicamento[0].LABORATORIO || 
      !Medicamento[0].MARCA || !this.SelectedListaCategoria.ID_CATEGORIA || !this.SelectedListaSubCategoria.ID_SUB_CATEGORIA) {
      this.mensajeRellenarData();
    } else {
      console.log("actualizar " + JSON.stringify(medicamento));
      this.RegistrarService.updateMedicamento(ID_MEDICAMENTO,medicamento).subscribe(res=>{
        this.mensaje(); 
        this.onNoClick();
      });
    }
  }
}

//Para registrar producto
@Component({
  selector: 'dialog-agregar-medicamento',
  templateUrl: 'DialogoAgregarMedicamento.html',
})
export class DialogoAgregarMedicamento {
  private image:ImageSelected=null;
  constructor(private RegistrarService: RegistrarService,private RegistrarCategoriaService: RegistrarCategoriaService,
    public dialogRefAgregar: MatDialogRef<DialogoAgregarMedicamento>,
    @Inject(MAT_DIALOG_DATA) public data: any,private changeDetectorRefs: ChangeDetectorRef) { }

  NOMBRE : string;
  DESCRIPCION : string;
  LABORATORIO : string;
  MARCA :string;

  ngOnInit() {
   this.ListarCategorias();
   this.ListarSubCategorias();
  }

  public ListaCategoria:any[];
  public ListaSubCategoria:any[];
  public SelectedListaCategoria={ID_CATEGORIA:1,NOMBRE_CATEGORIA:''};
  public SelectedListaSubCategoria= {ID_SUB_CATEGORIA:1,NOMBRE:''};

   ListarCategorias(){
      this.RegistrarCategoriaService.getCategorias().subscribe(res=>{
        this.ListaCategoria=res;
        this.ListaCategoria=this.ListaCategoria[0];
      }); 
  }

  ListarSubCategorias(){
    this.RegistrarCategoriaService.getSubCategorias().subscribe(res=>{
      this.ListaSubCategoria=res;
      this.ListaSubCategoria=this.ListaSubCategoria[0];
      // console.log("subcategoria"+ JSON.stringify(this.ListaSubCategoria));
    }); 
  }

  onUploadFinish(event) {
    // console.log(event);
    this.image=new ImageSelected;
    this.image.image=event.src;
    this.image.name=event.file.name;
    // console.log(JSON.stringify(this.image))
    // console.log(JSON.stringify(this.image))
   }

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

  InsertarMedicamento(){

    try {
      let medicamento: Medicamento;
      medicamento = {
        ID_MEDICAMENTO:0,
        NOMBRE: this.NOMBRE,
        DESCRIPCION:this.DESCRIPCION,
        LABORATORIO:this.LABORATORIO,
        MARCA:this.MARCA,
        ID_CATEGORIA:this.SelectedListaCategoria.ID_CATEGORIA,
        ID_SUB_CATEGORIA:this.SelectedListaSubCategoria.ID_SUB_CATEGORIA,      
        ARCHIVO_IMAGEN:this.image.name,
        FILE:this.image.image,
    };

    if (!this.NOMBRE || !this.DESCRIPCION || !this.LABORATORIO 
      || !this.MARCA || !this.SelectedListaCategoria.ID_CATEGORIA || !this.SelectedListaSubCategoria.ID_SUB_CATEGORIA) {
        this.mensajeRellenarData();
    } else{
      
      this.RegistrarService.postMedicamento(medicamento).subscribe(res=>{
        // writeFile('../')

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

 class ImageSelected {
  public name: String;
  public image: String;

}


