use dbProdFarm;

-------------------------CREACION-DE-TABLAS---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

create table TB_PAIS(
ID_PAIS int AUTO_INCREMENT,
NOMBRE varchar(50),
FECHA_CREACION datetime,
FECHA_DE_MODIFICACION datetime,
PRIMARY KEY (ID_PAIS)
);



create table TB_FARMACIA(
ID_FARMACIA int AUTO_INCREMENT,
NOMBRE varchar(200),
DIRECCION varchar(300),
TELEFONO varchar(15),
MOVIL varchar(15),
LATITUD varchar(45),
LONGITUD varchar(45),
PROVINCIA varchar(100),
CORREO varchar(100),
ID_PAIS INT,
FOREIGN KEY (ID_PAIS) REFERENCES TB_PAIS(ID_PAIS),
CODIGO_POSTAL varchar(10), 
FECHA_CREACION datetime,
FECHA_DE_MODIFICACION datetime,
PRIMARY KEY (ID_FARMACIA)
);



create table TB_CATEGORIA(
ID_CATEGORIA int AUTO_INCREMENT,
NOMBRE_CATEGORIA varchar(200),
FECHA_CREACION datetime,
FECHA_DE_MODIFICACION datetime,
PRIMARY KEY (ID_CATEGORIA)
);



create table TB_SUB_CATEGORIA(
ID_SUB_CATEGORIA int AUTO_INCREMENT,
ID_CATEGORIA int,
FOREIGN KEY (ID_CATEGORIA) REFERENCES TB_CATEGORIA(ID_CATEGORIA),
NOMBRE varchar(200),
PRIMARY KEY (ID_SUB_CATEGORIA)
);



create table TB_MEDICAMENTO(
ID_MEDICAMENTO int AUTO_INCREMENT,
NOMBRE varchar(200),
DESCRIPCION varchar(500),
LABORATORIO varchar(200),
FECHA_CREACION datetime,
FECHA_DE_MODIFICACION datetime,
MARCA varchar(200),
PRIMARY KEY (ID_MEDICAMENTO),
ID_CATEGORIA int,
FOREIGN KEY (ID_CATEGORIA) REFERENCES TB_CATEGORIA(ID_CATEGORIA),
ARCHIVO_IMAGEN varchar(100),
ID_SUB_CATEGORIA int,
FOREIGN KEY (ID_SUB_CATEGORIA) REFERENCES TB_SUB_CATEGORIA(ID_SUB_CATEGORIA)
);




create table TB_FARMACIA_MEDICAMENTO(
ID_FARMACIA int,
FOREIGN KEY (ID_FARMACIA) REFERENCES TB_FARMACIA(ID_FARMACIA),
ID_MEDICAMENTO int,
FOREIGN KEY (ID_MEDICAMENTO) REFERENCES TB_MEDICAMENTO(ID_MEDICAMENTO),
CANTIDAD int,
PRECIO decimal(18,2),
MONEDA varchar(20)
);


-------------------------PROCEDIMIENTO-DE-CATEGORIA--------------------------------------------------------------

DELIMITER $$
create procedure USP_Categoria(in accion int,in id int,in NomCategoria varchar(200))
begin
if accion = 1 then
select * from TB_CATEGORIA;
elseif accion = 2 then
INSERT INTO TB_CATEGORIA (ID_CATEGORIA,NOMBRE_CATEGORIA,FECHA_CREACION,FECHA_DE_MODIFICACION) 
VALUES (default,NomCategoria,now(),now());
elseif accion = 3 then
update TB_CATEGORIA set NOMBRE_CATEGORIA=NomCategoria,FECHA_DE_MODIFICACION=now()
where ID_CATEGORIA=id;
elseif accion = 4 then
delete from TB_CATEGORIA where ID_CATEGORIA=id;
elseif accion = 5 then
select * from TB_CATEGORIA where ID_CATEGORIA=id;
end if;
end$$
DELIMITER ;



-------------------------PROCEDIMIENTO-DE-MEDICAMENTO--------------------------------------------------------------

DELIMITER $$
create procedure USP_Medicamento(in accion int,in id int,in NomMedicamento varchar(200),in DesMedicamento varchar(500),in LabMedicamento varchar(200)
                                                             , inMarcMedicamento varchar(200),in id_Cate int )
begin
if accion = 1 then
select * from TB_MEDICAMENTO;
end if;
if accion = 2 then
INSERT INTO TB_MEDICAMENTO (ID_MEDICAMENTO,NOMBRE,DESCRIPCION,LABORATORIO,FECHA_CREACION,FECHA_DE_MODIFICACION,MARCA,ID_CATEGORIA)
VALUES (default,NomMedicamento,DesMedicamento,LabMedicamento,now(),now(),MarcMedicamento,id_Cate);
end if;
if accion = 3 then
update TB_MEDICAMENTO set NOMBRE=NomMedicamento,DESCRIPCION=DesMedicamento,LABORATORIO=LabMedicamento,FECHA_DE_MODIFICACION=now() , MARCA=MarcMedicamento,ID_CATEGORIA=id_Cate
where ID_MEDICAMENTO=id;
end if;
if accion = 4 then
delete from TB_MEDICAMENTO where ID_MEDICAMENTO=id;
end if;
if accion = 5 then
select * from TB_MEDICAMENTO where ID_MEDICAMENTO=id;
end if;
end$$
DELIMITER ;


-------------------------PROCEDIMIENTO-DE-FARMACIA--------------------------------------------------------------

DELIMITER $$
create procedure USP_Farmacia(in accion int,in id int,in NomFarmacia varchar(200),in direFarmacia varchar(300),in telFarmacia varchar(15),in movFarmacia varchar(15),in latFarmacia varchar(45),in longFarmacia varchar(45),in proviFarmacia varchar(100),in correFarmacia varchar(100),in pais int,in cod_postal varchar(10) )
begin
if accion = 1 then
select * from TB_FARMACIA;
elseif accion = 2 then
INSERT INTO TB_FARMACIA (ID_FARMACIA,NOMBRE,DIRECCION,TELEFONO,MOVIL,LATITUD,LONGITUD,PROVINCIA,CORREO,ID_PAIS,CODIGO_POSTAL,FECHA_CREACION,FECHA_DE_MODIFICACION) 
VALUES (default,NomFarmacia,direFarmacia,telFarmacia,movFarmacia,latFarmacia,longFarmacia,proviFarmacia,correFarmacia,pais,cod_postal,now(),now());
elseif accion = 3 then
update TB_FARMACIA set NOMBRE=NomFarmacia,DIRECCION=direFarmacia,TELEFONO=telFarmacia,MOVIL=movFarmacia,LATITUD=latFarmacia,LONGITUD=longFarmacia,PROVINCIA=proviFarmacia,CORREO=correFarmacia,ID_PAIS=pais,CODIGO_POSTAL=cod_postal,FECHA_DE_MODIFICACION=now()
where ID_FARMACIA=id;
elseif accion = 4 then
delete from TB_FARMACIA where ID_FARMACIA=id;
elseif accion = 5 then
select * from TB_FARMACIA where ID_FARMACIA=id;
end if;
end$$
DELIMITER ;


-------------------------PROCEDIMIENTO-DE-BUSCAR-PRODUCTO--------------------------------------------------------------

DELIMITER $$
create procedure USP_Buscar_Producto(in accion int , in texto varchar(100))
begin
if accion = 1 then
SELECT DISTINCT
   t1.NOMBRE as NOMBRE_PRODUCTO,
	 t3.NOMBRE_CATEGORIA,
	 t1.ARCHIVO_IMAGEN
FROM
    TB_MEDICAMENTO t1	
INNER JOIN TB_CATEGORIA t3
    ON t1.ID_CATEGORIA = t3.ID_CATEGORIA
where t1.NOMBRE like CONCAT('%', texto , '%');

elseif accion = 2 then
SELECT DISTINCT
   t1.NOMBRE as NOMBRE_PRODUCTO,
	 t3.NOMBRE_CATEGORIA,
	 t5.NOMBRE as NOMBRE_FARMACIA,
	 t5.DIRECCION,
	 t5.LATITUD,
	 t5.LONGITUD,
	 t2.CANTIDAD,
	 t2.PRECIO as PRECIO,
	 t1.ARCHIVO_IMAGEN,
                   t1.ID_SUB_CATEGORIA
