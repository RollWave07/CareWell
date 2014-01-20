$('.task-form-icon-wrapper').click(function() {
  $(this).find(':radio').prop("checked", true);
  $('.task-form-icon-wrapper').removeClass('selected-category');
  $(this).addClass('selected-category');
});

// $.datepicker.setDefaults({
//   showOn: "both",
//   buttonImageOnly: true,
//   buttonImage: "calendar.gif",
//   buttonText: "Calendar"
// });

// $.datepicker.formatDate( "yy-mm-dd", new Date( 2007, 1 - 1, 26 ) );

// $("#task_duration").datepicker();
// $('.task-form-icon-wrapper').click(function() {
//   $(this).removeClass('selected-category');
// });