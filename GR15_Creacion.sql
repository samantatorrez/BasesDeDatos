-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-06-22 10:32:05.265

-- tables
-- Table: GR15_Comentario
CREATE TABLE GR15_Comentario (
    tipo_doc int  NOT NULL,
    nro_doc decimal(11,0)  NOT NULL,
    id_reserva bigint  NOT NULL,
    fecha_hora_comentario date  NOT NULL,
    comentario varchar(2048)  NOT NULL,
    estrellas int  NOT NULL,
    CONSTRAINT PK_GR15_comentario PRIMARY KEY (tipo_doc,nro_doc,id_reserva,fecha_hora_comentario)
);

-- Table: GR15_Costo_Depto
CREATE TABLE GR15_Costo_Depto (
    id_dpto int  NOT NULL,
    fecha_desde date  NOT NULL,
    fecha_hasta date  NOT NULL,
    precio_noche decimal(10,2)  NOT NULL,
    CONSTRAINT PK_GR15_Costo_Dpto PRIMARY KEY (id_dpto,fecha_desde)
);

-- Table: GR15_Departamento
CREATE TABLE GR15_Departamento (
    id_dpto int  NOT NULL,
    descripcion varchar(80)  NOT NULL,
    superficie decimal(10,2)  NOT NULL,
    id_tipo_depto int  NOT NULL,
    tipo_doc int  NOT NULL,
    nro_doc decimal(11,0)  NOT NULL,
    precio_noche decimal(10,2)  NOT NULL,
    costo_limpieza decimal(10,2)  NOT NULL,
    CONSTRAINT PK_GR15_departamento PRIMARY KEY (id_dpto)
);

-- Table: GR15_Estado_Luego_Ocupacion_Reserva
CREATE TABLE GR15_Estado_Luego_Ocupacion_Reserva (
    fecha int  NOT NULL,
    id_reserva bigint  NOT NULL,
    comentario varchar(2048)  NOT NULL,
    limpiado boolean  NOT NULL,
    problemas_encontrados boolean  NOT NULL,
    CONSTRAINT PK_GR15_Estado_Luego_Ocupacion PRIMARY KEY (fecha,id_reserva)
);

-- Table: GR15_Habitacion
CREATE TABLE GR15_Habitacion (
    id_dpto int  NOT NULL,
    id_habitacion int  NOT NULL,
    posib_camas_simples int  NOT NULL,
    posib_camas_dobles int  NOT NULL,
    posib_camas_kind int  NOT NULL,
    tv boolean  NOT NULL,
    sillon int  NOT NULL,
    frigobar boolean  NOT NULL,
    mesa boolean  NOT NULL,
    sillas int  NOT NULL,
    cocina boolean  NOT NULL,
    escritorio int  NOT NULL,
    CONSTRAINT PK_GR15_habitacion PRIMARY KEY (id_dpto,id_habitacion)
);

-- Table: GR15_Huesped
CREATE TABLE GR15_Huesped (
    tipo_doc int  NOT NULL,
    nro_doc decimal(11,0)  NOT NULL,
    CONSTRAINT PK_GR15_huesped PRIMARY KEY (tipo_doc,nro_doc)
);

-- Table: GR15_Huesped_Reserva
CREATE TABLE GR15_Huesped_Reserva (
    tipo_doc int  NOT NULL,
    nro_doc decimal(11,0)  NOT NULL,
    id_reserva bigint  NOT NULL,
    CONSTRAINT PK_GR15_huesped_reserva PRIMARY KEY (tipo_doc,nro_doc,id_reserva)
);

-- Table: GR15_Pago
CREATE TABLE GR15_Pago (
    fecha_pago timestamp  NOT NULL,
    id_reserva bigint  NOT NULL,
    id_tipo_pago int  NOT NULL,
    comentario varchar(80)  NULL,
    importe decimal(10,2)  NOT NULL,
    CONSTRAINT PK_GR15_pago PRIMARY KEY (fecha_pago,id_reserva,id_tipo_pago)
);

