function goBack() {
    window.history.back();
}

$( document ).ready(function() {
  const NUMERO_INSTANTANEOS = 3;
  const BASE_URI = "/reservasTorrezGonzalez/";
  const GET_DEPARTAMENTOS= "obtenerDepartamentos";

function obtenerDepartamentos() {
    $.ajax(
      {
        url: BASE_URI + GET_DEPARTAMENTOS,
        type: "GET",
        dataType : "HTML",
        success : function(data, textStatus) {
            $("html").html(data);
          //  $("#disponibilidadForm").attr('action','google.com');
        },
        error: function(jqxml, status, errorThrown){
          console.log(errorThrown);
        }
      }
    );
};
});
