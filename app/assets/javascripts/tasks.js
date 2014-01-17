$('.task-form-icon-wrapper').click(function() {
  $(this).find(':radio').prop("checked", true);
  $('.task-form-icon-wrapper').removeClass('selected-category');
  $(this).addClass('selected-category');
});

// $('.task-form-icon-wrapper').click(function() {
//   $(this).removeClass('selected-category');
// });