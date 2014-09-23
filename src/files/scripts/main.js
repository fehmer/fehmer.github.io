$('.nav a').on('click', function(){
    if($("#navbar-main").hasClass("in"))
      $(".navbar-toggle").click();
});