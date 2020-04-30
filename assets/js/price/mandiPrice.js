
  var request=new XMLHttpRequest();
  request.open("GET","https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd000001850c76ce49e246686075684ef0e11614&format=json&offset=0&limit=9999");
  request.onload=()=>{
      pdata=JSON.parse(request.responseText);
      sts=(pdata["records"].map(m=>m.state))
      sts=(new Set(sts))
      console.log(sts)

      for (var str of sts) {
          var opt = document.createElement('option');
          opt.text =str;
          opt.value = str;
          document.querySelector('#state').append(opt);
      }
      document.querySelector('#state').value = 'West Bengal'
      //document.write(data["records"]);
      wbdata = pdata["records"].filter(e => e.state.match(/.*Bengal/))
      stateSelect(wbdata);

      document.querySelector('#state').onchange = evt =>{
          state=evt.target.value;
          wbdata = pdata["records"].filter(e => e.state.match(new RegExp(state)))
          stateSelect(wbdata);
      }

      function stateSelect(wbdata)
      {
          console.log(wbdata)
          if (state != "") {
              while (document.getElementById('price-list').rows.length > 1)
                  document.getElementById('price-list').deleteRow(-1)
              district = new Set(wbdata.map(m => m.district));
              for (i = 0; i < wbdata.length; i++) {
                  //district.add(wbdata[i]["district"]);
                  var tr = document.createElement('tr');
                  for (k in wbdata[i]) {
                      if (k != 'timestamp' && k != 'state') {
                          var td = document.createElement("td");
                          td.innerHTML = wbdata[i][k];
                          tr.append(td);
                      }
                  }
                  document.querySelector('#price-list').append(tr);
                  //console.log(k+": "+wbdata[i][k]+"<br>");
              }
              document.querySelector('#price-list').hidden = false;

              while (document.getElementById('district').length > 1){
                  var e=document.getElementById('district');
                  e.removeChild(e.lastChild);
                  }
              console.log(district)
              for (i of district) {
                  var opt = document.createElement('option');
                  opt.text = i;
                  opt.value = i;
                  document.querySelector('#district').append(opt);
              }
              document.querySelector('#choose-district').hidden = false;
              console.log(wbdata);
              document.querySelector('#district').onchange = evt => {
                  console.log(evt.target.value);

                  if (evt.target.value != "")
                      dist = evt.target.value;
                  else
                      dist = ".*"
                  {
                      ddata = wbdata.filter(e => e.district.includes(dist));
                      console.log(ddata)
                      while (document.getElementById('price-list').rows.length > 1)
                          document.getElementById('price-list').deleteRow(-1)
                      for (i = 0; i < ddata.length; i++) {

                          var tr = document.createElement('tr');
                          for (k in ddata[i]) {
                              if (k != 'timestamp' && k != 'state') {
                                  var td = document.createElement("td");
                                  td.innerHTML = ddata[i][k];
                                  tr.append(td);
                              }
                          }
                          document.querySelector('#price-list').append(tr);
                          //console.log(k+": "+wbdata[i][k]+"<br>");
                      }
                  }
              }
          }

      }


  }
  request.send();