FROM
    TB_MEDICAMENTO t1
INNER JOIN TB_FARMACIA_MEDICAMENTO t2 
    ON t1.ID_MEDICAMENTO = t2.ID_MEDICAMENTO		
INNER JOIN TB_CATEGORIA t3
    ON t1.ID_CATEGORIA = t3.ID_CATEGORIA
INNER JOIN TB_SUB_CATEGORIA t4
    ON t4.ID_CATEGORIA = t3.ID_CATEGORIA
INNER JOIN TB_FARMACIA t5
    ON t5.ID_FARMACIA = t2.ID_FARMACIA
where t1.NOMBRE like CONCAT('%', texto , '%');
elseif accion = 3 then
SELECT DISTINCT
   t1.NOMBRE as NOMBRE_PRODUCTO,
	 t3.NOMBRE_CATEGORIA,
	 t5.NOMBRE as NOMBRE_FARMACIA,
	 t5.DIRECCION,
	 t5.LATITUD,
	 t5.LONGITUD,
	 t2.CANTIDAD,
	 min(t2.PRECIO) AS PRECIO,
	 t1.ARCHIVO_IMAGEN
FROM
    TB_MEDICAMENTO t1
INNER JOIN TB_FARMACIA_MEDICAMENTO t2 
    ON t1.ID_MEDICAMENTO = t2.ID_MEDICAMENTO		
INNER JOIN TB_CATEGORIA t3
    ON t1.ID_CATEGORIA = t3.ID_CATEGORIA
INNER JOIN TB_SUB_CATEGORIA t4
    ON t4.ID_CATEGORIA = t3.ID_CATEGORIA
INNER JOIN TB_FARMACIA t5
    ON t5.ID_FARMACIA = t2.ID_FARMACIA

where t1.NOMBRE like CONCAT('%', texto , '%');
end if;
end$$
DELIMITER ;



-------------------------PROCEDIMIENTO-DE-SUGERENCIAS--------------------------------------------------------------

DELIMITER $$
create procedure USP_SUGERENCIAS(in texto varchar(100))
BEGIN
SELECT distinct t1.NOMBRE , t1.ARCHIVO_IMAGEN 
    FROM TB_MEDICAMENTO t1
    INNER JOIN TB_SUB_CATEGORIA t2 ON t1.ID_SUB_CATEGORIA = t2.ID_SUB_CATEGORIA
    WHERE t2.ID_SUB_CATEGORIA = texto;
end$$
DELIMITER ;



-------------------------LLENADO-DE-LA-TABLA-TB_PAIS------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into TB_PAIS values (default,"España",'2019-11-12',null);


-------------------------LLENADO-DE-LA-TABLA-TB_CATEGORIA------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into TB_CATEGORIA values (default,"Bebe y Madre",'2019-11-12',null);
insert into TB_CATEGORIA values (default,"Cosmética",'2019-11-12',null);
insert into TB_CATEGORIA values (default,"Cuidado Personal",'2019-11-12',null);
insert into TB_CATEGORIA values (default,"Dietetica y Productos naturales",'2019-11-12',null);
insert into TB_CATEGORIA values (default,"Higiene",'2019-11-12',null);
insert into TB_CATEGORIA values (default,"Optica",'2019-11-12',null);
insert into TB_CATEGORIA values (default,"Ortopedia",'2019-11-12',null);
insert into TB_CATEGORIA values (default,"Salud",'2019-11-12',null);


-------------------------LLENADO-DE-LA-TABLA-TB_SUB_CATEGORIA------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into TB_SUB_CATEGORIA values (default,1,"Alimentacion Infantil");
insert into TB_SUB_CATEGORIA values (default,1,"Higiene del bebe");
insert into TB_SUB_CATEGORIA values (default,1,"Puericultura");


insert into TB_SUB_CATEGORIA values (default,2,"Corporal");
insert into TB_SUB_CATEGORIA values (default,2,"Maquillajes");
insert into TB_SUB_CATEGORIA values (default,2,"Facial");
insert into TB_SUB_CATEGORIA values (default,2,"Nariz y Labios");
insert into TB_SUB_CATEGORIA values (default,2,"Fragancias");
insert into TB_SUB_CATEGORIA values (default,2,"Proteccion Solar");
insert into TB_SUB_CATEGORIA values (default,2,"Hombre");


insert into TB_SUB_CATEGORIA values (default,3,"Cuidado del cabello");


insert into TB_SUB_CATEGORIA values (default,4,"Alimentación");
insert into TB_SUB_CATEGORIA values (default,4,"Dermatalógicos");
insert into TB_SUB_CATEGORIA values (default,4,"Nitricosmética");
insert into TB_SUB_CATEGORIA values (default,4,"Articular y Muscular");
insert into TB_SUB_CATEGORIA values (default,4,"Digestivo y Metabolismo");
insert into TB_SUB_CATEGORIA values (default,4,"Circulatorio");
insert into TB_SUB_CATEGORIA values (default,4,"Ginecológicos y Urológicos");
insert into TB_SUB_CATEGORIA values (default,4,"Respiratorio");
insert into TB_SUB_CATEGORIA values (default,4,"Control de peso");
insert into TB_SUB_CATEGORIA values (default,4,"Insomnio y nerviosismo");
insert into TB_SUB_CATEGORIA values (default,4,"Otros");

insert into TB_SUB_CATEGORIA values (default,5,"Accesorios higiene");
insert into TB_SUB_CATEGORIA values (default,5,"Cabello");
insert into TB_SUB_CATEGORIA values (default,5,"Higiene bucal");
insert into TB_SUB_CATEGORIA values (default,5,"Higiene corporal");
insert into TB_SUB_CATEGORIA values (default,5,"Higiene intima");
insert into TB_SUB_CATEGORIA values (default,5,"Incontinencia");
insert into TB_SUB_CATEGORIA values (default,5,"Manos y uñas");
insert into TB_SUB_CATEGORIA values (default,5,"Pies y piernas");

insert into TB_SUB_CATEGORIA values (default,6,"Accesorios óptica");
insert into TB_SUB_CATEGORIA values (default,6,"Gafas para graduar");
insert into TB_SUB_CATEGORIA values (default,6,"Gafas de presbicia");
insert into TB_SUB_CATEGORIA values (default,6,"Salud ocular");
insert into TB_SUB_CATEGORIA values (default,6,"Gafas de sol");
insert into TB_SUB_CATEGORIA values (default,6,"Gafas niños");


insert into TB_SUB_CATEGORIA values (default,7,"Antirreumáticos");
insert into TB_SUB_CATEGORIA values (default,7,"Medias y calcetines");
insert into TB_SUB_CATEGORIA values (default,7,"Calzado");
insert into TB_SUB_CATEGORIA values (default,7,"Miembro inferior");
insert into TB_SUB_CATEGORIA values (default,7,"Podología");
insert into TB_SUB_CATEGORIA values (default,7,"Geriatria y descanso");
insert into TB_SUB_CATEGORIA values (default,7,"Miembro superior");
insert into TB_SUB_CATEGORIA values (default,7,"Tronco");
insert into TB_SUB_CATEGORIA values (default,7,"Mastectomia");
insert into TB_SUB_CATEGORIA values (default,7,"Movilidad");
insert into TB_SUB_CATEGORIA values (default,7,"Vida diaria");


insert into TB_SUB_CATEGORIA values (default,8,"Antiparasitarios");
insert into TB_SUB_CATEGORIA values (default,8,"Diagnostico");
insert into TB_SUB_CATEGORIA values (default,8,"Sistema urinario");
insert into TB_SUB_CATEGORIA values (default,8,"Botiquin");
insert into TB_SUB_CATEGORIA values (default,8,"Repelentes y picaduras");
insert into TB_SUB_CATEGORIA values (default,8,"Cuidado circulatorio");
insert into TB_SUB_CATEGORIA values (default,8,"Salud femenina");
insert into TB_SUB_CATEGORIA values (default,8,"Cuidado muscular");
insert into TB_SUB_CATEGORIA values (default,8,"Salud sexual");


