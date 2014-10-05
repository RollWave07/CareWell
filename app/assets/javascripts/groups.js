$(document).ready(function() {
    //edit the group name in place
    $('.best_in_place').best_in_place();

    $('#charts a').click(function (e) {
      e.preventDefault()
      $(this).tab('show');
      });

    $(".message-new").click(function(e) {
      $("#conf-message-form").slideToggle(200);
    });
});//end ready

