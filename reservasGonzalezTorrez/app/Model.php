<?php
use reservasGonzalezTorrez\Connection as Connection;
class Model
{
  private $db;
  function __construct()
  {
    try {
        $this->db = Connection::get()->connect();
    } catch (\PDOException $e) {
        error_log( $e->getMessage());
    }
  }
  function obtenerDepartamentos()
  {
    $sql  = 'SELECT id_dpto FROM gr15_departamento';
    $sentencia = $this->db->prepare($sql);
    $sentencia->execute();
    return $sentencia->fetchAll(PDO::FETCH_ASSOC);
  }
  function obtenerFechasNoDisponibles($departamento,$nro_mes)
  {
    $sql  = 'SELECT fecha_desde, fecha_hasta FROM gr15_reserva '
            .'WHERE id_dpto=:id_dpto AND (EXTRACT(MONTH FROM fecha_desde)=:mes OR EXTRACT(MONTH FROM fecha_hasta)=:mes)';
    $sentencia = $this->db->prepare($sql);
    $sentencia->execute(array(":id_dpto"=>$departamento, ":mes"=>$nro_mes));
    return $sentencia->fetchAll(PDO::FETCH_ASSOC);
  }
}
 ?>