-------------------------LLENADO-DE-LA-TABLA-TB_FARMACIA------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into TB_FARMACIA values (default,"Farmacia Salvado Llados","Passeig Sant Joan 2 - Eixample","932314605","612345678","41.391732","2.180345","BARCELONA","salvado@gmail.com",1,"08010","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Morera Ingles","Passeig Sant Joan 3 - Eixample","932324210","623456789","41.391906","2.179117","BARCELONA","morera@gmail.com",1,"08010","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Villar Merchan","Rbla Poblenou 21 - Sant Marti","932241123","634567890","41.398772","2.204157","BARCELONA","villar@gmail.com",1,"","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Farmaxnadal","Carrer de Nadal 52 - Sant Andreu","931133328","707876543","41.4288062","2.1883242","BARCELONA","farmaxnadal@gmail.com",1,"08030","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Planas Pascual","Passeig Torras i Bages 83 - Sant Andreu","933450634","645678901","41.4398","2.190815","BARCELONA","planas@gmail.com",1,"08030","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Fiol Belart","Calle Numancia 84 - Les Corts","933219442","656789012","41.385257","2.137174","BARCELONA","fiol@gmail.com",1,"08029","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Romera Guijarro","Passeig Sant Joan 87 - Eixample","934573657","667890123","41.398085","2.17094","BARCELONA","romera@gmail.com",1,"08009","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Orrit Mackenzie","Passeig Sant Joan 111 - Eixample","934535373","678901234","41.399805","2.168665","BARCELONA","orrit@gmail.com",1,"08037","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Berge Sahli","Calle Mare de Deu de Port 255 - Sants-Montjuic","933311341","689012345","41.358896","2.142849","BARCELONA","berge@gmail.com",1,"08038","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Ferriol Casar","Calle Agudes 52 - Nou Barris","932769300","690123456","41.461841","2.177557","BARCELONA","ferriol@gmail.com",1,"08033","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Guerrero Pozo","Calle Agusti i Mila  38 - Sant Andreu","933458141","601234567","41.438325","2.187658","BARCELONA","guerrero@gmail.com",1,"08030","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Muzas Cucalon","Calle Alcalde de Mostoles 33 - Horta-Guinardo","934553036","621234567","41.410898","2.165919","BARCELONA","muzas@gmail.com",1,"08025","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Barenys de Lacha","Passeig Urrutia 64 - Nou Barris","934202342","631234567","41.435355","2.167588","BARCELONA","de@gmail.com",1,"08031","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Pla Pastrana","Carrer d'Alfons el Magnanim 91 - Sant Marti","933051451","641234567","41.416667","2.213372","BARCELONA","pla@gmail.com",1,"08019","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Garciapons","Calle Cinca 92 - Sant Andreu","933454008","651234567","41.441691","2.192198","BARCELONA","farmacia@gmail.com",1,"08030","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Najar Marton","Calle Alt de Pedrell 58 - Horta-Guinardo","934202001","661234567","41.426065","2.169113","BARCELONA","najar@gmail.com",1,"08032","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Viladot Gamissans","Calle Amigo 30 - Sarria -Sant Gervasi","932003730","671234567","41.394987","2.145092","BARCELONA","viladot@gmail.com",1,"08021","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Dorca","Calle Amilcar 7 - Nou Barris","934291781","681234567","41.429941","2.172053","BARCELONA","farmacia@gmail.com",1,"08031","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Garcia Barrado","Calle Amilcar 158 - Horta-Guinardo","934365034","691234567","41.422234","2.172802","BARCELONA","garcia@gmail.com",1,"08032","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Gultresa Colomer","Calle Andrade 151 - Sant Marti","935393306","601234567","41.41628","2.201259","BARCELONA","gultresa@gmail.com",1,"08020","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Cabre Alcoverro","Calle Andrade 224 - Sant Marti","933138909","601234567","41.418986","2.205325","BARCELONA","cabre@gmail.com",1,"08020","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Domenech Perez","Calle Andrea Doria 14 - Ciutat Vella","932214236","691234567","41.380265","2.190496","BARCELONA","domenech@gmail.com",1,"08003","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Rotllan Vilalta","Carrer Angel Guimera  14 - Sarria -Sant Gervasi","932010098","681234567","4.139612","2.132937","BARCELONA","rotllan@gmail.com",1,"08017","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Esquerra  Amargos","Carrer Angel Marques 7 - Horta-Guinardo","934283995","671234567","41.429906","2.141962","BARCELONA","esquerra@gmail.com",1,"08035","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Trias Banyeres Jordi","Ptge Antoni Gassol 22 - Sant Marti","933075067","661234567","41.41317","2.196315","BARCELONA","banyeres@gmail.com",1,"08018","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Puga Gasull","Carrer Sant Ramon de Penyafort 3 - Sant Marti","933580900","651234567","41.41374","2.220458","BARCELONA","puga@gmail.com",1,"08019","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Gardella Roca","Carrer Arenys 108 - Horta-Guinardo","934295714","641234567","41.423193","2.147084","BARCELONA","gardella@gmail.com",1,"08035","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Urgelles Fabregas","Carrer Aribau 36 - Eixample","934523190","631234567","41.38726","2.161077","BARCELONA","urgelles@gmail.com",1,"08011","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Torres","Carrer Aribau 62 - Eixample","934520259","621234567","41.388671","2.159209","BARCELONA","farmacia@gmail.com",1,"08011","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Casaus Domingo","Carrer Aribau 91 - Eixample","934532990","712345678","41.390032","2.157043","BARCELONA","casaus@gmail.com",1,"08036","2019-11-12",null);
insert into TB_FARMACIA values (default,"Farmacia Barri Flotats","Carrer Aribau 180 - Eixample","932189586","721234567","41.393232","2.153181","BARCELONA","barri@gmail.com",1,"08036","2019-11-12",null);


