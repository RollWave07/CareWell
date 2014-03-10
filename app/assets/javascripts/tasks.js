$(document).ready(function() {

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

  //create an array of images that will randomly pick one if there aren't any tasks.

//   var randomPhoto = function () {

//     var randomPhotoIndex, photoArray;

//     randomPhotoIndex = Math.floor(Math.random() * 6);
//     photoArray = ['a','b','c','d','e'];
//     // return photoArray[randomPhotoIndex];
//     return 'pink-flower.png';
//   };


// });//end ready

//autocomplete for task location
//turn off for now because page movement is annoying
// $(function() {
//     var locationTags = [
//       "Restaurant",
//       "N/A",
//       "Home",
//       "Pharmacy",
//       "Drs. office",
//       "Park",
//       "Friends house",
//       "Online",
//       "Remote",
//       "Outside",
//       "Book Store",
//       "Downtown",
//       "Next door",
//       "Over the phone",
//     ];
//     $( "#task_location" ).autocomplete({
//         source: locationTags
//       });
//     });

//pop up the categories selection div.

// $('.pick-categories').on('click', function(){
//   $('.categories').fadeToggle();
// });

//when the icon is chosen (or a dismiss button is hit) then close the box.

// $('.task-form-icon-wrapper').on('click', function() {
//   replacementText = $(this).find('label').text();
//   $('.categories').fadeToggle();
//   $('#task_category').val(replacementText);
// })

//select a tab test

// $(document).ready(function() {
//   $('#opentasks').tab('show');
// });

// $(document).ready( function () {
//   $('.task-index-header h1').hover(
//     function() {
//       console.log('show');
//       $('.edit-indicator').show();
//     },
//     function(){
//       console.log('hide');
//       $('.edit-indicator').hide();
//     });


$(document).on("ajax:success", ".signup", function(e, data, status, xhr){
  // console.log(data)
  // console.log(status)
  $(this).text("Assignee: "+data.assignee_name);

  // console.log("#vote" + data.vote_id)
});

});