-- Table: GR15_Persona
CREATE TABLE GR15_Persona (
    tipo_doc int  NOT NULL,
    nro_doc decimal(11,0)  NOT NULL,
    apellido varchar(80)  NOT NULL,
    nombre varchar(80)  NOT NULL,
    fecha_nac date  NOT NULL,
    e_mail varchar(80)  NOT NULL,
    CONSTRAINT GR15_Persona_e_mail UNIQUE (e_mail) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT PK_GR15_persona PRIMARY KEY (tipo_doc,nro_doc)
);

-- Table: GR15_Reserva
CREATE TABLE GR15_Reserva (
    id_reserva bigint  NOT NULL,
    fecha_reserva date  NOT NULL,
    fecha_desde date  NOT NULL,
    fecha_hasta date  NOT NULL,
    tipo varchar(15)  NOT NULL,
    id_dpto int  NOT NULL,
    valor_noche decimal(10,2)  NOT NULL,
    usa_limpieza smallint  NOT NULL,
    tipo_doc int  NOT NULL,
    nro_doc decimal(11,0)  NOT NULL,
    preferencias varchar(50)  NULL,
    CONSTRAINT CK_GR15_DURACION_RESERVA CHECK ((fecha_hasta - fecha_desde) >= 1) NOT DEFERRABLE INITIALLY IMMEDIATE,
    CONSTRAINT PK_GR15_reserva PRIMARY KEY (id_reserva)
);

-- Table: GR15_Tipo_Dpto
CREATE TABLE GR15_Tipo_Dpto (
    id_tipo_depto int  NOT NULL,
    cant_habitaciones int  NOT NULL,
    cant_banios int  NOT NULL,
    cant_max_huespedes int  NOT NULL,
    CONSTRAINT PK_GR15_Tipo_Dpto PRIMARY KEY (id_tipo_depto)
);

-- Table: GR15_Tipo_Pago
CREATE TABLE GR15_Tipo_Pago (
    id_tipo_pago int  NOT NULL,
    nombre varchar(80)  NOT NULL,
    CONSTRAINT PK_GR15_tipo_pago PRIMARY KEY (id_tipo_pago)
);

-- foreign keys
-- Reference: FK_GR15_Comentario_Huesped_Reserva (table: GR15_Comentario)
ALTER TABLE GR15_Comentario ADD CONSTRAINT FK_GR15_Comentario_Huesped_Reserva
    FOREIGN KEY (tipo_doc, nro_doc, id_reserva)
    REFERENCES GR15_Huesped_Reserva (tipo_doc, nro_doc, id_reserva)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR15_CostoDepto_Departamento (table: GR15_Costo_Depto)
ALTER TABLE GR15_Costo_Depto ADD CONSTRAINT FK_GR15_CostoDepto_Departamento
    FOREIGN KEY (id_dpto)
    REFERENCES GR15_Departamento (id_dpto)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR15_Departamento_Persona (table: GR15_Departamento)
