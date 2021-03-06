$(document).ready(function() {

  addPhotoUpload();

  $('.task-form-icon-wrapper').click(function() {
    $(this).find('input:radio').prop("checked", true);
    $('.task-form-icon-wrapper').removeClass('selected-category');
    $(this).addClass('selected-category');
    if ($('#task_category_around_the_home').prop("checked") == true ) {
      $('#task_location').val('Home');
    } else {
      $('#task_location').val('');
    }
  });//end task form icon wrapper
  $('h3.card-title').click( function() {
    $(this).closest('.task-card').find('.task-details').slideToggle();
    $(this).find('.arrow').toggleClass('spin-180');
  });

  $(document).on("ajax:success", ".signup", function(e, data, status, xhr){
    // console.log(data)
    // console.log(status)
    $(this).text("Assignee: "+data.assignee_name);

  });
});

// Assigns the photo icon click event to the hidden input field next in the DOM.
function addPhotoUpload() {
  $('.fileSelect').off();  // clear previous click handlers if any
  $('.fileSelect').on('click', function (e) {
    e.preventDefault(); // prevent navigation to "#"
    var next = $(this).next(); // gets the next element, the form file input
    next.click();
  });
};