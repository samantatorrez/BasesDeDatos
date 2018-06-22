$('#buscar').on('click',function() {
		let thisMes = $('#month').val();
		showMonth(thisMes);
});

function showMonth(thisMes) {
  let month = new Array();
  month[0] = "Enero";
  month[1] = "Febrero";
  month[2] = "Marzo";
  month[3] = "Abril";
  month[4] = "Mayo";
  month[5] = "Junio";
  month[6] = "Julio";
  month[7] = "Agosto";
  month[8] = "Septiembre";
  month[9] = "Octubre";
  month[10] = "Noviembre";
  month[11] = "Diciembre";

  let d = new Date();
  let mes = thisMes;
  let n = month[mes];
  document.getElementById("month_name").innerHTML = n;
  let startDates = moment([2018,mes,1]);
  let lastDay = startDates.daysInMonth();
  let numDia = 1;
  for(semana = 0; semana < 6; semana++){
    for(dia = 0; dia < 7; dia++){
      let diaSemana = moment([2018,mes,numDia])._d.getDay();
      if(diaSemana == dia && numDia <= lastDay){
        document.getElementById(""+semana+dia).innerHTML = numDia;
        numDia++;
      }
    }
  }
}
