----------------------------------------------------------RESTRICCIONES------------------------------------------------

-----------------------------------RESTRICCIONES INCISO A
-- Agrega constraint para que la fecha en la que se hizo reserva sea menor o igual a cuando comienza la reserva
ALTER TABLE GR15_RESERVA ADD CONSTRAINT CK_GR15_CONSISTENCIA_FECHA_RESERVA CHECK (fecha_desde>= fecha_reserva);

/*--ERROR ck_gr15_duracion_reserva. El constraint chequea que fecha_desde < fecha_hasta y el periodo minimo es de 1 dia
INSERT INTO gr15_reserva(
	id_reserva, fecha_reserva, fecha_desde, fecha_hasta, tipo, id_dpto, valor_noche, usa_limpieza, tipo_doc, nro_doc, preferencias)
	VALUES (6, '2017-10-05', '2017-10-09', '2017-10-07', 1, 1, 100, 1, 1, 1,null);
*/
/*--ERROR ck_gr15_consistencia_fecha_reserva. El constraint chequea que fecha_reserva <=fecha_desde.
INSERT INTO gr15_reserva(
	id_reserva, fecha_reserva, fecha_desde, fecha_hasta, tipo, id_dpto, valor_noche, usa_limpieza, tipo_doc, nro_doc, preferencias)
	VALUES (6, '2017-10-06', '2017-10-05', '2017-10-07', 1, 1, 100, 1, 1, 1,null);
*/



-----------------------------------RESTRICCIONES INCISO B
-- Si se agrega una habitación para un departamento, no puede ser mayor a la cantidad que está establecido en tipo de departamento.
-- necesito un trigger cuando se updatea id_tipo_depto que si tiene pone menos piesas de las que tiene alerte tambien                                                                                                                                                                                                                                                                                                                                                                                  
CREATE OR REPLACE FUNCTION FN_GR15_VALIDAR_CANTIDAD_HABITACIONES() 
RETURNS trigger AS 
$$
BEGIN 
	IF EXISTS (SELECT d.id_dpto, t.cant_habitaciones,COUNT(*)
				FROM GR15_DEPARTAMENTO d 
					INNER JOIN GR15_TIPO_DPTO t ON t.id_tipo_depto = d.id_tipo_depto
					INNER JOIN   GR15_HABITACION h ON d.id_dpto = h.id_dpto
				GROUP BY d.id_dpto, t.cant_habitaciones
				HAVING d.id_dpto = NEW.id_dpto AND t.cant_habitaciones < COUNT(*) +1)
	THEN 
	 raise exception 'No puede haber mas habitaciones de las creadas para este tipo de departamento';
	END IF; 
	return new; 
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER GR15_HABITACION_VALIDAR_CANTIDAD_HABITACIONES BEFORE INSERT ON GR15_HABITACION
FOR EACH ROW
EXECUTE PROCEDURE FN_GR15_VALIDAR_CANTIDAD_HABITACIONES() ;

/*--Prueba para 'No puede haber mas habitaciones de las creadas para este tipo de departamento'
INSERT INTO gr15_habitacion(
	id_dpto, id_habitacion, posib_camas_simples, posib_camas_dobles, posib_camas_kind, tv, sillon, frigobar, mesa, sillas, cocina, escritorio)
	VALUES (1, 8, 1, 2, 1, true, 1, false, true, 1, false, 1);
*/




-----------------------------------RESTRICCIONES INCISO C
CREATE OR REPLACE FUNCTION FN_GR15_VALIDAR_QUE_NO_ES_PROPIETARIO_Y_RESERVADOR() 
RETURNS trigger AS 
$$
BEGIN 
	IF EXISTS (SELECT 1
				FROM GR15_DEPARTAMENTO d
					INNER JOIN GR15_RESERVA r ON r.id_dpto = d.id_dpto
				WHERE  (d.id_dpto = NEW.id_dpto AND d.nro_doc = NEW.nro_doc AND d.tipo_doc = NEW.tipo_doc))
	THEN 
	 raise exception 'El propietario del departamento no puede reservarlo';
	END IF; 
	return new; 
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER GR15_RESERVA_VALIDAR_QUE_NO_ES_PROPIETARIO_Y_RESERVADOR BEFORE INSERT OR UPDATE ON GR15_RESERVA
FOR EACH ROW
EXECUTE PROCEDURE FN_GR15_VALIDAR_QUE_NO_ES_PROPIETARIO_Y_RESERVADOR() ;

/* --Pruebas para 'El propietario del departamento no puede reservarlo'
INSERT INTO gr15_reserva(
	id_reserva, fecha_reserva, fecha_desde, fecha_hasta, tipo, id_dpto, valor_noche, usa_limpieza, tipo_doc, nro_doc, preferencias)
	VALUES (10, '2017-10-05', '2017-10-05', '2017-10-07', 1, 1, 100, 1, 1, 1,null);
UPDATE gr15_reserva
	SET tipo_doc=1, nro_doc=1
	WHERE id_reserva=1;
*/




-----------------------------------RESTRICCIONES INCISO C
CREATE OR REPLACE FUNCTION FN_GR15_VALIDAR_QUE_NO_ES_PROPIETARIO_Y_HUESPED() 
RETURNS trigger AS 
$$
BEGIN 
	IF EXISTS (SELECT 1
				FROM GR15_DEPARTAMENTO d
					INNER JOIN GR15_RESERVA r ON r.id_dpto = d.id_dpto
					INNER JOIN GR15_HUESPED_RESERVA h ON r.id_reserva = h.id_reserva 
				WHERE  (r.id_reserva = NEW.id_reserva AND d.nro_doc = NEW.nro_doc AND d.tipo_doc = NEW.tipo_doc))
	THEN 
	 raise exception 'El propietario del departamente no puede ser huesped de la reserva';
	END IF; 
	return new; 
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER GR15_HUESPED_VALIDAR_QUE_NO_ES_PROPIETARIO_Y_HUESPED BEFORE INSERT OR UPDATE ON GR15_HUESPED_RESERVA
FOR EACH ROW
EXECUTE PROCEDURE FN_GR15_VALIDAR_QUE_NO_ES_PROPIETARIO_Y_HUESPED() ;

/* ERROR: 'El propietario del departamente no puede ser huesped de la reserva'
INSERT INTO gr15_huesped_reserva(
	tipo_doc, nro_doc, id_reserva)
	VALUES (1, 1, 1);
UPDATE gr15_huesped_reserva
	SET tipo_doc=1, nro_doc=1
	WHERE id_reserva=1;
*/


----------------------------------------------------------SERVICIOS------------------------------------------------


----------------------------------------------------------VISTAS------------------------------------------------
CREATE OR REPLACE VIEW GR15_DPTOSXRATING 
	AS SELECT d.*, c.estrellas
	FROM gr15_reserva r, gr15_departamento d, gr15_comentario c
	WHERE r.id_dpto = d.id_dpto
	  AND r.id_reserva = c.id_reserva
	ORDER BY d.ciudad, c.estrellas DESC;


CREATE OR REPLACE VIEW GR15_RecaudacionDptos 
	AS SELECT id_dpto, SUM(importe)
	FROM gr15_reserva r JOIN gr15_pago p
	       ON (r.id_reserva = p.id_reserva)
	WHERE fecha_pago > (current_date - 180)
	GROUP BY id_dpto
