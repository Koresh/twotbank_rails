  $('.js-scroll-navigate').click(function(){
    var hash=$(this).attr('href');
    if($(hash).length>0){
      $('html,body').animate({scrollTop:$(hash).offset().top-50},500);
    }
    return false;
  })

  $("#link-scroll-top").on("click",function(e){
    e.preventDefault()
    $('html,body').animate({scrollTop:0}, 300);
  });