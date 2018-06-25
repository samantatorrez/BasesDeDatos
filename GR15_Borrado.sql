-----------------------------BORRADO DE VISTAS---------------------
DROP VIEW gr15_departamentos_con_recaudacion;

DROP VIEW gr15_departamentos_por_ciudad_y_rating;


----------------------------BORRADO DE SERVICIOS---------------------
DROP FUNCTION pr_gr15_obtener_estado_departamento(date);

DROP FUNCTION pr_gr15_obtener_departamentos_disponibles(date, date, character varying);


--------------------------BORRADO DE RESTRICCIONES---------------------
DROP FUNCTION trfn_gr15_validar_cantidad_habitaciones() CASCADE;

DROP FUNCTION trfn_gr15_validar_que_no_es_propietario_y_huesped() CASCADE;

DROP FUNCTION trfn_gr15_validar_que_no_es_propietario_y_reservador() CASCADE;

DROP FUNCTION trfn_gr15_validar_que_no_supere_el_max_de_huespedes() CASCADE;


----------------------------BORRADO DE TABLAS------------------------
DROP TABLE gr15_comentario CASCADE;

DROP TABLE gr15_costo_depto CASCADE;

DROP TABLE gr15_departamento CASCADE;

DROP TABLE gr15_estado_luego_ocupacion_reserva CASCADE;

DROP TABLE gr15_habitacion CASCADE;

DROP TABLE gr15_huesped CASCADE;

DROP TABLE gr15_huesped_reserva CASCADE;

DROP TABLE gr15_pago CASCADE;

DROP TABLE gr15_persona CASCADE;

DROP TABLE gr15_reserva CASCADE;

DROP TABLE gr15_tipo_dpto CASCADE;

DROP TABLE gr15_tipo_pago CASCADE;