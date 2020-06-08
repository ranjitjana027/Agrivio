document.addEventListener("DOMContentLoaded",()=>{

  document.querySelectorAll('.dot').forEach((item,i)=>{
    item.onclick = ()=>{
      slideShow(i);
    }
  })

  document.querySelector('button[name="prev"]').onclick = slideRight;
  document.querySelector('button[name="next"]').onclick = slideLeft;
  var currentSlide=0;
  slideShow(currentSlide);

  function slideRight() {
    slideShow(currentSlide-1);

  }
  function slideLeft(){
    slideShow(currentSlide+1)
  }

  function showSlide(n){
    //console.log(n);
    var slides=document.querySelectorAll(".slide");
    var dots=document.querySelectorAll(".dot");
    if(n<0)
      index=slides.length-1;
    else if(n>slides.length-1)
      index=0;
    else
      index=n;

    if(currentSlide<=n){
      dots[currentSlide].classList.remove("active");
      slides[currentSlide].classList.remove('slideRight');
      slides[currentSlide].classList.remove('slideLeft');
      slides[currentSlide].classList.add('slideLeftOut');

      dots[index].classList.add("active")
      slides[index].classList.remove('slideLeftOut');
      slides[index].classList.remove('slideRightOut');
      slides[index].classList.add('slideLeft');
    }
    else{
      dots[currentSlide].classList.remove("active");
      slides[currentSlide].classList.remove('slideRight');
      slides[currentSlide].classList.remove('slideLeft');
      slides[currentSlide].classList.add('slideRightOut');

      dots[index].classList.add("active")
      slides[index].classList.remove('slideRightOut');
      slides[index].classList.remove('slideLeftOut');
      slides[index].classList.add('slideRight');
    }
    currentSlide=index;
  }
  function slideShow(n){
    if(typeof(t)!="undefined"){
      window.clearTimeout(t);
    }
    showSlide(n);
    t=window.setTimeout(()=>{
      slideShow(currentSlide+1);
    },10000);
  }

});
