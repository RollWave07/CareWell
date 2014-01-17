// $(document).on("ajax:success", function (e, data) {
//   console.log("Ajax Response data:", data);
// });

// $(".add_update").on("click", function (e) {
//   e.preventDefault();
//   console.log("click");
//   $(".update_comment").text("");
// });

$(".button_to").on("ajax:success", function(e, data, status, xhr){
  console.log(data)
  $("#vote" + data.vote_id).text(data.count);
  console.log("#vote" + data.vote_id)
});
