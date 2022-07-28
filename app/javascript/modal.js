
function modal(elem){
  var div =  elem.nextElementSibling; 
  div.className = "modal";
}


function closeModal(elem) {
  var div = elem.parentElement
  div.className = "hidden";
}


window.addEventListener('click', function(e){
  div = document.getElementsByClassName('modal')[0];
	if (div.contains(e.target) || e.target.className == 'button')
  {
    
   } 
  else{
    div.className = "hidden";
  }
})