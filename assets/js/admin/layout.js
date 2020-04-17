document.addEventListener("DOMContentLoaded",()=>{
  document.onclick=(evt)=>{
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
  }
  /*document.querySelector('.user-icon').onclick=()=>{
    console.log('hgv')
    item=document.querySelector('.user-menu').querySelector('ul');
    if(item.classList.contains("show"))
    item.classList.remove('show');
    else
    item.classList.add('show');
  }*/
});
