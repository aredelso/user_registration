$(document).ready(function(){
  $(".register").hide();
  $("#register_show").click(function(){
    $(".login").hide();
    $(".register").show();
  });
  $("#login_show").click(function(){
    $(".register").hide();
    $(".login").show();
  });
});