-------------------------LLENADO-DE-LA-TABLA-TB_MEDICAMENTO------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into TB_MEDICAMENTO values (default,'Nuxellence Zona Contorno de Ojos','Este tratamiento antiedad para el contorno de ojos con 10 patentes (FR), flor de Pasiflora y acido Hialuronico, ayuda a las celulas de la piel a conservar un nivel de energia optimo(1) para una mirada que parece mas joven y luminosa. Su textura blur(2) alisante y su aplicador masajeador descongestionante ofrecen un efecto perfeccionador instantaneo.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX400.jpg',6);
insert into TB_MEDICAMENTO values (default,'Nuxellence DETOX Frasco dosificador 50ml','TRATAMIENTO ANTIEDAD DETOXIFICANTE Y REVELADOR DE JUVENTUD - NOCHE Para todos los tipos de piel - para todas las edades, Ilumine su belleza con lo mejor en tratamientos antiedad.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX401.jpg',6);
insert into TB_MEDICAMENTO values (default,'Nuxellence Eclat Frasco dosificador 50 ml','TRATAMIENTO REVELADOR DE JUVENTUD Y LUMINOSIDAD Para todos los tipos de piel - para todas las edades, Ilumine su belleza con lo mejor en tratamientos antiedad','  ','2019-11-12','2019-11-12','NUXE',2,'NUX402.jpg',6);
insert into TB_MEDICAMENTO values (default,'Nirvanesque','EMULSIoN ALISANTE PARA LiNEAS FINAS - ALISA LAS LiNEAS, RELAJA LA PIEL E HIDRATA Para las pieles normales La eficacia de la peonia para una piel zen y alisada','  ','2019-11-12','2019-11-12','NUXE',2,'NUX403.jpg',6);
insert into TB_MEDICAMENTO values (default,'Nirvanesque Enriquecida','EMULSIoN ALISANTE EXQUISITA PARA LiNEAS FINAS - ALISA LAS LiNEAS, RELAJA LA PIEL Y NUTRE Para las pieles secas a muy secas La eficacia de la peonia para una piel zen y alisada','  ','2019-11-12','2019-11-12','NUXE',2,'NUX404.jpg',6);
insert into TB_MEDICAMENTO values (default,'Nirvanesque Light','EMULSIoN ALISANTE PARA LiNEAS FINAS - ALISA LAS LiNEAS, RELAJA LA PIEL Y REDUCE EL BRILLO Para las pieles mixtas La eficacia de la peonia para una piel zen y alisada','  ','2019-11-12','2019-11-12','NUXE',2,'NUX405.jpg',6);
insert into TB_MEDICAMENTO values (default,'Contorno ojos Nirvanesque','EMULSIoN ALISANTE DE OJOS PARA LiNEAS FINAS - ALISA LAS LiNEAS, RELAJA LA PIEL E HIDRATA Para todos los tipos de piel La eficacia de la peonia para una piel zen y alisada','  ','2019-11-12','2019-11-12','NUXE',2,'NUX406.jpg',6);
insert into TB_MEDICAMENTO values (default,'Merveillance Expert Fluido','FLUIDO CORRECTOR ARRUGAS INSTALADAS - Rellena, reafirma y cierra los poros Pieles mixtas Tratamientos antiedad aterciopelados para maravillar su piel','  ','2019-11-12','2019-11-12','NUXE',2,'NUX407.jpg',6);
insert into TB_MEDICAMENTO values (default,'Merveillance Expert','CREMA CORRECTORA PARA ARRUGAS PROFUNDAS - RELLENA, REAFIRMA E HIDRATA Pieles normales Tratamientos antiedad aterciopelados para maravillar su piel','  ','2019-11-12','2019-11-12','NUXE',2,'NUX408.jpg',6);
insert into TB_MEDICAMENTO values (default,'Merveillance Expert - Enriquecida','CREMA CORRECTORA EXQUISITA PARA ARRUGAS PROFUNDAS - RELLENA, REAFIRMA Y NUTRE Para las pieles secas a muy secas Tratamientos antiedad aterciopelados para maravillar su piel','  ','2019-11-12','2019-11-12','NUXE',2,'NUX409.jpg',6);
insert into TB_MEDICAMENTO values (default,'Merveillance Expert Noche','Tratamientos antiedad aterciopelados para maravillar su piel','  ','2019-11-12','2019-11-12','NUXE',2,'NUX410.jpg','6');
insert into TB_MEDICAMENTO values (default,'Crema de Manos Anti-manchas y Antiedad Nuxuriance ultra','Tratamiento de Manos Anti-manchas y Antiedad - Alisa la piel y aclara las manchas Todos los tipos de piel Tratamientos con texturas ricas para regenerar y redensificar la piel.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX411.jpg',7);
insert into TB_MEDICAMENTO values (default,'Nuxuriance ultra Crema Redensificante SPF 20 PA +++','Crema redensificante Antiedad global Todos los tipos de piel Tratamientos con texturas ricas para regenerar y redensificar la piel.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX412.jpg',4);
insert into TB_MEDICAMENTO values (default,'Crema Fluida Nuxuriance ultra ','CREMA FLUIDA REDENSIFICANTE ANTIEDAD GLOBAL Pieles normales a mixtas;; Tratamientos con texturas ricas para regenerar y redensificar la piel.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX413.jpg',6);
insert into TB_MEDICAMENTO values (default,'Crema rica Nuxuriance ultra','CREMA REDENSIFICANTE ANTIEDAD GLOBAL Pieles secas a muy secas Tratamientos con texturas ricas para regenerar y redensificar la piel.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX414.jpg',6);
insert into TB_MEDICAMENTO values (default,'Coffret Prodigieux','Un ritual que regala una belleza prodigiosa Todos los tipos de piel','  ','2019-11-12','2019-11-12','NUXE',2,'NUX415.jpg',6);
insert into TB_MEDICAMENTO values (default,'Crema Prodigieuse DD Crema - Tono Claro','CREMA DAILY DEFENSE HIDRATANTE CON COLOR EMBELLECEDORA SPF 30 Para todos los tipos de piel Un velo envolvente y protector contra el estres oxidativo','  ','2019-11-12','2019-11-12','NUXE',2,'NUX416.jpg',9);
insert into TB_MEDICAMENTO values (default,'Crema Prodigieuse DD Crema - Tono Medio','CREMA DAILY DEFENSE HIDRATANTE CON COLOR EMBELLECEDORA SPF 30 Para todos los tipos de piel Un velo envolvente y protector contra el estres oxidativo','  ','2019-11-12','2019-11-12','NUXE',2,'NUX417.jpg',9);
insert into TB_MEDICAMENTO values (default,'Crema Prodigieuse DD Crema - Tono Oscuro','CREMA DAILY DEFENSE HIDRATANTE CON COLOR EMBELLECEDORA SPF 30 Para todos los tipos de piel Un velo envolvente y protector contra el estres oxidativo','  ','2019-11-12','2019-11-12','NUXE',2,'NUX418.jpg',9);
insert into TB_MEDICAMENTO values (default,'Crema Prodigieuse Enriquecida','CREMA HIDRATANTE ANTI-FATIGA Para las pieles secas Un velo envolvente y protector contra el estres oxidativo','  ','2019-11-12','2019-11-12','NUXE',2,'NUX419.jpg',6);
insert into TB_MEDICAMENTO values (default,'Crema Prodigieuse Noche','CREMA DE NOCHE HIDRANTANTE Y REVITALIZADORA - TRATAMIENTO RENOVADOR NOCTURNO Para todos los tipos de piel Un velo envolvente y protector contra el estres oxidativo','  ','2019-11-12','2019-11-12','NUXE',2,'NUX420.jpg',6);
insert into TB_MEDICAMENTO values (default,'Contorno de ojos - Prodigieux','CONTORNO DE OJOS - ANTIEDAD, REDUCE LAS BOLSAS Para todos los tipos de piel Un velo envolvente y protector contra el estres oxidativo','  ','2019-11-12','2019-11-12','NUXE',2,'NUX421.jpg',5);
insert into TB_MEDICAMENTO values (default,'Crema Prodigieuse','CREMA HIDRATANTE ANTI-FATIGA - MATIFICANTE Para las pieles normales a mixtas Un velo envolvente y protector contra el estres oxidativo','  ','2019-11-12','2019-11-12','NUXE',2,'NUX422.jpg',6);
insert into TB_MEDICAMENTO values (default,'Crema hidratante Crema fraiche de beaute','CREMA HIDRATANTE 48H - ANTI-POLUCIoN Pieles normales Disfrute del sutil placer de una hidratacion refrescant','  ','2019-11-12','2019-11-12','NUXE',2,'NUX423.jpg',6);
insert into TB_MEDICAMENTO values (default,'Crema hidratante Crema fraiche de beaute','CREMA HIDRATANTE 48H - ANTI-POLUCIoN Pieles normales Disfrute del sutil placer de una hidratacion refrescante','  ','2019-11-12','2019-11-12','NUXE',2,'NUX424.jpg',6);
insert into TB_MEDICAMENTO values (default,'Crema rica hidratante Crema fraiche de beaute','CREMA RICA HIDRATANTE 48H - ANTI-POLUCIoN Para las pieles sensibles, pieles secas a muy secas Disfrute del sutil placer de una hidratacion refrescante.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX425.jpg',6);
insert into TB_MEDICAMENTO values (default,'Crema rica hidratante Crema fraiche de beaute','CREMA RICA HIDRATANTE 48H - ANTI-POLUCIoN Para las pieles sensibles, pieles secas a muy secas Disfrute del sutil placer de una hidratacion refrescante.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX426.jpg',6);
insert into TB_MEDICAMENTO values (default,'Fluido hidratante Crema fraiche de beaute','FLUIDO MATIFICANTE - HIDRATACIoN 48 H - ANTI-POLUCIoN Pieles mixtas Disfrute del sutil placer de una hidratacion refrescante.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX427.jpg',6);
insert into TB_MEDICAMENTO values (default,'Mascarilla hidratante Crema fraiche de beaute','MASCARILLA SOS HIDRATANTE 48 H - ANTI-POLUCIoN, CALMA Todos los tipos de piel Disfrute del sutil placer de una hidratacion refrescante.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX428.jpg',6);
insert into TB_MEDICAMENTO values (default,'Serum calmante Crema fraiche de beaute','SERUM CALMANTE HIDRATACIoN 48 H - ANTI-POLUCIoN, REDENSIFICANTE Todos los tipos de piel, incluso las sensibles Disfrute del sutil placer de una hidratacion refrescante.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX429.jpg',6);
insert into TB_MEDICAMENTO values (default,'Aceite Micelar Desmaquillante con Petalos de Rosa','ACEITE DESMAQUILLANTE - LIMPIA CON SUAVIDADPieles sensibles Sucumba a la delicadeza de los petalos de rosa para un desmaquillado suave','  ','2019-11-12','2019-11-12','NUXE',2,'NUX430.jpg',5);
insert into TB_MEDICAMENTO values (default,'Agua Desmaquillante Micelar con petalos de rosa','AGUA DESMAQUILLANTE MICELAR - LIMPIA CON SUAVIDAD Para pieles sensibles, todos los tipos de piel. Sucumba a la delicadeza de los petalos de rosa para un desmaquillado suave','  ','2019-11-12','2019-11-12','NUXE',2,'NUX431.jpg',5);
insert into TB_MEDICAMENTO values (default,'Leche desmaquillante con petalos de rosa','DESMAQUILLANTE CoMODO - LIMPIA CON SUAVIDAD Para las pieles sensibles, normales a secas. Sucumba a la delicadeza de los petalos de rosa para un desmaquillado suave','  ','2019-11-12','2019-11-12','NUXE',2,'NUX432.jpg',5);
insert into TB_MEDICAMENTO values (default,'Locion tonica Suave con petalos de rosa','ToNICO SUAVE - CALMA Y REFRESCA Para las pieles sensibles, normales a secas Sucumba a la delicadeza de los petalos de rosa para un desmaquillado suave','  ','2019-11-12','2019-11-12','NUXE',2,'NUX433.jpg',6);
insert into TB_MEDICAMENTO values (default,'Espuma micelar con petalos de rosa','ESPUMA MICELAR DESMAQUILLANTE - LIMPIA CON SUAVIDAD Para las pieles sensibles, normales a mixtas Sucumba a la delicadeza de los petalos de rosa para un desmaquillado suave','  ','2019-11-12','2019-11-12','NUXE',2,'NUX434.jpg',6);
insert into TB_MEDICAMENTO values (default,'Gel Desmaquillante Fundente con petalos de rosa','GEL DESMAQUILLANTE - LIMPIA Y DESMAQUILLA CON SUAVIDAD Para las pieles sensibles, normales a mixtas Sucumba a la delicadeza de los petalos de rosa para un desmaquillado suave','  ','2019-11-12','2019-11-12','NUXE',2,'NUX435.jpg',5);
insert into TB_MEDICAMENTO values (default,'Locion limpiadora purificante - Aroma-Perfection','LOCIoN PURIFICANTE PERFECCIONADORA DE PIEL - CIERRA LOS POROS Y REDUCE LOS BRILLOSPara las pieles mixtas y grasas','  ','2019-11-12','2019-11-12','NUXE',2,'NUX436.jpg',6);
insert into TB_MEDICAMENTO values (default,'Gel limpiador Dermatologico Reve de Miel','GEL DE DUCHA ROSTRO Y CUERPO ULTRA EXQUISITO - CALMA, SUAVIZA Para las pieles secas y sensibles Para las pieles mixtas y grasas','  ','2019-11-12','2019-11-12','NUXE',2,'NUX437.jpg',26);
insert into TB_MEDICAMENTO values (default,'Gel Limpiador y Desmaquillante facial Reve de Miel','GEL LIMPIADOR Y DESMAQUILLANTE - CALMA, SUAVIZA Para las pieles secas y sensibles','  ','2019-11-12','2019-11-12','NUXE',2,'NUX438.jpg',5);
insert into TB_MEDICAMENTO values (default,'Splendieuse Mascarilla ','MASCARILLA ANTI-MANCHAS PERFECCIONADORA - HOMOGENEIZA LA TEZ, REVITALIZA LA LUMINOSIDAD Para todos los tipos de piel El delicado esplendor de un tono luminoso y unificado','  ','2019-11-12','2019-11-12','NUXE',2,'NUX439.jpg',6);
insert into TB_MEDICAMENTO values (default,'Mascarilla hidratante Crema fraiche de beaute','MASCARILLA SOS HIDRATANTE 48 H - ANTI-POLUCIoN, CALMA Todos los tipos de piel Disfrute del sutil placer de una hidratacion refrescante.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX440.jpg',6);
insert into TB_MEDICAMENTO values (default,'Gel exfoliante con petalos de rosa','GEL EXFOLIANTE FACIAL SUAVE - EXFOLIA Para pieles sensibles, todos los tipos de piel Sucumba a la delicadeza de los petalos de rosa para un desmaquillado suave','  ','2019-11-12','2019-11-12','NUXE',2,'NUX441.jpg',6);
insert into TB_MEDICAMENTO values (default,'Mascarilla Crema Purificante con petalos de rosa','MASCARILLA CREMA FACIAL - PURIFICA LA PIEL Y CIERRA LOS POROS Para pieles sensibles, todos los tipos de piel Sucumba a la delicadeza de los petalos de rosa para un desmaquillado suave','  ','2019-11-12','2019-11-12','NUXE',2,'NUX442.jpg',6);
insert into TB_MEDICAMENTO values (default,'Mascarilla exfoliante Aroma-Perfection','MASCARILLA TERMO-ACTIVA DESINCRUSTANTE - EXFOLIA, ACLARA Para las pieles mixtas y grasas','  ','2019-11-12','2019-11-12','NUXE',2,'NUX443.jpg',6);
insert into TB_MEDICAMENTO values (default,'Nuxellence Zona Contorno de Ojos','Tratamiento antiedad Contorno de Ojos - Efecto Perfeccionador y Luminosidad Todos los tipos de piel Ilumine su belleza con lo mejor en tratamientos antiedad','  ','2019-11-12','2019-11-12','NUXE',2,'NUX444.jpg',6);
insert into TB_MEDICAMENTO values (default,'Splendieuse Ojos','CONTORNO DE OJOS ANTI-MANCHAS Y ANTI-OJERAS Todos los tipos de piel El delicado esplendor de un tono luminoso y unificado','  ','2019-11-12','2019-11-12','NUXE',2,'NUX445.jpg',6);
insert into TB_MEDICAMENTO values (default,'Contorno de ojos Merveillance Expert','CONTORNO DE OJOS EFECTO LIFTING - RELLENA, REDUCE LAS BOLSAS Y ELIMINA LAS OJERAS Todos los tipos de pielTratamientos antiedad aterciopelados para maravillar su piel','  ','2019-11-12','2019-11-12','NUXE',2,'NUX446.jpg',6);
insert into TB_MEDICAMENTO values (default,'Contorno de ojos NUXE Men','CONTORNO DE OJOS MULTIFUNCIoN HOMBRE - ANTIBOLSAS, ANTIOJERAS, ANTIEDAD El poder de los arboles para cuidar la piel de los hombres','  ','2019-11-12','2019-11-12','NUXE',2,'NUX447.jpg',6);
insert into TB_MEDICAMENTO values (default,'Huile Prodigieuse Ediciones Limitadas 25 anos','ACEITE SECO MULTI-FUNCIONES Rostro, Cuerpo, Cabello','  ','2019-11-12','2019-11-12','NUXE',2,'NUX448.jpg',4);
insert into TB_MEDICAMENTO values (default,'Huile prodigieuse or','ACEITE SECO ILUMINADOR MULTI-FUNCIONES - NUTRE, SUAVIZA E ILUMINA Rostro, Cuerpo, Cabello Goza de la sensualidad de una piel bien nutrida.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX449.jpg',4);
insert into TB_MEDICAMENTO values (default,'Huile prodigieuse or','ACEITE SECO ILUMINADOR MULTI-FUNCIONES - NUTRE, SUAVIZA E ILUMINA Rostro, Cuerpo, Cabello Goza de la sensualidad de una piel bien nutrida.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX450.jpg',4);
insert into TB_MEDICAMENTO values (default,'Aceite seco Huile prodigieuse','ACEITE SECO MULTI-FUNCIONES Rostro, Cuerpo, Cabello Goza de la sensualidad de una piel bien nutrida.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX451.jpg',11);
insert into TB_MEDICAMENTO values (default,'Aceite seco Huile prodigieuse','ACEITE SECO MULTI-FUNCIONES Rostro, Cuerpo, Cabello Goza de la sensualidad de una piel bien nutrida.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX452.jpg',11);
insert into TB_MEDICAMENTO values (default,'Aceite para pieles secas Huile prodigieuse riche','Aceite para pieles secas multifuncion: nutre, repara y suaviza Rostro, Cuerpo, Cabello Goza de la sensualidad de una piel bien nutrida.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX453.jpg',11);
insert into TB_MEDICAMENTO values (default,'Poudre Eclat Prodigieux','POLVOS COMPACTOS BRONCEADORES MULTI-USOS Para todos los tipos de piel, todos los tonos de piel. Goza de la sensualidad de una piel bien nutrida.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX454.jpg',5);
insert into TB_MEDICAMENTO values (default,'Balsamo de Labios Ultra-Nutritivo Reve de MielEdicion limitada Glam','BaLSAMO LABIOS HIDRATANTE - NUTRE, REPARA Y PROTEGE  Labios secos o dañados','  ','2019-11-12','2019-11-12','NUXE',2,'NUX455.jpg',7);
insert into TB_MEDICAMENTO values (default,'Balsamo de Labios Ultra-Nutritivo Reve de MielEdicion limitada Rock','BaLSAMO LABIOS HIDRATANTE - NUTRE, REPARA Y PROTEGE  Labios secos o dañados','  ','2019-11-12','2019-11-12','NUXE',2,'NUX456.jpg',7);
insert into TB_MEDICAMENTO values (default,'Balsamo de Labios Ultra-Nutritivo Reve de Miel  Labios secos o dañados','BaLSAMO LABIOS HIDRATANTE - NUTRE, REPARA Y PROTEGE  Labios secos o dañados','  ','2019-11-12','2019-11-12','NUXE',2,'NUX457.jpg',7);
insert into TB_MEDICAMENTO values (default,'Mi Coffret de Ensueno Nuxe','El coffret de los best-sellers Nuxe ','  ','2019-11-12','2019-11-12','NUXE',2,'NUX458.jpg',7);
insert into TB_MEDICAMENTO values (default,'Stick de Labios Hidratante Reve de miel','STICK LABIOS HIDRATANTE - HIDRATA, REPARA Y PROTEGE Labios secos o da','  ','2019-11-12','2019-11-12','NUXE',2,'NUX459.jpg',7);
insert into TB_MEDICAMENTO values (default,'Balsamo Labial Ultra-Hidratante Reve de Miel','CUIDADO LABIOS HIDRATANTE - NUTRE, REPARA Y PROTEGE Labios secos o da','  ','2019-11-12','2019-11-12','NUXE',2,'NUX460.jpg',7);
insert into TB_MEDICAMENTO values (default,'Leche Fundente en Spray Rostro y Cuerpo - Proteccion Alta - SPF 50','Edicion Limitada Roland-Garros Rostro y cuerpo El placer de los primeros rayos de sol, una piel dorada y protegida.','  ','2019-11-12','2019-11-12','BIOBEAUTE BY NUXE',2,'NUX461.jpg',9);
insert into TB_MEDICAMENTO values (default,'Aceite Bronceador Rostro y Cuerpo SPF 10 NUXE Sun','PROTECCIoN CELULAR ANTIEDAD, BRONCEADO SUBLIME – CON FLORES ACUaTICAS Y SOLARES Rostro y Cuerpo El placer de los primeros rayos de sol, una piel dorada y protegida.','  ','2019-11-12','2019-11-12','BIOBEAUTE BY NUXE',2,'NUX462.jpg',9);
insert into TB_MEDICAMENTO values (default,'Leche Corporal y Facial en Spray SPF 20 NUXE Sun','PROTECCIoN CELULAR ANTIEDAD, BRONCEADO SUBLIME – CON FLORES ACUaTICAS Y SOLARES Rostro y Cuerpo El placer de los primeros rayos de sol, una piel dorada y protegida. PROTECCIoN CELULAR ANTIEDAD, BRONCEADO SUBLIME – CON FLORES ACUaTICAS Y SOLARES Rostro y Cuerpo El placer de los primeros rayos de sol, una piel dorada y protegida.','  ','2019-11-12','2019-11-12','BIOBEAUTE BY NUXE',2,'NUX463.jpg',9);
insert into TB_MEDICAMENTO values (default,'Crema Facial Deliciosa SPF 30 NUXE Sun','PROTECCIoN CELULAR ANTIEDAD, BRONCEADO SUBLIME Rostro El placer de los primeros rayos de sol, una piel dorada y protegida.','  ','2019-11-12','2019-11-12','BIOBEAUTE BY NUXE',2,'NUX464.jpg',9);
insert into TB_MEDICAMENTO values (default,'Aceite Bronceador Rostro y Cuerpo SPF 30 NUXE Sun','PROTECCIoN CELULAR ANTIEDAD, BRONCEADO SUBLIME – CON FLORES ACUaTICAS Y SOLARES Rostro y Cuerpo El placer de los primeros rayos de sol, una piel dorada y protegida.','  ','2019-11-12','2019-11-12','BIOBEAUTE BY NUXE',2,'NUX465.jpg',9);
insert into TB_MEDICAMENTO values (default,'Leche Deliciosa Rostro y Cuerpo SPF 30 NUXE Sun','PROTECCIoN CELULAR ANTIEDAD, BRONCEADO SUBLIME – CON FLORES ACUaTICAS Y SOLARES Rostro y Cuerpo El placer de los primeros rayos de sol, una piel dorada y protegida.','  ','2019-11-12','2019-11-12','BIOBEAUTE BY NUXE',2,'NUX466.jpg',9);
insert into TB_MEDICAMENTO values (default,'Crema Fundente Rostro SPF 50 NUXE Sun','PROTECCIoN CELULAR ANTIEDAD, PREVIENE LAS MANCHAS Rostro El placer de los primeros rayos de sol, una piel dorada y protegida.','  ','2019-11-12','2019-11-12','BIOBEAUTE BY NUXE',2,'NUX467.jpg',9);
insert into TB_MEDICAMENTO values (default,'Leche Facial y Corporal Refrescante para DespuEs del Sol NUXE Sun','LECHE PARA DESPUES DEL SOL ROSTRO Y CUERPO - PROLONGA EL BRONCEADO Para todos los tipos de piel - Rostro y Cuerpo El placer de los primeros rayos de sol, una piel dorada y protegida.','  ','2019-11-12','2019-11-12','BIOBEAUTE BY NUXE',2,'NUX468.jpg',4);
insert into TB_MEDICAMENTO values (default,'Emulsion Fundente Auto-Bronceadora Rostro NUXE Sun','TRATAMIENTO AUTO-BRONCEADOR ROSTRO - BRONCEADO NATURAL Y UNIFORME Para todos los tipos de piel - Rostro El placer de los primeros rayos de sol, una piel dorada y protegida.','  ','2019-11-12','2019-11-12','BIOBEAUTE BY NUXE',2,'NUX469.jpg',9);
insert into TB_MEDICAMENTO values (default,'Gel-Crema Hidratante Autobronceador BIO-BEAUTE','AUTOBRONCEADOR CON EXTRACTO DE MANGO Rostro y Cuerpo - Para todos los tipos de piel','  ','2019-11-12','2019-11-12','BIOBEAUTE BY NUXE',2,'NUX470.jpg',9);
insert into TB_MEDICAMENTO values (default,'Nuxellence Men','FLUIDO ANTIEDAD REVELADOR - JUVENTUD Y ENERGiA Para todos los tipos de piel. Todas las edades El poder de los arboles para cuidar la piel de los hombres','  ','2019-11-12','2019-11-12','NUXE',2,'NUX471.jpg',10);
insert into TB_MEDICAMENTO values (default,'Coffret Los Imprescindibles para Hombre','El trio de tratamientos para el hombre moderno Todos los tipos de piel Los toques de especias acentuan la naturaleza campestre de este perfume masculino.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX472.jpg',10);insert into TB_MEDICAMENTO values (default,'Gel hidratante NUXE Men','TRATAMIENTO FACIAL HIDRATANTE HOMBRE - ENERGIZANTE, MATIFICANTE Todos los tipos de piel, incluso las sensibles El poder de los arboles para cuidar la piel de los hombres','  ','2019-11-12','2019-11-12','NUXE',2,'NUX473.jpg',10);
insert into TB_MEDICAMENTO values (default,'Gel de Ducha Multi-Usos NUXE Men','GEL DE DUCHA HOMBRE MULTI-USOS Para todos los tipos de piel, incluso las sensibles - Rostro, Cuerpo, Cabello El poder de los arboles para cuidar la piel de los hombres','  ','2019-11-12','2019-11-12','NUXE',2,'NUX474.jpg',4);
insert into TB_MEDICAMENTO values (default,'Balsamo para despuEs del afeitado NUXE Men','TRATAMIENTO FACIAL PARA DESPUES DEL AFEITADO HOMBRE - CALMANTE, HIDRATANTE 24H Todos los tipos de piel, incluso las sensibles El poder de los arboles para cuidar la piel de los hombres','  ','2019-11-12','2019-11-12','NUXE',2,'NUX475.jpg',4);
insert into TB_MEDICAMENTO values (default,'Contorno de ojos NUXE Men','CONTORNO DE OJOS MULTIFUNCIoN HOMBRE - ANTIBOLSAS, ANTIOJERAS, ANTIEDAD El poder de los arboles para cuidar la piel de los hombres','  ','2019-11-12','2019-11-12','NUXE',2,'NUX476.jpg',6);
insert into TB_MEDICAMENTO values (default,'Desodorante proteccion 24 h NUXE Men','DESODORANTE 24 H HOMBRE - NO DEJA MARCAS NI MANCHAS Para todos los tipos de piel El poder de los arboles para cuidar la piel de los hombres','  ','2019-11-12','2019-11-12','NUXE',2,'NUX477.jpg',23);
insert into TB_MEDICAMENTO values (default,'Gel de Afeitar Anti-irritaciones NUXE Men','GEL DE AFEITADO HOMBRE - ANTI-IRRITACIONES Para todos los tipos de piel, incluso las sensibles El poder de los arboles para cuidar la piel de los hombres','  ','2019-11-12','2019-11-12','NUXE',2,'NUX478.jpg',10);
insert into TB_MEDICAMENTO values (default,'Nuxuriance ultra noche','CREMA DE NOCHE REDENSIFICANTE ANTIEDAD GLOBAL Para todos los tipos de piel Tratamientos con texturas ricas para regenerar y redensificar la piel.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX479.jpg',10);
insert into TB_MEDICAMENTO values (default,'Serum Nuxuriance ultra','SERUM REDENSIFICANTE ANTIEDAD GLOBAL Para todos los tipos de piel Tratamientos con texturas ricas para regenerar y redensificar la piel.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX480.jpg',10);
insert into TB_MEDICAMENTO values (default,'Contorno de ojos y labios Nuxuriance ultra','CONTORNO DE OJOS Y LABIOS ANTIEDAD GLOBAL Para todos los tipos de piel Tratamientos con texturas ricas para regenerar y redensificar la piel.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX481.jpg',6);
insert into TB_MEDICAMENTO values (default,'Mascarilla Roll-on Nuxuriance ultra','MASCRILLA ROLL-ON REDENSIFICANTE ANTIEDAD GLOBAL Para todos los tipos de piel Tratamientos con texturas ricas para regenerar y redensificar la piel.','  ','2019-11-12','2019-11-12','NUXE',2,'NUX482.jpg',23);
insert into TB_MEDICAMENTO values (default,'Crema Limpiadora Exfoliante Reequilibrante','Exfoliante para el rostro BIO - Limpia la piel y elimina las impurezas Pieles mixtas con puntos negros y poros dilatados','  ','2019-11-12','2019-11-12','BIOBEAUTE BY NUXE',2,'NUX483.jpg',23);
insert into TB_MEDICAMENTO values (default,'Gel Exfoliante Suave Anti-contaminación BIO-BEAUTE','Exfoliante facial con extracto de uva blanca BIO Todos los tipos de piel','  ','2019-11-12','2019-11-12','BIOBEAUTE BY NUXE',2,'NUX484.jpg',23);
insert into TB_MEDICAMENTO values (default,'Gel Desmaquillante Anti-Contaminación BIO-BEAUTE','Gel de aceites desmaquillante con extracto de uva blanca y aceite de ciruela BIO Todos los tipos de piel','  ','2019-11-12','2019-11-12','BIOBEAUTE BY NUXE',2,'NUX485.jpg',5);
insert into TB_MEDICAMENTO values (default,'Espuma Limpiadora Anti-Contaminación BIO-BEAUTE','Espuma desmaquillante con extracto de uva blanca BIO Todos los tipos de piel','  ','2019-11-12','2019-11-12','BIOBEAUTE BY NUXE',2,'NUX486.jpg',5);
insert into TB_MEDICAMENTO values (default,'Agua Micelar Desmaquillante Anti-Contaminación BIO-BEAUTE','Agua Desmaquillante con extracto de uva blanca BIO Todos los tipos de piel','  ','2019-11-12','2019-11-12','BIOBEAUTE BY NUXE',2,'NUX487.jpg',5);
insert into TB_MEDICAMENTO values (default,'Desmaquillante de Ojos Bifásico Waterproof BIO-BEAUTE','Desmaquillante de Ojos con extracto de uva blanca BIO Todos los tipos de piel','  ','2019-11-12','2019-11-12','BIOBEAUTE BY NUXE',2,'NUX488.jpg',5);
insert into TB_MEDICAMENTO values (default,'Loción Reequilibrante Alisadora BIO-BEAUTÉ','Con Extracto de Arándano Para las pieles mixtas','  ','2019-11-12','2019-11-12','BIOBEAUTE BY NUXE',2,'NUX489.jpg',6);
insert into TB_MEDICAMENTO values (default,'Gel Limpiador Reequilibrante BIO-BEAUTÉ','Con Extracto de Arándano Para las pieles mixtas','  ','2019-11-12','2019-11-12','BIOBEAUTE BY NUXE',2,'NUX490.jpg',5);
insert into TB_MEDICAMENTO values (default,'Loción-tratamiento Detox Anti-contaminación y Luminosidad','TRATAMIENTO DETOXIFICANTES ROSTRO CON AGUA DE NARANJA Y PULPA DE ACEROLA Todos los tipos de piel','  ','2019-11-12','2019-11-12','BIOBEAUTE BY NUXE',2,'NUX491.jpg',6);
insert into TB_MEDICAMENTO values (default,'Exfoliante Suave Confort BIO-BEAUTÉ','EXFOLIANTE FACIAL CON FRUTOS ROJOS Todos los tipos de piel, incluso las sensibles','  ','2019-11-12','2019-11-12','BIOBEAUTE BY NUXE',2,'NUX492.jpg',23);


