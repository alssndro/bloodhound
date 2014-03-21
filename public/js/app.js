$("#search-toggle").click(function(){
  $("#search-toggle").slideUp(function(){
    $(".search-box").slideToggle();
    $(".search-btn").slideToggle();
  });
});