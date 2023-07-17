 var authToken=sessionStorage.getItem("authToken")
//  var ngrok = 'https://6081-105-41-145-236.ngrok-free.app'
 console.log(authToken)
 allImages=[]
function uploadImage(event) {
  
  var image=URL.createObjectURL(event.target.files[0])
  var imageInput=document.getElementsByClassName("image-div")
  var submitBtn=document.getElementById('submitBtn')
  var reloadBtn=document.getElementById('reloadBtn')
  var imageDiv=document.getElementById('display-image')
  var newImage=document.createElement('img');

  newImage.src=image;
  newImage.style.width = "230px";
  newImage.style.height = "230px";
  imageDiv.appendChild(newImage);
  for(var i=0; i< imageInput.length; i++){

    imageInput[i].style.display = 'none';
    imageInput[i].style.margin = '0 !important';
    imageInput[i].style.padding = '0 !important';
  }
  submitBtn.style.display = '';
  
  // disable submit btn 
  submitBtn.addEventListener("click", function() {
  // Disable the button after it is clicked
  
  // submitBtn.disabled = true;
  submitBtn.style.display = 'none';
  reloadBtn.style.display = '';
  // Reload the page
  reloadBtn.addEventListener("click", function() {
  location.reload();
 });
});

}
$(document).ready(function() {
  
  allImages=JSON.parse(sessionStorage.getItem('images'))
  console.log(allImages)
    $(submitBtn).click(function() {
        // const formData = new FormData();
        var outputResult=""
        var imageInput = document.getElementById('image-input');
        var file = imageInput.files[0];
        var formData = new FormData();
        
      formData.append('image', file);
        $.ajax({
            url: 'http://127.0.0.1:5000/predict',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(data) {
              if(data.result==1)
              {
                outputResult=" Monkeypox Detected"
                $('#prediction').addClass('text-danger')
              }
              else
              {
                outputResult="Not Monkeypox "
                  $('#prediction').removeClass('text-danger')
                  $('#prediction').addClass('text-success')

              }
          
              $('#prediction').append(`${outputResult}`);
            //   ***************** save Data API ****************
              
              formData.append('status',outputResult);
            $.ajax({
                url: `${ngrok}/monkey%20pox%20detection/backEnd/public/api/auth/add_image`,
                type: 'POST',
                headers: {
                    'Authorization': 'Bearer ' + authToken
                  },
                  
                data:formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    console.log(response.image_path);
                    var im={
                    image:`${ngrok}/monkey%20pox%20detection/backEnd/public`+response.image_path,
                    status: outputResult
                    }
                    if (allImages === null || allImages === undefined) {
                      allImages = [];
                    }
                    allImages.push(im)
                    console.log(allImages)
                    sessionStorage.setItem('images', JSON.stringify(allImages))
        
                  
                },
                error: function(xhr, status, error) {
                  console.error('Error:', error);
                  console.log(xhr.responseText);
                }
              });

            }
          });
          
    });
    
});

$(document).ready(function() {
    $('#uploadForm').submit(function(event) {
        event.preventDefault();
        var formData=[];
            // Get the selected file from the input
            var fileInput = $('#image-input')[0];
            var file = fileInput.files[0];
              formData.status="true";
            // Create FormData object and append the file to it
            var formDataObj = new FormData();

            // Append the form values to the FormData object
            for (var key in formData) {
              formDataObj.append(key, formData[key]);
            }
            // Send AJAX POST request to the API endpoint
            $.ajax({
              url: '/api/upload-image',
              type: 'POST',
              data: formDataObj,
              processData: false,
              contentType: false,
              success: function(response) {
                console.log(response);
      
                // Display the uploaded image
                var imageContainer = $('#imageContainer');
                var imageURL = response.image_url;
      
                // Create an image element and set its source
                var imageElement = $('<img>');
                imageElement.attr('src', imageURL);
      
                // Append the image to the container
                imageContainer.append(imageElement);
              },
              error: function(xhr, status, error) {
                console.error('Error:', error);
              }
            });

    });
  });