$('.register-button').on('click', function() {
  $('.register-form').fadeToggle();
});

$('.close-window').on('click', function() {
  $('.register-form').fadeToggle();
});

// ajax request to get list of already taken emails
$('input#user_email').on('blur', function() {
  console.log("blur");
  var emailData = this.value;
  console.log(this);
  console.log("emailData:" + emailData);
  $.ajax({
    type: "GET",
    url: "/users/email_available",
    data: {email_attempt: emailData},
    dataType: "json",
    success: function(data){
        console.log(data.available)
    }  
  });      
});

// get value from single password field and add it to 
// confirm password field
$('.btn-sign-up').on('click', function(e) {
  var password = $('.password input').val();
  // console.log(password);
  $('.confirm-password input').val(password);
  // console.log($('.confirm-password input').val());

});