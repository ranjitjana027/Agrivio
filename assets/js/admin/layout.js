document.addEventListener("DOMContentLoaded",()=>{
  document.addEventListener('click',(evt)=>{
    console.log(evt.target.classList)
    item=document.querySelector('.user-menu').querySelector('ul');
    if(item.classList.contains("show"))
    {
      item.classList.remove('show');
      console.log('show removed')
    }
    else if(evt.target.classList.contains("user-icon")){
      console.log('show added')
      item.classList.add('show');
    }
  });
  /*document.querySelector('.user-icon').onclick=()=>{
    console.log('hgv')
    item=document.querySelector('.user-menu').querySelector('ul');
    if(item.classList.contains("show"))
    item.classList.remove('show');
    else
    item.classList.add('show');
  }*/

  document.addEventListener("click",(evt)=>{
    item=document.querySelector(".user-nav").querySelector("ul");
    if(item.classList.contains("show-nav")){
      item.classList.remove("show-nav");
      document.querySelector(".nav-bar-icon").innerHTML = "&#9776";
    }
    else if(evt.target.classList.contains("nav-bar-icon")){
      item.classList.add("show-nav");
      document.querySelector(".nav-bar-icon").innerHTML = "&#65088;";
    }
  });

});
