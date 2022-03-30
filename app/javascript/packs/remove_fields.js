$(document).ready(function(){
  var next = 1;
  $(".remove-home").click(function(e){
    $(this).parent().parent().remove();
  });
  $(".remove-guest").click(function(e){
    $(this).parent().parent().parent().remove();
  });
});
