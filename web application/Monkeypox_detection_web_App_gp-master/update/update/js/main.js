
function darkmode(){
    const wasDarkmode =localStorage.getItem('darkmode') === 'true';
    localStorage.setItem('darkmode',!wasDarkmode);
    const element =document.body;
    element.classList.toggle('dark-mode',!wasDarkmode);
}
function onload(){
    document.body.classList.toggle('dark-mode',localStorage.getItem('darkmode')=== 'true');
}
$(document).ready(function() {
    setTimeout(function(){
    $('#nv').slideDown(1500);
    },50);
    setTimeout(function(){
    $('#hello').slideDown(1000);
    }, 1000);
    setTimeout(function(){
    $('#inf').fadeIn(1500);
    }, 1500);
    setTimeout(function(){
    $('#im').fadeIn(1500);
    }, 2000);
    setTimeout(function(){
    $('#symp').slideDown(1000);
    }, 2500);
    setTimeout(function(){
    $('#preventions').slideDown(1000);
    }, 3000);
    });
    
