<?php
  require_once 'libs/smarty/Smarty.class.php';

  class View
  {
    protected $smarty;

    function __construct()
    {
      $this->smarty = new Smarty();
    }
    function mostrarHome()
    {
      $this->smarty->display('home.tpl');
    }
    function mostrarDepartamentos($departamentos)
    {
      $this->smarty->assign('departamentos', $departamentos);
      $this->smarty->display('departamentos.tpl');
    }
    function mostrarFechasDisponibles($departamento,$mes,$fechas)
    {
      $mensaje= 'Fechas disponibles. Departamento:'.$departamento.' Mes:'.$mes;
      $this->smarty->assign('mensaje', $mensaje);
      $this->smarty->assign('fechas', $fechas);
      $this->smarty->display('fechas.tpl');
    }
  }


?>
