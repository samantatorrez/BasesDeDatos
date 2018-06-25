<?php
define('ACTION', 0);
define('PARAMS', 1);
require 'vendor/autoload.php';
include_once 'config/ConfigApp.php';
include_once 'app/Controller.php';

use reservasTorrezGonzalez\Connection as Connection;
/*
try {
    Connection::get()->connect();
    echo 'A connection to the PostgreSQL database sever has been established successfully.';
} catch (\PDOException $e) {
    echo $e->getMessage();
}*/
function parseURL($url)
{
  $urlExploded = explode('/', $url);
  $arrayReturn[ConfigApp::$ACTION] = $urlExploded[ACTION];
  $arrayReturn[ConfigApp::$PARAMS] = isset($urlExploded[PARAMS]) ? array_slice($urlExploded,1) : null;
  return $arrayReturn;
}

ini_set("log_errors", 1);
ini_set("error_log", "tmp/php-error.log");

try{
  if(isset($_GET['action'])){
    $urlData = parseURL($_GET['action']);
    $action = $urlData[ConfigApp::$ACTION]; //home
    if(array_key_exists($action,ConfigApp::$ACTIONS)){
      $params = $urlData[ConfigApp::$PARAMS];
      $action = explode('#',ConfigApp::$ACTIONS[$action]); //toma lo que esta despues del #
      $controller =  new $action[0]();
      $metodo = $action[1];
      if(isset($params) &&  $params != null){
        echo $controller->$metodo($params);
      }
      else{
        echo $controller->$metodo();
      }
    }
  }
}
catch (Exception $e){
    error_log( $e->getMessage());
}
 ?>
