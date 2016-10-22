$(window).scroll(function () {
  if ($(window).scrollTop() > 100) {
      $('.header').addClass("header--is-opaque");
  }
  else{
      $('.header').removeClass("header--is-opaque");
  }
});
