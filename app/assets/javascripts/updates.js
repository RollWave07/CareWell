

$(document).on("ajax:success", ".like-it-now", function(e, data, status, xhr){
  $("#vote" + data.vote_id).text(data.count);
  $(this).find("span").toggleClass( "active-glyphicon-heart" );
  // console.log("#vote" + data.vote_id)
});

$(document).ready( function() {
  
  addPhotoUpload();

  $('.choose-group-photo').on('click', function() {
    $('input#group_picture').click();
  });//end click

})//end ready


// Gets data from photo in upload form and produces 
// a preview image without uploading to the server yet.
// source: Mozilla file upload tutorial.
function handleFiles(forminput) {
  var files = forminput.files;
  var preview = $(forminput).next();
  preview.empty();
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
    preview.append(img); // Assuming that "preview" is a the div output where the content will be displayed.
    
    var reader = new FileReader();
    reader.onload = (function(aImg) { return function(e) { aImg.src = e.target.result; }; })(img);
    reader.readAsDataURL(file);
  }
};


// Assigns the photo icon click event to the hidden input field next in the DOM.
function addPhotoUpload() {
  $('.fileSelect').off();  // clear previous click handlers if any
  $('.fileSelect').on('click', function (e) {
    e.preventDefault(); // prevent navigation to "#"
    var next = $(this).next(); // gets the next element, the form file input
    next.click();
  });
};