-------------------------LLENADO-DE-LA-TABLA-TB_FARMACIA_MEDICAMENTO------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into TB_FARMACIA_MEDICAMENTO values (4,1,100,9.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,2,150,10.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,3,300,11.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,4,100,12.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,5,150,13.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,6,200,14.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,7,250,15.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,8,300,16.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,9,100,17.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,10,150,18.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,11,200,19.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,12,250,20.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,13,300,21.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,14,100,22.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,15,150,23.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,16,200,4.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,17,250,5.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,18,300,6.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,19,100,7.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,20,150,8.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,21,200,9.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,22,250,10.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,23,300,11.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,24,100,12.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,25,150,13.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,26,200,14.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,27,250,15.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,28,300,16.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,29,100,17.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,30,150,18.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,31,200,19.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,32,250,20.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,33,300,21.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,34,100,22.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,35,150,23.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,36,200,24.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,37,250,25.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,38,300,26.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,39,100,27.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,40,150,14.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,41,200,15.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,42,250,16.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,43,300,17.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,44,100,18.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,45,150,19.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,46,200,20.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,47,250,21.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,48,300,22.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,49,100,23.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,50,150,24.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,51,200,25.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,52,250,26.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,53,300,27.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,54,100,28.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,55,150,29.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,56,200,30.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,57,250,31.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,58,300,32.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,59,100,33.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,60,150,34.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,61,200,35.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,62,250,19.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,63,300,20.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,64,100,21.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,65,150,22.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,66,200,23.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,67,250,24.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,68,300,25.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,69,100,26.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,70,150,27.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,71,200,28.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,72,250,29.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,73,300,7.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,74,100,8.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,75,150,9.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,76,200,10.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,77,250,11.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,78,300,12.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,79,100,13.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,80,150,14.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,81,200,15.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,82,250,16.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,83,300,17.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,84,100,18.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,85,150,19.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,86,200,20.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,87,250,21.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,88,300,22.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,89,100,23.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,90,150,24.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,91,200,25.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,92,250,26.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (4,93,300,27.00,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (13,32,100,21.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (13,33,150,22.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (13,34,200,23.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (13,35,250,24.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (13,36,300,25.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (13,37,100,26.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (13,38,150,27.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (13,39,200,28.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (13,40,250,15.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (13,41,300,16.50,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (9,22,100,11.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (9,23,150,12.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (9,24,200,13.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (9,25,250,14.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (9,26,300,15.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (9,27,100,16.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (9,28,150,17.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (9,29,200,18.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (9,30,250,19.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (9,31,300,20.01,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (21,62,100,20.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (21,63,150,21.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (21,64,200,22.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (21,65,250,23.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (21,66,300,24.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (21,67,100,25.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (21,68,150,26.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (21,69,200,27.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (21,70,250,28.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (21,71,300,29.01,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (22,62,100,20.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (22,63,150,21.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (22,64,200,22.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (22,65,250,23.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (22,66,300,24.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (22,67,100,25.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (22,68,150,26.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (22,69,200,27.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (22,70,250,28.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (22,71,300,29.50,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (18,52,100,27.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (18,53,150,28.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (18,54,200,29.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (18,55,250,30.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (18,56,300,31.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (18,57,100,32.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (18,58,150,33.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (18,59,200,34.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (18,60,250,35.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (18,61,300,36.01,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (24,72,100,30.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (24,73,150,8.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (24,74,200,9.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (24,75,250,10.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (24,76,300,11.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (24,77,100,12.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (24,78,150,13.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (24,79,200,14.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (24,80,250,15.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (24,81,300,16.01,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (10,22,100,11.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (10,23,150,12.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (10,24,200,13.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (10,25,250,14.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (10,26,300,15.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (10,27,100,16.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (10,28,150,17.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (10,29,200,18.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (10,30,250,19.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (10,31,300,10.50,"Euro");


insert into TB_FARMACIA_MEDICAMENTO values (6,12,100,21.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (6,13,150,22.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (6,14,200,23.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (6,15,250,24.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (6,16,300,5.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (6,17,100,6.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (6,18,150,7.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (6,19,200,8.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (6,20,250,9.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (6,21,300,10.01,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (19,52,100,27.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (19,53,150,28.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (19,54,200,29.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (19,55,250,30.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (19,56,300,31.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (19,57,100,32.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (19,58,150,33.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (19,59,200,34.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (19,60,250,35.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (19,61,300,36.50,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (15,42,100,17.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (15,43,150,18.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (15,44,200,19.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (15,45,250,20.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (15,46,300,21.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (15,47,100,22.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (15,48,150,23.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (15,49,200,24.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (15,50,250,25.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (15,51,300,26.01,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (27,82,100,17.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (27,83,150,18.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (27,84,200,19.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (27,85,250,20.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (27,86,300,21.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (27,87,100,22.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (27,88,150,23.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (27,89,200,24.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (27,90,250,25.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (27,91,300,26.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (27,92,180,27.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (27,93,280,28.01,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (11,32,100,21.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (11,33,150,22.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (11,34,200,23.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (11,35,250,24.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (11,36,300,25.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (11,37,100,26.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (11,38,150,27.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (11,39,200,28.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (11,40,250,15.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (11,41,300,16.00,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (20,62,100,20.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (20,63,150,21.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (20,64,200,22.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (20,65,250,23.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (20,66,300,24.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (20,67,100,25.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (20,68,150,26.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (20,69,200,27.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (20,70,250,28.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (20,71,300,29.00,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (2,1,100,10.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (2,2,150,11.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (2,3,200,12.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (2,4,250,13.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (2,5,300,14.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (2,6,100,15.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (2,7,150,16.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (2,8,200,17.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (2,9,250,18.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (2,10,300,19.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (2,11,180,20.01,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (12,32,100,21.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (12,33,150,22.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (12,34,200,23.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (12,35,250,24.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (12,36,300,25.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (12,37,100,26.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (12,38,150,27.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (12,39,200,28.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (12,40,250,15.01,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (12,41,300,16.01,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (16,42,100,17.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (16,43,150,18.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (16,44,200,19.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (16,45,250,20.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (16,46,300,21.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (16,47,100,22.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (16,48,150,23.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (16,49,200,24.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (16,50,250,25.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (16,51,300,26.50,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (8,22,100,11.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (8,23,150,12.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (8,24,200,13.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (8,25,250,14.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (8,26,300,15.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (8,27,100,16.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (8,28,150,17.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (8,29,200,18.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (8,30,250,19.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (8,31,300,20.00,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (14,42,100,17.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (14,43,150,18.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (14,44,200,19.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (14,45,250,20.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (14,46,300,21.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (14,47,100,22.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (14,48,150,23.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (14,49,200,24.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (14,50,250,25.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (14,51,300,26.00,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (5,12,100,21.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (5,13,150,22.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (5,14,200,23.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (5,15,250,24.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (5,16,300,5.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (5,17,100,6.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (5,18,150,7.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (5,19,200,8.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (5,20,250,9.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (5,21,300,10.00,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (26,82,100,17.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (26,83,150,18.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (26,84,200,19.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (26,85,250,20.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (26,86,300,21.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (26,87,100,22.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (26,88,150,23.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (26,89,200,24.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (26,90,250,25.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (26,91,300,26.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (26,92,180,27.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (26,93,280,28.00,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (7,12,100,21.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (7,13,150,22.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (7,14,200,23.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (7,15,250,24.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (7,16,300,5.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (7,17,100,6.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (7,18,150,7.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (7,19,200,8.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (7,20,250,9.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (7,21,300,10.50,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (23,72,100,30.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (23,73,150,8.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (23,74,200,9.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (23,75,250,10.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (23,76,300,11.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (23,77,100,12.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (23,78,150,13.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (23,79,200,14.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (23,80,250,15.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (23,81,300,16.00,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (1,1,100,10.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (1,2,150,11.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (1,3,200,12.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (1,4,250,13.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (1,5,300,14.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (1,6,100,15.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (1,7,150,16.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (1,8,200,17.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (1,9,250,18.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (1,10,300,19.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (1,11,180,20.00,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (25,72,100,30.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (25,73,150,8.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (25,74,200,9.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (25,75,250,10.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (25,76,300,11.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (25,77,100,12.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (25,78,150,13.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (25,79,200,14.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (25,80,250,15.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (25,81,300,16.50,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (28,82,100,17.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (28,83,150,18.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (28,84,200,19.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (28,85,250,20.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (28,86,300,21.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (28,87,100,22.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (28,88,150,23.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (28,89,200,24.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (28,90,250,25.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (28,91,300,26.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (28,92,180,27.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (28,93,280,28.50,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (17,52,100,27.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (17,53,150,28.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (17,54,200,29.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (17,55,250,30.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (17,56,300,31.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (17,57,100,32.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (17,58,150,33.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (17,59,200,34.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (17,60,250,35.00,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (17,61,300,36.00,"Euro");



insert into TB_FARMACIA_MEDICAMENTO values (3,1,100,10.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (3,2,150,11.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (3,3,200,12.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (3,4,250,13.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (3,5,300,14.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (3,6,100,15.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (3,7,150,16.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (3,8,200,17.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (3,9,250,18.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (3,10,300,19.50,"Euro");
insert into TB_FARMACIA_MEDICAMENTO values (3,11,180,20.50,"Euro");