ALTER TABLE GR15_Departamento ADD CONSTRAINT FK_GR15_Departamento_Persona
    FOREIGN KEY (tipo_doc, nro_doc)
    REFERENCES GR15_Persona (tipo_doc, nro_doc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR15_Departamento_Tipo_Dpto (table: GR15_Departamento)
ALTER TABLE GR15_Departamento ADD CONSTRAINT FK_GR15_Departamento_Tipo_Dpto
    FOREIGN KEY (id_tipo_depto)
    REFERENCES GR15_Tipo_Dpto (id_tipo_depto)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR15_Estado_Luego_Ocupacion_Reserva (table: GR15_Estado_Luego_Ocupacion_Reserva)
ALTER TABLE GR15_Estado_Luego_Ocupacion_Reserva ADD CONSTRAINT FK_GR15_Estado_Luego_Ocupacion_Reserva
    FOREIGN KEY (id_reserva)
    REFERENCES GR15_Reserva (id_reserva)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR15_Habitacion_Departamento (table: GR15_Habitacion)
ALTER TABLE GR15_Habitacion ADD CONSTRAINT FK_GR15_Habitacion_Departamento
    FOREIGN KEY (id_dpto)
    REFERENCES GR15_Departamento (id_dpto)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR15_Huesped_Persona (table: GR15_Huesped)
ALTER TABLE GR15_Huesped ADD CONSTRAINT FK_GR15_Huesped_Persona
    FOREIGN KEY (tipo_doc, nro_doc)
    REFERENCES GR15_Persona (tipo_doc, nro_doc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR15_Huesped_Reserva_Huesped (table: GR15_Huesped_Reserva)
ALTER TABLE GR15_Huesped_Reserva ADD CONSTRAINT FK_GR15_Huesped_Reserva_Huesped
    FOREIGN KEY (tipo_doc, nro_doc)
    REFERENCES GR15_Huesped (tipo_doc, nro_doc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR15_Huesped_Reserva_Reserva (table: GR15_Huesped_Reserva)
ALTER TABLE GR15_Huesped_Reserva ADD CONSTRAINT FK_GR15_Huesped_Reserva_Reserva
    FOREIGN KEY (id_reserva)
    REFERENCES GR15_Reserva (id_reserva)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR15_Pago_Reserva (table: GR15_Pago)
ALTER TABLE GR15_Pago ADD CONSTRAINT FK_GR15_Pago_Reserva
    FOREIGN KEY (id_reserva)
    REFERENCES GR15_Reserva (id_reserva)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR15_Pago_Tipo_Pago (table: GR15_Pago)
ALTER TABLE GR15_Pago ADD CONSTRAINT FK_GR15_Pago_Tipo_Pago
    FOREIGN KEY (id_tipo_pago)
    REFERENCES GR15_Tipo_Pago (id_tipo_pago)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR15_Reserva_Departamento (table: GR15_Reserva)
ALTER TABLE GR15_Reserva ADD CONSTRAINT FK_GR15_Reserva_Departamento
    FOREIGN KEY (id_dpto)
    REFERENCES GR15_Departamento (id_dpto)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR15_Reserva_Huesped (table: GR15_Reserva)
ALTER TABLE GR15_Reserva ADD CONSTRAINT FK_GR15_Reserva_Huesped
    FOREIGN KEY (tipo_doc, nro_doc)
    REFERENCES GR15_Huesped (tipo_doc, nro_doc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;
-- Inserts
INSERT INTO unc_247498.gr15_tipo_dpto(
	id_tipo_depto, cant_habitaciones, cant_banios, cant_max_huespedes)
	VALUES (1, 1, 1, 1);
INSERT INTO unc_247498.gr15_tipo_dpto(
	id_tipo_depto, cant_habitaciones, cant_banios, cant_max_huespedes)
	VALUES (2, 2, 2, 2);
INSERT INTO unc_247498.gr15_tipo_dpto(
	id_tipo_depto, cant_habitaciones, cant_banios, cant_max_huespedes)
	VALUES (3, 3, 3, 3);
INSERT INTO unc_247498.gr15_tipo_dpto(
	id_tipo_depto, cant_habitaciones, cant_banios, cant_max_huespedes)
	VALUES (4, 4, 4, 4);
INSERT INTO unc_247498.gr15_tipo_dpto(
	id_tipo_depto, cant_habitaciones, cant_banios, cant_max_huespedes)
	VALUES (5, 5, 5, 5);

INSERT INTO unc_247498.gr15_persona(
	tipo_doc, nro_doc, apellido, nombre, fecha_nac, e_mail)
	VALUES (1, 1, 'ana', 'franz', '1977-10-05', 'ana@gmail.com');
INSERT INTO unc_247498.gr15_persona(
	tipo_doc, nro_doc, apellido, nombre, fecha_nac, e_mail)
	VALUES (1, 2, 'belen', 'gianner', '1977-10-06', 'belen@gmail.com');
INSERT INTO unc_247498.gr15_persona(
	tipo_doc, nro_doc, apellido, nombre, fecha_nac, e_mail)
	VALUES (1, 3, 'celeste', 'hernandez', '1977-10-07', 'celeste@gmail.com');
INSERT INTO unc_247498.gr15_persona(
	tipo_doc, nro_doc, apellido, nombre, fecha_nac, e_mail)
	VALUES (2, 1, 'diana', 'ilia', '1977-10-08', 'diana@gmail.com');
INSERT INTO unc_247498.gr15_persona(
	tipo_doc, nro_doc, apellido, nombre, fecha_nac, e_mail)
	VALUES (2, 2, 'emilio', 'joanz', '1977-10-09', 'emilia@gmail.com');
INSERT INTO unc_247498.gr15_persona(
	tipo_doc, nro_doc, apellido, nombre, fecha_nac, e_mail)
	VALUES (2, 3, 'dian', 'johan', '1977-10-08', 'dian@gmail.com');
INSERT INTO unc_247498.gr15_persona(
	tipo_doc, nro_doc, apellido, nombre, fecha_nac, e_mail)
	VALUES (2, 4, 'elias', 'kuroshitsuji', '1977-10-09', 'elias@gmail.com');
INSERT INTO unc_247498.gr15_persona(
	tipo_doc, nro_doc, apellido, nombre, fecha_nac, e_mail)
	VALUES (2, 5, 'chise', 'koru', '1977-10-08', 'chise@gmail.com');

INSERT INTO unc_247498.gr15_departamento(
	id_dpto, descripcion, superficie, id_tipo_depto, tipo_doc, nro_doc, precio_noche, costo_limpieza)
	VALUES (1, 'a', 2, 1, 1, 1, 500, 100);
INSERT INTO unc_247498.gr15_departamento(
	id_dpto, descripcion, superficie, id_tipo_depto, tipo_doc, nro_doc, precio_noche, costo_limpieza)
	VALUES (2, 'b', 2, 2, 1, 2, 600, 200);
INSERT INTO unc_247498.gr15_departamento(
	id_dpto, descripcion, superficie, id_tipo_depto, tipo_doc, nro_doc, precio_noche, costo_limpieza)
	VALUES (3, 'c', 2, 3, 1, 3, 700, 250);
INSERT INTO unc_247498.gr15_departamento(
	id_dpto, descripcion, superficie, id_tipo_depto, tipo_doc, nro_doc, precio_noche, costo_limpieza)
	VALUES (4, 'd', 2, 4, 1, 1, 800, 300);
INSERT INTO unc_247498.gr15_departamento(
	id_dpto, descripcion, superficie, id_tipo_depto, tipo_doc, nro_doc, precio_noche, costo_limpieza)
	VALUES (5, 'e', 2, 5, 1, 2, 900, 350);

INSERT INTO unc_247498.gr15_costo_depto(
	id_dpto, fecha_desde, fecha_hasta, precio_noche)
	VALUES (1, '2017-10-05', '2017-11-05', 500);
INSERT INTO unc_247498.gr15_costo_depto(
	id_dpto, fecha_desde, fecha_hasta, precio_noche)
	VALUES (2, '2017-10-05', '2017-11-05', 501);
INSERT INTO unc_247498.gr15_costo_depto(
	id_dpto, fecha_desde, fecha_hasta, precio_noche)
	VALUES (3, '2017-10-05', '2017-11-05', 502);
INSERT INTO unc_247498.gr15_costo_depto(
	id_dpto, fecha_desde, fecha_hasta, precio_noche)
	VALUES (4, '2017-10-05', '2017-11-05', 503);
INSERT INTO unc_247498.gr15_costo_depto(
	id_dpto, fecha_desde, fecha_hasta, precio_noche)
	VALUES (5, '2017-10-05', '2017-11-05', 504);

INSERT INTO unc_247498.gr15_huesped(
	tipo_doc, nro_doc)
	VALUES (2, 1);
INSERT INTO unc_247498.gr15_huesped(
	tipo_doc, nro_doc)
	VALUES (2, 2);
INSERT INTO unc_247498.gr15_huesped(
	tipo_doc, nro_doc)
	VALUES (2, 3);
INSERT INTO unc_247498.gr15_huesped(
	tipo_doc, nro_doc)
	VALUES (2, 4);
INSERT INTO unc_247498.gr15_huesped(
	tipo_doc, nro_doc)
	VALUES (2, 5);

INSERT INTO unc_247498.gr15_reserva(
	id_reserva, fecha_reserva, fecha_desde, fecha_hasta, tipo, id_dpto, valor_noche, usa_limpieza, tipo_doc, nro_doc, preferencias)
	VALUES (1, '2017-10-05', '2017-10-05', '2017-10-07', 1, 1, 100, 1, 2, 1,null);
INSERT INTO unc_247498.gr15_reserva(
	id_reserva, fecha_reserva, fecha_desde, fecha_hasta, tipo, id_dpto, valor_noche, usa_limpieza, tipo_doc, nro_doc, preferencias)
	VALUES (2, '2017-10-05', '2017-10-05', '2017-10-08', 2, 2, 100, 1, 2, 2,null);
INSERT INTO unc_247498.gr15_reserva(
	id_reserva, fecha_reserva, fecha_desde, fecha_hasta, tipo, id_dpto, valor_noche, usa_limpieza, tipo_doc, nro_doc, preferencias)
	VALUES (3, '2017-10-05', '2017-10-05', '2017-10-09', 3, 3, 100, 1, 2, 3,null);
INSERT INTO unc_247498.gr15_reserva(
	id_reserva, fecha_reserva, fecha_desde, fecha_hasta, tipo, id_dpto, valor_noche, usa_limpieza, tipo_doc, nro_doc, preferencias)
	VALUES (4, '2017-10-05', '2017-10-05', '2017-10-10', 4, 4, 100, 1, 2, 1,null);
INSERT INTO unc_247498.gr15_reserva(
	id_reserva, fecha_reserva, fecha_desde, fecha_hasta, tipo, id_dpto, valor_noche, usa_limpieza, tipo_doc, nro_doc, preferencias)
	VALUES (5, '2017-10-05', '2017-10-05', '2017-10-13', 5, 5, 100, 1, 2, 2,null);
	
INSERT INTO unc_247498.gr15_estado_luego_ocupacion_reserva(
	fecha, id_reserva, comentario, limpiado, problemas_encontrados)
	VALUES (1, 1, 'asdf', true, false);
INSERT INTO unc_247498.gr15_estado_luego_ocupacion_reserva(
	fecha, id_reserva, comentario, limpiado, problemas_encontrados)
	VALUES (2, 2, 'asd', true, false);
INSERT INTO unc_247498.gr15_estado_luego_ocupacion_reserva(
	fecha, id_reserva, comentario, limpiado, problemas_encontrados)
	VALUES (3, 3, 'asd', true, false);
INSERT INTO unc_247498.gr15_estado_luego_ocupacion_reserva(
	fecha, id_reserva, comentario, limpiado, problemas_encontrados)
	VALUES (4, 4, 'asdf', false, true);
INSERT INTO unc_247498.gr15_estado_luego_ocupacion_reserva(
	fecha, id_reserva, comentario, limpiado, problemas_encontrados)
	VALUES (5, 5, 'asdf', false, true);

INSERT INTO unc_247498.gr15_tipo_pago(
	id_tipo_pago, nombre)
	VALUES (1, 'ab');
INSERT INTO unc_247498.gr15_tipo_pago(
	id_tipo_pago, nombre)
	VALUES (2, 'ac');
INSERT INTO unc_247498.gr15_tipo_pago(
	id_tipo_pago, nombre)
	VALUES (3, 'ad');
INSERT INTO unc_247498.gr15_tipo_pago(
	id_tipo_pago, nombre)
	VALUES (4, 'ae');
INSERT INTO unc_247498.gr15_tipo_pago(
	id_tipo_pago, nombre)
	VALUES (5, 'af');

INSERT INTO unc_247498.gr15_pago(
	fecha_pago, id_reserva, id_tipo_pago, comentario, importe)
	VALUES (now(), 1, 1, 'asdf', 500);
INSERT INTO unc_247498.gr15_pago(
	fecha_pago, id_reserva, id_tipo_pago, comentario, importe)
	VALUES (now(), 2, 2, 'asdf', 501);
INSERT INTO unc_247498.gr15_pago(
	fecha_pago, id_reserva, id_tipo_pago, comentario, importe)
	VALUES (now(), 3, 3, 'asdf', 502);
INSERT INTO unc_247498.gr15_pago(
	fecha_pago, id_reserva, id_tipo_pago, comentario, importe)
	VALUES (now(), 4, 4, 'asdf', 503);
INSERT INTO unc_247498.gr15_pago(
	fecha_pago, id_reserva, id_tipo_pago, comentario, importe)
	VALUES (now(), 5, 5, 'asdf', 504);

INSERT INTO unc_247498.gr15_huesped_reserva(
	tipo_doc, nro_doc, id_reserva)
	VALUES (2, 1, 1);
INSERT INTO unc_247498.gr15_huesped_reserva(
	tipo_doc, nro_doc, id_reserva)
	VALUES (2, 2, 2);
INSERT INTO unc_247498.gr15_huesped_reserva(
	tipo_doc, nro_doc, id_reserva)
	VALUES (2, 3, 3);
INSERT INTO unc_247498.gr15_huesped_reserva(
	tipo_doc, nro_doc, id_reserva)
	VALUES (2, 1, 4);
INSERT INTO unc_247498.gr15_huesped_reserva(
	tipo_doc, nro_doc, id_reserva)
	VALUES (2, 2, 5);

INSERT INTO unc_247498.gr15_comentario(
	tipo_doc, nro_doc, id_reserva, fecha_hora_comentario, comentario, estrellas)
	VALUES (1, 1, 1, '2018-09-15 20:53:48', 'malo', 1);
INSERT INTO unc_247498.gr15_comentario(
	tipo_doc, nro_doc, id_reserva, fecha_hora_comentario, comentario, estrellas)
	VALUES (1, 2, 2, '2018-09-15 20:53:48', 'malo', 2);
INSERT INTO unc_247498.gr15_comentario(
	tipo_doc, nro_doc, id_reserva, fecha_hora_comentario, comentario, estrellas)
	VALUES (1, 3, 3, '2018-09-15 20:53:48', 'bueno', 3);
INSERT INTO unc_247498.gr15_comentario(
	tipo_doc, nro_doc, id_reserva, fecha_hora_comentario, comentario, estrellas)
	VALUES (2, 1, 4, '2018-09-15 20:53:48', 'bueno', 4);
INSERT INTO unc_247498.gr15_comentario(
	tipo_doc, nro_doc, id_reserva, fecha_hora_comentario, comentario, estrellas)
	VALUES (2, 2, 5, '2018-09-15 20:53:48', 'excelente', 5);

INSERT INTO unc_247498.gr15_habitacion(
	id_dpto, id_habitacion, posib_camas_simples, posib_camas_dobles, posib_camas_kind, tv, sillon, frigobar, mesa, sillas, cocina, escritorio)
	VALUES (1, 1, 1, 2, 1, true, 1, false, true, 1, false, 1);
INSERT INTO unc_247498.gr15_habitacion(
	id_dpto, id_habitacion, posib_camas_simples, posib_camas_dobles, posib_camas_kind, tv, sillon, frigobar, mesa, sillas, cocina, escritorio)
	VALUES (2, 2, 2, 2, 1, true, 1, false, true, 1, false, 1);
INSERT INTO unc_247498.gr15_habitacion(
	id_dpto, id_habitacion, posib_camas_simples, posib_camas_dobles, posib_camas_kind, tv, sillon, frigobar, mesa, sillas, cocina, escritorio)
	VALUES (3, 3, 2, 2, 1, true, 1, false, true, 1, false, 1);
INSERT INTO unc_247498.gr15_habitacion(
	id_dpto, id_habitacion, posib_camas_simples, posib_camas_dobles, posib_camas_kind, tv, sillon, frigobar, mesa, sillas, cocina, escritorio)
	VALUES (4, 4, 2, 2, 1, false, 1, true, false, 1, true, 1);
INSERT INTO unc_247498.gr15_habitacion(
	id_dpto, id_habitacion, posib_camas_simples, posib_camas_dobles, posib_camas_kind, tv, sillon, frigobar, mesa, sillas, cocina, escritorio)
	VALUES (5, 5, 2, 2, 1, false, 1, true, false, 1, true, 1);
-- End of file.

