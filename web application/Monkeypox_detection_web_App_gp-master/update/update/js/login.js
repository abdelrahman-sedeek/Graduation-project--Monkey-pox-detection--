console.clear();

const loginBtn = document.getElementById('login');
const signupBtn = document.getElementById('signup');
let ngrok="https://1eae-105-36-51-99.ngrok-free.app";
var authToken;



loginBtn.addEventListener('click', (e) => {
    let parent = e.target.parentNode.parentNode;
    Array.from(e.target.parentNode.parentNode.classList).find((element) => {
        if(element !== "slide-up") {
            parent.classList.add('slide-up')
        }else{
            signupBtn.parentNode.classList.add('slide-up')
            parent.classList.remove('slide-up')
        }
    });
});

signupBtn.addEventListener('click', (e) => {
    let parent = e.target.parentNode;
    Array.from(e.target.parentNode.classList).find((element) => {
        if(element !== "slide-up") {
            parent.classList.add('slide-up')
        }else{
            loginBtn.parentNode.parentNode.classList.add('slide-up')
            parent.classList.remove('slide-up')
        }
    });
});
$(document).ready(function() {
    // Track the form validity
    let validName = false;
    let validEmail = false;
    let validPassword = false;
    let validConfirmPass=false;
  
    // Function to check form validity
    function checkFormValidity() {
      if (validName && validEmail && validPassword && validConfirmPass) {
        $('#signupButton').prop('disabled', false); // Enable signup button
      } else {
        $('#signupButton').prop('disabled', true); // Disable signup button
      }
    }
  
    // Event listener for name input
    $('#nameInput').on('input', function() {
      const name = $(this).val().trim();
      validName = name.length > 0;
      checkFormValidity();
    });
  
    // Event listener for email input
    $('#emailInput').on('input', function() {
      const email = $(this).val().trim();
      const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      validEmail = emailPattern.test(email);
      if (validEmail==true) {
        console.log("Valid");
        $("#wrong-email").hide();
        $("#correct-email").show();
        $("#emailMessage").hide();
    } else {
        
        $("#correct-email").hide();
        $("#emailMessage").show();
        $("#wrong-email").show();
    }
    
    if (email === "") {
        $("#correct-email").hide();
        $("#wrong-email").hide();
        $("#emailMessage").hide();
    }
      checkFormValidity();
    });
  
    // Event listener for password input
    $('#passwordInput').on('input', function() {

      const password = $(this).val();
      const passPattern = /^(.{8,})$/;
      validPassword = passPattern.test(password);
      if (validPassword==true) {
        console.log("Valid");
        $("#wrong-pass").hide();
        $("#correct-pass").show();
        $("#passMessage").hide();
    } else {
        console.log("Invalid");
        $("#correct-pass").hide();
        $("#passMessage").show();
        $("#wrong-pass").show();
    }
    
    if (password === "") {
        $("#correct-pass").hide();
        $("#wrong-pass").hide();
        $("#passMessage").hide();
    }
    
      checkFormValidity();

    });
    //Event listener for confirm password input
    $('#confirmPasswordInput').keyup(function() {
      var password = $('#passwordInput').val();
      var confirmPassword = $(this).val();
      if (password === confirmPassword) {
        validConfirmPass=true;
        $('#correct-cpass').show();
        $('#wrong-cpass').hide();
        $('#confirmPassMessage').hide();
      } else {
        $('#correct-cpass').hide();
        $('#wrong-cpass').show();
        $('#confirmPassMessage').show();
      }

      checkFormValidity();
    });
    // ************* sgin up API ****************
    // Submit form
    $('#registerForm').submit(function(event) {
      event.preventDefault(); // Prevent form submission
      const name = $('#nameInput').val().trim();
      const email = $('#emailInput').val().trim();
      const password = $('#passwordInput').val();
  
      const data = {
        name: name,
        email: email,
        password: password
      };
  
      $.ajax({
        url: `${ngrok}/monkey%20pox%20detection/backEnd/public/api/auth/register`,
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function(response) {
          authToken=response.access_token
          console.log('Registration successful');
          console.log(authToken);
          sessionStorage.setItem("username", response.user.name); 
          sessionStorage.setItem("userId", response.user.id); 
          sessionStorage.setItem("authToken", response.access_token); 
          // Redirect to another page
          window.location.href = 'home.html';
        },
        error: function(error) {
          console.error('Registration failed');
          alert("Email already Exists")
          // Add your desired behavior here, such as showing an error message
        }
      });
    });
  });
  
  // *************** start of  login API ********************************
  $(document).ready(function() {
    // Login form submit event handler
    $('#loginForm').submit(function(event) {
      event.preventDefault(); // Prevent form submission
     
      // Retrieve form data
      var email = $('#login-email').val();
      var password = $('#login-password').val();
      var data = {
        email: email,
        password: password
      };
      // Send login request using AJAX
      $.ajax({
     
        url: `${ngrok}/monkey%20pox%20detection/backEnd/public/api/auth/login`,
        type: 'POST',
        dataType: 'json',
        data:data,
        success: function(response) {
          // Handle API response
          console.log(response.access_token)
          sessionStorage.setItem("username", response.user.name); 
          sessionStorage.setItem("userId", response.user.id);
          var images = response.images.map((image) =>({
            image:image.image,
            status: image.status, 
         }) ); 
          sessionStorage.setItem('images', JSON.stringify(images));
         
          sessionStorage.setItem("authToken", response.access_token); 

          window.location.href = 'home.html';
        
          if (response.success) {
           
      } else {
            // Login failed, display error message
            $('#loginError').text(response.error);
          }
        }, 
        error: function(jqXHR, textStatus, errorThrown) {
          // Handle AJAX error
          console.log('AJAX error:', errorThrown);
          alert("Wrong email or password")
        }
      });
    });
  
    
  });

