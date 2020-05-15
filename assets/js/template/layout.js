document.addEventListener("DOMContentLoaded",()=>{
  /* show /hide navigation list */
  window.addEventListener("click",evt=>{
    if(evt.target.classList!=undefined && evt.target.classList.contains("menu-icon")){
      evt.target.classList.toggle("menu-icon-active");
      var user_nav_list=document.querySelector("div.user-nav ul");
      if(user_nav_list.classList.contains("show-nav")){
        user_nav_list.classList.remove("show-nav");
      }
      else{
        user_nav_list.classList.add("show-nav");
      }
    }
    else{
      document.querySelector("div.user-nav ul").classList.remove("show-nav");
      document.querySelector(".menu-icon").classList.remove("menu-icon-active");
    }
  });

  /* show notifications */
  window.addEventListener("click",evt=>{
    if( (evt.target.parentNode!=null &&
      evt.target.parentNode.classList!=undefined &&
       evt.target.parentNode.classList.contains("bell-icon"))
      || (evt.target.parentNode.parentNode!=null &&
        evt.target.parentNode.parentNode.classList!=undefined &&
        evt.target.parentNode.parentNode.classList.contains("bell-icon")))
      {
        var target=document.querySelector(".notification-list");
        if(target.classList.contains("hidden")){
          target.classList.remove("hidden");
        }
        else{
          target.classList.add("hidden");
        }
      }
      else{
        document.querySelector(".notification-list").classList.add("hidden");
      }

  });

  /* show account action list */
  window.addEventListener("click",evt=>{
    if(evt.target.parentNode!=null && evt.target.parentNode.classList!=undefined && evt.target.parentNode.classList.contains("user-icon")){
      var target=document.querySelector(".account-nav");
      if(target.classList.contains("hidden")){
        target.classList.remove("hidden");
      }
      else{
        target.classList.add("hidden");
      }
    }
    else{
      document.querySelector(".account-nav").classList.add("hidden");
    }
  });


});
