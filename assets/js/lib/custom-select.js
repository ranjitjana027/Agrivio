document.addEventListener("DOMContentLoaded",()=>{

  document.addEventListener('click',(event)=>{

    //console.log(event.target)
    if(event.target.classList.contains('select')){
        if(event.target.parentNode.querySelector('.select-options').classList.contains('show-options')){
          event.target.parentNode.querySelector('.select-options').classList.remove('show-options');
          event.target.parentNode.querySelector('.selected-option').classList.remove('option-expanded');
        }
        else{
          document.querySelectorAll('.custom-select').forEach((item, i)=>{
            item.querySelector('.select-options').classList.remove('show-options');
            item.querySelector('.selected-option').classList.remove('option-expanded');
          });
          event.target.parentNode.querySelector('.select-options').classList.add('show-options');
          event.target.parentNode.querySelector('.selected-option').classList.add('option-expanded');
        }
    }
    else if(event.target.classList.contains('selected-option'))
    {
      //console.log(event.target.parentNode.parentNode.querySelector('.select-options').style.display)
      //console.log(event.target.parentNode.parentNode.querySelector('.select-options'))
        if(event.target.parentNode.parentNode.querySelector('.select-options').classList.contains('show-options')){
          event.target.parentNode.parentNode.querySelector('.select-options').classList.remove('show-options');
          event.target.parentNode.parentNode.querySelector('.selected-option').classList.remove('option-expanded');
        }
        else{
          document.querySelectorAll('.custom-select').forEach((item, i)=>{
            item.querySelector('.select-options').classList.remove('show-options');
            item.querySelector('.selected-option').classList.remove('option-expanded');
          });
          event.target.parentNode.parentNode.querySelector('.select-options').classList.add('show-options');
          event.target.parentNode.parentNode.querySelector('.selected-option').classList.add('option-expanded');
        }
    }
    else {
      document.querySelectorAll('.custom-select').forEach((item, i)=>{
        item.querySelector('.select-options').classList.remove('show-options');
        item.querySelector('.selected-option').classList.remove('option-expanded');
      });
    }
  });

  document.querySelectorAll('.form-select').forEach((item, i) => {
    var outerDiv=document.createElement('div');
    outerDiv.classList.add('custom-select');
    var selectDiv=document.createElement('div');
    selectDiv.classList.add('select');
    var optionsDiv=document.createElement('div');
    optionsDiv.classList.add('select-options');
    var selectSpan=document.createElement('span');
    selectSpan.classList.add('selected-option');

    for(let j=0;j<item.options.length;j++)
    {
      var optionDiv=document.createElement('div');
      optionDiv.classList.add('option');
      optionDiv.innerText= item.options[j].text;
      optionsDiv.append(optionDiv);
    }
    selectSpan.innerText=optionsDiv.children[0].innerText;
    item.selectedIndex=0;





    selectDiv.append(selectSpan);
    outerDiv.append(selectDiv);
    outerDiv.append(optionsDiv);
    item.parentNode.insertBefore(outerDiv,item.nextSibling);

  });



document.querySelectorAll('.custom-select').forEach((item, i) => {
  item.querySelectorAll('.option').forEach((itm,index) => {
    itm.onclick=(evt)=>{
      document.querySelectorAll('select')[i].selectedIndex=index;
      item.querySelector('.selected-option').innerText=evt.target.innerText;

      item.previousSibling.dispatchEvent(new CustomEvent('custom-select-event'));
      };
  });
  /*item.querySelector('.select').onclick=()=>{
    if(!item.querySelector('.select-options').classList.contains('show-options')){
      item.querySelector('.select-options').classList.add('show-options');
      item.querySelector('.selected-option').classList.add('option-expanded');
    }
    else{
      item.querySelector('.select-options').classList.remove('show-options');
      item.querySelector('.selected-option').classList.remove('option-expanded');
    }


  };*/
});

});
