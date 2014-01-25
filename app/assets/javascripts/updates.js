// $(document).on("ajax:success", function (e, data) {
//   console.log("Ajax Response data:", data);
// });

// $(".add_update").on("click", function (e) {
//   e.preventDefault();
//   console.log("click");
//   $(".update_comment").text("");
// });

// THIS ONE:

$(document).on("ajax:success", ".col-md-3", function(e, data, status, xhr){
  // console.log(data)
  // console.log(status)
  console.log(this)
  $("#vote" + data.vote_id).text(data.count);
  $(this).find("span").toggleClass( "active-glyphicon-heart" );
  // console.log("#vote" + data.vote_id)
});

// STOP

// $(".button_to").on("ajax:success", function(e, data, status, xhr){
//   // console.log(data)
//   // console.log(status)
//   $("#vote" + data.vote_id).text(data.count);
//   // console.log("#vote" + data.vote_id)
// });)


// $(".row").on("ajax:success", function(e, data, status, xhr){
//   $("#update"+data.update).remove();
// });


// $("body").on("ajax:success", function(e, data, status, xhr){
//   switch (type){
//     case "delete":

//     case "vote":
//   }

// });