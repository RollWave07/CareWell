

$(document).on("ajax:success", ".like-it-now", function(e, data, status, xhr){
  $("#vote" + data.vote_id).text(data.count);
  $(this).find("span").toggleClass( "active-glyphicon-heart" );
  // console.log("#vote" + data.vote_id)
});

$(document).ready( function() {

  // no-JQuery cut-and-paste from Mozilla tutorial
  // to use photo icon as file-upload button
  var fileSelect = document.getElementById("fileSelect");
  var fileElem = document.getElementById("update_picture");
  fileSelect.addEventListener("click", function (e) {
    if (fileElem) {
      fileElem.click();
    }
    e.preventDefault(); // prevent navigation to "#"
  }, false);


  $('.choose-group-photo').on('click', function() {
    $('input#group_picture').click();
  });//end click

})//end ready


// Gets data from photo in upload form and produces 
// a preview image without uploading to the server yet.
// source: Mozilla file upload tutorial.
function handleFiles(files) {
  $("#photo-preview").empty();
  for (var i = 0; i < files.length; i++) {
    var file = files[i];
    var imageType = /image.*/;
    
    if (!file.type.match(imageType)) {
      continue;
    }
    
    var img = document.createElement("img");
    img.classList.add("obj");
    img.file = file;
    // console.log("img: ", img.file);
    $('#photo-preview').append(img); // Assuming that "preview" is a the div output where the content will be displayed.
    
    var reader = new FileReader();
    reader.onload = (function(aImg) { return function(e) { aImg.src = e.target.result; }; })(img);
    reader.readAsDataURL(file);
  }
}