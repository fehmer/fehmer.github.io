$('.nav a, .navbar-header a').on('click', function(){
    if($("#navbar-main").hasClass("in"))
      $(".navbar-toggle").click();
});


function scrollTo(hash){
  if(hash=='')return true;
  var to = $(hash).position().top;
  $('html, body').stop().animate({
        scrollTop: to+5
    }, 500);
  return false;
}

function init () {
  if ($(window).width() > 760){
    $(".start-center").click(function() {
      scrollTo('#about');
    });
    $('header').click(function(target){
      scrollTo(target.toElement.hash);
    });
    $('.top').click(function(target){
      return scrollTo(this.hash);
    });
  }
  
}


$(window).resize(function() {
  init();
});

$(function() {
    init();
});