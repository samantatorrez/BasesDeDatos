<?php
session_start();
include_once(dirname(__DIR__).'/app/Model.php');
include_once(dirname(__DIR__).'/app/View.php');
class Controller
{
  protected $view;
  protected $model;
  protected $month;
  protected $params;
  public function __construct()
  {
    $this->params=array();
    $this->view = new View();
    $this->month = array();; // New object
    $this->month['Enero'] = 1;
    $this->month['Febrero'] = 2;
    $this->month['Marzo'] = 3;
    $this->month['Abril'] = 4;
    $this->month['Mayo'] = 5;
    $this->month['Junio'] = 6;
    $this->month['Julio'] = 7;
    $this->month['Agosto'] = 8;
    $this->month['Septiembre'] = 9;
    $this->month['Octubre'] = 10;
    $this->month['Noviembre'] = 11;
    $this->month['Diciembre'] = 12;
  }
  public function mostrarHome()
  {
    try {
      $this->view->mostrarHome();
    } catch (Exception $e){
      error_log( $e->getMessage());
    }
  }
  public function mostrarDepartamentos()
  {
    try {
      $_SESSION['host']=$_GET['host'];
      $_SESSION['port']=$_GET['port'];
      $_SESSION['database']=$_GET['database'];
      $_SESSION['user']=$_GET['user'];
      $_SESSION['password']=$_GET['password'];
      $this->model = new Model();
      $departamentos = $this->model->obtenerDepartamentos();
      $this->view->mostrarDepartamentos($departamentos);
    } catch (Exception $e){
      error_log( $e->getMessage());
    }
  }
  public function mostrarFechasDisponibles()
  {
    try {
      $this->model = new Model();
      $departamento = $_GET['departamento'];
      $mes = $_GET['mes'];
      $nro_mes= $this->month[$mes];
      $fechas = $this->model->obtenerFechasNoDisponibles($departamento,$nro_mes);
      $this->view->mostrarFechasDisponibles($departamento,$mes,$fechas);
    } catch (Exception $e){
      error_log( $e->getMessage());
    }
  }
}
 ?>
