window.onbeforeunload = function (){
  alert("I will do cleanup here");
  $.ajax({
    url: '/clearSession',
    type: "POST",
    data: {},
    contentType: "application/json; charset=utf-8",
    dataType: "json"
  });
};