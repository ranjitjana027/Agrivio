document.querySelector('button[type="submit"]').onclick=()=>{
  for(item of  document.querySelectorAll('input')){
    if(item.required==true && item.value=="")
    {
      if(item.labels.length==0)
      alert(item.name+" is required");
      else
      alert(item.labels[0].innerText+" is required");

      return false;
    }
  }
  for(item of  document.querySelectorAll('select')){
    if(item.required==true && item.value=="")
    {
      if(item.labels.length==0)
      alert(item.name+" is required");
      else
      alert(item.labels[0].innerText+" is required");

      return false;
    }
  }

}
