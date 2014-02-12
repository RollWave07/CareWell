$('.register-button').on('click', function() {
  $('.register-form').fadeToggle();
});

$('.close-window').on('click', function() {
  $('.register-form').fadeToggle();
});

// ajax request to get list of already taken emails
var emailAvailable = "taken";
$('input#user_email').on('blur', function() {
  var emailData = this.value;
  $.ajax({
    type: "GET",
    url: "/users/email_available",
    data: {email_attempt: emailData},
    dataType: "json",
    success: function(data){
        console.log(data.available)
        emailAvailable = data.available;
    }
  });
});

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