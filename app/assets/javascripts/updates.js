

$(document).on("ajax:success", ".like-it-now", function(e, data, status, xhr){
  $("#vote" + data.vote_id).text(data.count);
  $(this).find("span").toggleClass( "active-glyphicon-heart" );
  // console.log("#vote" + data.vote_id)
});

$(document).ready( function() {
  $('.choose-photo').on('click',function (){
    console.log("clicked");
    $('input#update_picture').click();
  });//end click
})//end ready