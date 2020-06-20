
  var request=new XMLHttpRequest();
  request.open("GET","https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd000001850c76ce49e246686075684ef0e11614&format=json&offset=0&limit=9999");
  request.onload=()=>{
      pdata=JSON.parse(request.responseText);
      var options = {
        year: '2-digit', month: 'short', day: '2-digit',
        hour: 'numeric', minute: 'numeric',
        hour12: true,
        timeZone: 'UTC'
      };
      document.querySelector('#arrival-date').innerHTML=Intl.DateTimeFormat('en',options).format( new Date(pdata.updated_date));
      sts=(pdata["records"].map(m=>m.state))
      sts=(new Set(sts))
      console.log(sts)
      // create an option for each state
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

      function stateSelect(state_data)
      {
          console.log(state_data)
          document.querySelector(".district-wise-price").innerHTML ="";
          if (state_data.length>0) {
            all_districts=new Set(state_data.map(item=>item.district));
            var crops = new Set(state_data.map(item=>item.commodity));
            var varieties = new Set(state_data.map(item=>item.variety));
            var max_prices = new Set(state_data.map(item => item.max_price));
            var min_prices = new Set(state_data.map(item => item.min_price));
            var modal_prices = new Set(state_data.map(item => item.modal_price));
            var suggestions=[...crops].concat([...varieties]).concat([...max_prices]).concat([...min_prices]).concat([...modal_prices])
            var datalist=document.createElement("datalist");
            datalist.id="datalist"
            for(var c of suggestions){
              var option = document.createElement('option');
              option.text=c;
              datalist.appendChild(option)
            }
            document.querySelector("input[name=filterby-crop]").setAttribute("list","datalist");
            document.querySelector("input[name=filterby-crop]").parentNode.append(datalist);
            while (document.getElementById('district').length > 1){
                var e=document.getElementById('district');
                e.removeChild(e.lastChild);
                }
            for ( var i of all_districts) {
                var opt = document.createElement('option');
                opt.text = i;
                opt.value = i;
                document.querySelector('#district').append(opt);
            }
            for(var district of all_districts){
              var district_data=state_data.filter(item=>item.district.includes(district))
              var markets=new Set(district_data.map(item=>item.market));
              for( var market of markets){
                var outer_div=document.createElement("div");
                outer_div.classList.add("market-wise-price");
                  var collapse_div=document.createElement("div");
                  collapse_div.classList.add("collapse");
                    var row_div=document.createElement("div");
                    row_div.classList.add("row");
                    row_div.style.width = "90%";
                    row_div.style.display = "inline-block"
                      var district_div = document.createElement("div");
                      district_div.className = "col-6 col-sm-6 col-xs-12 district";
                        var district_label = document.createElement("label");
                        district_label.innerHTML="District : ";
                        var district_span=document.createElement("span");
                        district_span.innerHTML = district;
                        district_div.appendChild(district_label);
                        district_div.appendChild(district_span);
                      var market_div=document.createElement("div");
                      market_div.className="col-6 col-sm-5 col-xs-12 market";
                        var market_label = document.createElement("label");
                        market_label.innerHTML="Market : ";
                        var market_span=document.createElement("span");
                        market_span.innerHTML = market;
                        market_div.appendChild(market_label);
                        market_div.appendChild(market_span);
                      row_div.appendChild(district_div);
                      row_div.appendChild(market_div);
                    collapse_div.appendChild(row_div)

                  var content_div = document.createElement("div");
                  content_div.className="content show-content";
                    var table=document.createElement("table");
                      var tr_head= document.createElement("tr");
                      tr_head.innerHTML = "<th>Commodity</th><th>Variety</th><th>Max Price</th><th>Min Price</th><th>Modal Price</th>";
                      table.appendChild(tr_head);
                      var market_data=district_data.filter(item=>item.market.includes(market));
                      var record_fields=["commodity","variety","max_price","min_price","modal_price"];
                      for(var md of market_data){
                        var data_tr= document.createElement("tr");
                        for( var rf of record_fields){
                          var td = document.createElement("td");
                          td.innerHTML = md[rf];
                          data_tr.appendChild(td);
                        }
                        table.appendChild(data_tr);
                      }
                      content_div.appendChild(table);
                  outer_div.appendChild(collapse_div);
                  outer_div.appendChild(content_div);
                document.querySelector(".district-wise-price").appendChild(outer_div);
              }

            }

            /*
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
              */

          }
          collapsible();
      }


  }
  request.send();
  document.querySelector('#district').onchange = evt => {
      console.log(evt.target.value);
      var dist = evt.target.value;
      for (var ele of document.querySelectorAll(".market-wise-price > .collapse")){
        console.log(ele.parentNode);
        ele.parentNode.classList.add("hidden");
        if(ele && ele.innerText.indexOf(dist)>-1){
          ele.parentNode.classList.remove("hidden");
        }
      }


  }
  document.querySelector("input[name=filterby-crop]").oninput=evt=>{
    console.log(evt.target.value);
    var q=evt.target.value.toLowerCase();
    if(q!=""){
      var market_price_list= document.querySelectorAll(".market-wise-price");
      market_price_list.forEach((item, i) => {
        var trs=item.querySelectorAll("tr");
        for (var i=1; i< trs.length;i++){
          trs[i].classList.add("hidden");
          if(trs[i].innerText.toLowerCase().indexOf(q)>-1){
            trs[i].classList.remove("hidden");
          }
        }
      });

    }
    else{
      var market_price_list= document.querySelectorAll(".market-wise-price");
      market_price_list.forEach((item, i) => {
        var trs=item.querySelectorAll("tr");
        for (var i=1; i< trs.length;i++){
          trs[i].classList.remove("hidden");
        }
      });
    }
  }

  function collapsible(){
    document.querySelectorAll('td:nth-child(3), td:nth-child(4), th:nth-child(3), th:nth-child(4)').forEach(item=>{
        item.classList.add("mobile-hidden");
    });
    document.querySelectorAll(".collapse").forEach((item, i) => {
      item.onclick=()=>{
        item.classList.toggle("active");
        item.nextElementSibling.classList.toggle("hidden-content");
      }
    });
  }
