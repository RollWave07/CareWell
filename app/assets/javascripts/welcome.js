$(document).ready(function() {

  // ajax request to get list of already taken emails
  var emailAvailable = '';
  $('.register-form input#user_email').on('blur', function() {
    var emailData = this.value;
    $.ajax({
      type: "GET",
      url: "/users/email_available",
      data: {email_attempt: emailData},
      dataType: "json",
      success: function(data){
          console.log(data.available)
          emailAvailable = data.available;
          if(emailAvailable == false) {
            $('.register-form input#user_email').val('');
            $('.register-form input#user_email').addClass('warning');
            $('.register-form input#user_email').attr('placeholder', 'This email address is already in use.');
          }
      }
    });
  });

  //on password blur, make sure there is 4.

  $('.register-form #user_password').on('blur', function() {
      $(this).removeClass('warning');
      var passwordCheck = $(this).val();
      if (passwordCheck.length < 4) {
        $(this).val('');
        $(this).addClass('warning');
        $(this).attr('placeholder', 'Your password should have at least 4 characters');
      }
  })

  // Checks to see that all the fields are properly filled in.
  // Returns a string of the first field that is unacceptable,
  // or "success" if all fields are valid.
  function validateForm() {
    if($('.recipient input').val() === "") {
      return "recipient";
    }else if($('.first-name input').val() === "") {
      return "first name";
    }else if(emailAvailable === "taken") {
      return "email";
    }else if($('.password input').val().length < 4){
      return "password";
    }else{
      return "success";
    }
  }

// listens for sign-up submit button and
// validates all fields before allowing submit
  $('.btn-sign-up').on('click', function(e) {
    if(validateForm() === "success") {
      // get value from single password field and add it to
      // confirm password field
      return;
    }
    e.preventDefault();
    console.log(validateForm());
  });
});