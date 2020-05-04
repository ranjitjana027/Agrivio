/*
Use case : Give name of the class `multiple-select` and create a div of class  `values`
*/
document.addEventListener("DOMContentLoaded",()=>{

              document.querySelectorAll('.multiple-select').forEach((ms) => {
                //var ms=document.querySelector('.multiple-select');

                var inp=document.createElement('input');
                inp.type="text"
                inp.setAttribute('list',"crop_list");

                var datalist=document.createElement('datalist');
                datalist.id="crop_list"
                for(i of ms.options){
                  var option=document.createElement('option');
                  option.value=i.value
                  datalist.append(option)
                }
                inp.onkeydown=evt=>{
                  if(evt.keyCode==13){
                    var flag=false;
                    if(inp.value!=""){
                      for( op of ms.options){
                        if(op.value==inp.value){
                          flag=true;
                          inp.value="";
                          if(!op.selected){
                            op.selected=true;

                            var span=document.createElement('span');
                            span.innerHTML=op.value;
                            span.classList.add('multiple-select-value');
                            ms.parentNode.querySelector('.values').append(span);

                            span.onclick=(evt)=> {
                              console.log(evt.target.innerText);
                              for(i of ms.options){
                                if(i.value==evt.target.innerText){
                                  i.selected=false;
                                  evt.target.style.display="none";
                                  break;
                                }
                              }
                            };
                          }
                          break;
                        }
                      }
                      if(!flag){
                        var new_option=document.createElement('option');
                        new_option.value=inp.value;
                        inp.value="";
                        ms.options.add(new_option);
                        new_option.selected=true;
                        var span=document.createElement('span');
                        span.innerHTML=new_option.value;
                        span.classList.add('multiple-select-value');
                        ms.parentNode.querySelector('.values').append(span);

                        span.onclick=(evt)=> {
                          console.log(evt.target.innerText);
                          for(i of ms.options){
                            if(i.value==evt.target.innerText){
                              i.selected=false;
                              evt.target.style.display="none";
                              break;
                            }
                          }
                        };

                      }
                    }
                    return false;
                  }

                }
                inp.placeholder="Type here...";
                ms.parentNode.append(inp);
                ms.parentNode.append(datalist)
              });

});
