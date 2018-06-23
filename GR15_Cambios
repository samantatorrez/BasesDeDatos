-- Agrega constraint para que la fecha en la que se hizo reserva sea menor o igual a cuando comienza la reserva
ALTER TABLE GR15_RESERVA ADD CONSTRAINT CK_GR15_CONSISTENCIA_FECHA_RESERVA CHECK (fecha_desde>= fecha_reserva);

-- Si se agrega una habitación para un departamento, no puede ser mayor a la cantidad que está establecido en tipo de departamento.
CREATE OR REPLACE FUNCTION FN_GR15_VALIDAR_CANTIDAD_HABITACIONES() 
RETURNS trigger AS 
$$
BEGIN 
	IF EXISTS (SELECT d.id_dpto, t.cant_habitaciones,COUNT(*)
				FROM GR15_DEPARTAMENTO d 
					LEFT JOIN GR15_TIPO_DPTO t ON t.id_tipo_depto = d.id_tipo_depto
					LEFT JOIN   GR15_HABITACION h ON d.id_dpto = h.id_dpto
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

--

