$('.task-form-icon-wrapper').click(function() {
  $(this).find(':radio').prop("checked", true);
  $('.task-form-icon-wrapper').removeClass('selected-category');
  $(this).addClass('selected-category');
});


//autocomplete for task location
$(function() {
    var locationTags = [
      "Restaurant",
      "N/A",
      "Home",
      "Pharmacy",
      "Drs. office",
      "Park",
      "Friends house",
      "Online",
      "Remote",
      "Outside",
      "Book Store",
      "Downtown",
      "Next door",
      "Over the phone",
    ];
    $( "#task_location" ).autocomplete({
        source: locationTags
      });
    });

//pop up the categories selection div.

$('.pick-categories').on('click', function(){
  $('.categories').fadeToggle();
});

//when the icon is chosen (or a dismiss button is hit) then close the box.

$('.task-form-icon-wrapper').on('click', function() {
  replacementText = $(this).find('label').text();
  $('#task_title').val(replacementText);
  $('.categories').fadeToggle();
  $('#category').val(replacementText);
})


    $("#task_task_date").datepicker();


$(document).on("ajax:success", ".signup", function(e, data, status, xhr){
  // console.log(data)
  // console.log(status)
  $(this).text("Assignee: "+data.assignee_name);

  // console.log("#vote" + data.vote_id)
});
