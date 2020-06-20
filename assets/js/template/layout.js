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
          if(Number(document.querySelector("#notification-count").innerHTML)>0){
            console.log("Ok")
            var request=new XMLHttpRequest();
            request.open("POST", location.protocol+"//"+location.host+"/notification/read");
            request.onload = function (){
              if(request.status==200){
                var data=JSON.parse(request.responseText)
                if(data.success){
                  document.querySelector("#notification-count").innerHTML="0";
                  document.querySelector("#notification-count").classList.add("hidden");

                  document.querySelectorAll(".notification").forEach(item=>{
                    item.classList.add("read");
                  });
                }

              }
            }
            var fData=new FormData();
            fData.append("lastId",document.querySelector(".notification").getAttribute("n_id"));
            fData.append("key","value")
            request.setRequestHeader("Content-type", 'application/x-www-form-urlencoded');
            request.send("lastId="+document.querySelector(".notification").getAttribute("n_id"));
          }
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

  /* expand serch bar on focus */
  document.querySelector(".search-box input").onfocus=()=>{
    document.querySelector(".search-box").classList.add("full-width")
  }

  /* shrink search bar on blur */
  document.querySelector(".search-box input").onblur=()=>{
    document.querySelector(".search-box").classList.remove("full-width")
  }

  /* show/hide mobile search bar */
  window.onclick=evt=>{
    if(( evt.target && evt.target.parentNode &&
      evt.target.parentNode.classList && evt.target.parentNode.classList.contains("search-logo")) || (
      evt.target.parentNode.parentNode &&
      evt.target.parentNode.parentNode.classList && evt.target.parentNode.parentNode.classList.contains("search-logo")))
      {
        document.querySelector(".mobile-search-bar").classList.toggle("show-mobile-search-bar");
      }
      /*else{
        document.querySelector(".mobile-search-bar").classList.remove("show-mobile-search-bar");
      }*/
  }

});
