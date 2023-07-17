var username=sessionStorage.getItem("username");
var userId=sessionStorage.getItem("userId");
var authToken=sessionStorage.getItem("authToken"); 
// Retrieve the stored images from session storage
const storedImages = sessionStorage.getItem('images');

// Parse the JSON string back into an array
const imagesArray = JSON.parse(storedImages);

// Now you can use the imagesArray in otherFile.js for further processing
console.log(imagesArray);
let ngrok="https://1eae-105-36-51-99.ngrok-free.app";
console.log(authToken);

var  labelName= document.getElementById('user-name-label')
labelName.textContent = username

// *************** START LOGOUT API ***************
function logout() {
  $.ajax({
    url: `${ngrok}/monkey%20pox%20detection/backEnd/public/api/auth/logout`, 
    type: 'POST', 
    headers: {
      'Authorization': 'Bearer ' + authToken 
    },
    success: function(response) {
   
      window.location.href = '/index.html'
      console.log('Logout successful');
      sessionStorage.clear();

      
    },
    error: function(xhr, status, error) {
      console.error('Logout error:', error);
    }
  });
}
document.getElementById('logoutLlnk').addEventListener('click', logout);
// ************** End  logout API ****************************

// ************* Display  History ****************************

const tableBody = document.getElementById('imageTableBody');

// Loop through the images data and create table rows
imagesArray.forEach((imageData) => {
  // Create a new table row
  const row = document.createElement('tr');

  // Create the image cell
  const imageCell = document.createElement('td');
  const imageElement = document.createElement('img');
  imageElement.src = imageData.image;
  imageElement.alt = 'Image';
  imageElement.classList.add('img-fluid');
  imageCell.appendChild(imageElement);

  // Create the status cell
  const statusCell = document.createElement('td');
  statusCell.textContent = imageData.status;

  // Append the cells to the row
  row.appendChild(imageCell);
  row.appendChild(statusCell);

  // Append the row to the table body
  tableBody.appendChild(row);
});