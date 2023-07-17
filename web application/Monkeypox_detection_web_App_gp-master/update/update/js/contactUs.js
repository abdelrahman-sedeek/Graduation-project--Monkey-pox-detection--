
    var authToken=sessionStorage.getItem("authToken")
    document.getElementById('contactForm').addEventListener('submit', function(event) {
      event.preventDefault(); // Prevent the form from submitting normally
    
      // Clear the success message
      document.getElementById('successMessage').innerHTML = '';
    
      // Get the form data
      var useName = document.getElementById('name').value;
      var email = document.getElementById('email').value;
      var phone = document.getElementById('phone').value;
      var message = document.getElementById('message').value;
    
      // Create an object with the form data
      var formData = {
        name: useName,
        email: email,
        phone: phone,
        message: message
      };
    
      // Create a new FormData object
      var formData = new FormData();
    
      // Append the form fields to the FormData object
      formData.append('name', useName);
      formData.append('email', email);
      formData.append('phone', phone);
      formData.append('message', message);
    
      // Make the AJAX request
      $.ajax({
        url: 'https://1eae-105-36-51-99.ngrok-free.app/monkey%20pox%20detection/backEnd/public/api/auth/contact_us',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        headers: {
          'Authorization': 'Bearer ' + authToken
        },
        success: function(response) {
          // Handle the API response
          //console.log('ok');
          //console.log(response);
          // Perform any necessary actions or show success message
          document.getElementById('contactForm').reset(); // Clear the form fields
          // Show the success message
          document.getElementById('successMessage').innerHTML = 'Message Sent Successfully'; 
        
          // Remove the success message after 5 seconds
          setTimeout(function() {
            document.getElementById('successMessage').remove();
          }, 5000);
        },
        error: function(error,xhr) {
          // Handle any errors
          console.error('Error:', xhr.responseText);
          // Show error message to the user
        }
      });
    });



    
