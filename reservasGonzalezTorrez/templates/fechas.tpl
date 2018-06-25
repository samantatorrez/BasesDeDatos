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
              <h3 class="pb-3">{$mensaje}</h3>
              <div id='calendar'></div>
              <button type="button" onclick="goBack()" name="volver">Volver</button>
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
  <script src="libs/jquery.js"></script>
  <script src="libs/bootstrap/js/bootstrap.js"></script>
  <script src="libs/moment.min.js"></script>
  <script src="libs/fullcalendar.js"></script>
  <script src="js/reservas.js"></script>
  <script type="text/javascript">
  $('#calendar').fullCalendar({
          events: [
          {foreach from=$fechas item=fecha}
              {
               start: '{$fecha['fecha_desde']}',
               end: '{$fecha['fecha_hasta']}',
               rendering: 'background'
             },
          {/foreach}
          ]
      });
  </script>
</body>

</html>
