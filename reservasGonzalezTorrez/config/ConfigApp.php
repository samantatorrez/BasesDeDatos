<?php
  class ConfigApp{
    public static $ACTION = "action";
    public static $PARAMS = "params";
    public static $ACTIONS = [
      '' => 'Controller#mostrarHome',
      'obtenerDepartamentos' => 'Controller#mostrarDepartamentos',
      'obtenerFechasDisponibles' => 'Controller#mostrarFechasDisponibles',
    ];
  }
 ?>
