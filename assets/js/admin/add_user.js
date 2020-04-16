document.querySelector('select[name="premium"]').parentNode.style.display="none";
document.querySelector('select[name="role"]').addEventListener('custom-select-event',(evt)=>{

  if(evt.target.value=='FARMER')
  {
    document.querySelector('select[name="premium"]').parentNode.style.display="inline-block";
    document.querySelector('select[name="premium"]').required=true;
  }
  else {
      document.querySelector('select[name="premium"]').parentNode.style.display="none";
      document.querySelector('select[name="premium"]').required=false;
  }
},false);
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
