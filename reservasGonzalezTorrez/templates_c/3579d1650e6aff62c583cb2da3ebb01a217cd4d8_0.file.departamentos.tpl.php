<?php
/* Smarty version 3.1.30, created on 2018-06-25 08:09:58
  from "C:\xampp\htdocs\reservasTorrezGonzalez\templates\departamentos.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.30',
  'unifunc' => 'content_5b3087365ea112_50633067',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '3579d1650e6aff62c583cb2da3ebb01a217cd4d8' => 
    array (
      0 => 'C:\\xampp\\htdocs\\reservasTorrezGonzalez\\templates\\departamentos.tpl',
      1 => 1529906281,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_5b3087365ea112_50633067 (Smarty_Internal_Template $_smarty_tpl) {
?>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="css/reservas.css" type="text/css">
  <link rel='stylesheet' type='text/css' href='css/fullcalendar.css' />
  <link rel="stylesheet" href="libs/bootstrap/css/bootstrap.css" type="text/css"> </head>
<body>
  <div class="py-5" style="background-image: url('img/form_red.jpg');">
    <div class="container">
      <div class="row">
        <div class="align-self-center col-md-6 text-white">
          <h1 class="text-center text-md-left display-3">Reservaciones</h1>
          <p class="lead">Why waiting if you can do it online?</p>
        </div>
        <div class="col-md-6" id="book">
          <div class="card">
            <div class="card-body p-5">
              <h3 class="pb-3">Buscar fechas disponibles</h3>
              <form action="obtenerFechasDisponibles" id="disponibilidadForm">
                <div class="form-group"> <label>Departamento</label> <select class="form-control" id="departamentos" name="departamento">
                  <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['departamentos']->value, 'dep');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['dep']->value) {
?>
                  <option value= <?php echo $_smarty_tpl->tpl_vars['dep']->value['id_dpto'];?>
><?php echo $_smarty_tpl->tpl_vars['dep']->value['id_dpto'];?>
</option>
                  <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl);
?>

                  </select>
                  <div class="form-group"> <label>Mes</label> <select class="form-control" id="meses" name="mes">
                    <option>Enero</option>
                    <option>Febrero</option>
                    <option>Marzo</option>
                    <option>Abril</option>
                    <option>Mayo</option>
                    <option>Junio</option>
                    <option>Julio</option>
                    <option>Agosto</option>
                    <option>Septiembre</option>
                    <option>Octubre</option>
                    <option>Noviembre</option>
                    <option>Diciembre</option>
                  </select>
                    <button type="submit" class="btn mt-2 btn-outline-dark">Enviar</button>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
  <div class="py-5 bg-dark text-white">
    <div class="container">
      <div class="row">
        <div class="col-md-9">
          <p class="lead">Sign up to our newsletter for the latest news</p>
          <form class="form-inline">
            <div class="form-group">
              <input type="email" class="form-control" placeholder="Your e-mail here"> </div>
            <button type="submit" class="btn btn-primary ml-3">Subscribe</button>
          </form>
        </div>
        <div class="col-4 col-md-1 align-self-center">
          <a href="https://www.facebook.com" target="_blank"><i class="fa fa-fw fa-facebook fa-3x text-white"></i></a>
        </div>
        <div class="col-4 col-md-1 align-self-center">
          <a href="https://twitter.com" target="_blank"><i class="fa fa-fw fa-twitter fa-3x text-white"></i></a>
        </div>
        <div class="col-4 col-md-1 align-self-center">
          <a href="https://www.instagram.com" target="_blank"><i class="fa fa-fw fa-instagram text-white fa-3x"></i></a>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12 mt-3 text-center">
          <p>© Copyright 2017 ABCDEFGH.</p>
        </div>
      </div>
    </div>
  </div>
  <?php echo '<script'; ?>
 src="libs/jquery.js"><?php echo '</script'; ?>
>
  <?php echo '<script'; ?>
 src="libs/bootstrap/js/bootstrap.js"><?php echo '</script'; ?>
>
  <?php echo '<script'; ?>
 src="libs/moment.min.js"><?php echo '</script'; ?>
>
  <?php echo '<script'; ?>
 src="libs/fullcalendar.js"><?php echo '</script'; ?>
>
  <?php echo '<script'; ?>
 src="js/reservas.js"><?php echo '</script'; ?>
>
</body>

</html>
<?php }
}
