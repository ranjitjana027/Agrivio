document.addEventListener("DOMContentLoaded",()=>{
  let lazyloadImages=document.querySelectorAll('.lazy');

  let callback=(entries,Observer)=>{
    entries.forEach((entry, i) => {
      if(entry.isIntersecting){
        let target=entry.target;
        let img=new Image();
        img.src=target.dataset.src;
        img.onload=()=>{
          target.src=target.dataset.src;
          Observer.unobserve(target);
          target.classList.remove('lazy')
        }
      }
    });

  }

  let observer=new IntersectionObserver(callback);
  lazyloadImages.forEach((item, i) => {
    observer.observe(item);
  });
});
