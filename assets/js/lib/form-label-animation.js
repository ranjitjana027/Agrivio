document.addEventListener("DOMContentLoaded",()=>{
  document.querySelectorAll(".form-input > input").forEach((item, i) => {
    item.addEventListener("keydown",evt=>{
      console.log(evt.keyCode);
        var kc=evt.keyCode;
        if((kc>47 && kc<58) || kc==32 || (kc>64 && kc<91) || (kc>95 && kc<112) || (kc>185 && kc<193) || (kc>218 && kc<223) || kc==229){
          evt.target.classList.add('focus');
          evt.target.labels[0].classList.add("input-focus");
        }
    })
    item.addEventListener('keyup',evt=>{
        if(evt.target.value==""){
          evt.target.classList.remove('focus');
          evt.target.labels[0].classList.remove("input-focus");
        }
    });
    item.addEventListener("input",evt=>{
        if(evt.target.value!=""){
          evt.target.classList.add('focus');
          evt.target.labels[0].classList.add("input-focus");
        }
    });
  });
});
