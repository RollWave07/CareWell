$('.register-button').on('click', function() {
  $('.register-form').fadeToggle();
});

$('.close-window').on('click', function() {
  $('.register-form').fadeToggle();
});

// ajax request to get list of already taken emails
$('input#user_email').on('blur', function() {
  console.log("blur");
  emailData = this.value;
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