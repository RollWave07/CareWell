$('.task-form-icon-wrapper').click(function() {
  $(this).find(':radio').prop("checked", true);
  $('.task-form-icon-wrapper').removeClass('selected-category');
  $(this).addClass('selected-category');
});

// $('.task-form-icon-wrapper').click(function() {
//   $(this).removeClass('selected-category');
// });

// $.datepicker.setDefaults({
//   showOn: "both",
//   buttonImageOnly: true,
//   buttonImage: "calendar.gif",
//   buttonText: "Calendar"
// });

// $.datepicker.formatDate( "yy-mm-dd", new Date( 2007, 1 - 1, 26 ) );

    $("#task_task_date").datepicker();

// $('.task-form-icon-wrapper').click(function() {
//   $(this).removeClass('selected-category');
// });


// $(".signup").on("click", function(e, task){
//   console.log("hello");
//   // console.log(status)
//   // $(this).remove();
//   $(this).text("Assignee: #{task.assignee.first_name}");
//   // console.log("#vote" + data.vote_id)
// });

$(document).on("ajax:success", ".signup", function(e, data, status, xhr){
  // console.log(data)
  // console.log(status)
  $(this).text("Assignee: "+data.assignee_name);

  // console.log("#vote" + data.vote_id)
});
