/* get the page */
function getPage(path,fun,title,url){

  document.querySelector('.spinner').style.display="block";
  var request =new XMLHttpRequest();
  request.open("GET",location.protocol+"//"+location.host+"/webProject/app"+path);
  request.onload=()=>{
    if(request.status==200){
      responseHTML=request.responseText;
      document.querySelector("#main-content").innerHTML=responseHTML;
      fun(title,url);

      /*window.setTimeout(()=>{
        document.querySelector('.spinner').style.display="none";
      },200);*/
    }
  }
  request.send();
}

/** for chat **/
function chat(title,url){
    if(window.WebSocket)
    {
        ws=new WebSocket((window.location.protocol == 'http:' ? 'ws:' :'wss:') + window.location.host +
        '/webProject/chat/' + document.querySelector('#room').value + '/' +document.querySelector('#userid').value);
    }
    else{
        alert("Browser doesn't support WebSocket");
        return;
    }
    ws.onopen=()=>{
        console.log("connected");
        document.querySelector('.spinner').style.display="none"; // remove spinner
        /* push current state */
        document.title=title;
        history.pushState({'title':title,'text':document.body.innerHTML},title,url);

        document.querySelector('.chat-input').onkeydown=evt=>{
            if(evt.keyCode==13)
            {
                ws.send(document.querySelector('.chat-input').value);
                document.querySelector('.chat-input').value="";

            }
        }
        document.querySelector('.submit').onclick=evt=>{
            var newObj=
            ws.send(document.querySelector('.chat-input').value);
            document.querySelector('.chat-input').value="";
        }
    }
    ws.onclose=()=>{
        console.log("disconnected");
    }
    ws.onmessage=message=>{
        console.log(JSON.parse(message.data));
        var data=JSON.parse(message.data);
        var d=document.createElement('div');
        if(data.status)
        {
            d.classList.add('status');
            if (data.sender == document.querySelector('#userid').value) {
            d.innerText='You '+data.content;
            }
            else {
                d.innerText=data.sender_name+' '+data.content;
            }

        }
        else
        {   d.classList.add('chat-message');
            var p=document.createElement('p');
            p.classList.add('content');
            var s=document.createElement('small');
            var s1=document.createElement('span');
            var s2=document.createElement('span');
            s1.classList.add('time');
            s2.classList.add('sender');
            s1.innerText=data.date;
            s2.innerText=data.sender;
            if(data.sender==document.querySelector('#userid').value){
                s2.innerText="You";
                d.classList.add('you');
            }
            else{
                d.classList.add('they');
            }

            p.innerText=data.content;
            s.append(s1);
            s.append(s2);
            d.append(p);
            d.append(s);
        }
        document.querySelector('.chat-room').append(d);
    }
}

/** for crop prices at different mandis **/
function crop_price(title,url){

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
            wbdata = pdata["records"].filter(e => e.state.match(state))
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
                        ddata = wbdata.filter(e => e.district.match(dist));
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
            document.querySelector('.spinner').style.display="none"; // remove spinner
            /* push current state */
            document.title=title;
            history.pushState({'title':title,'text':document.body.innerHTML},title,url);

        }


    }
    request.send();

}

/*** current weather **/
function current_weather(){

    if(document.querySelector('#current-longitude').innerHTML!='' && document.querySelector('#current-latitude').innerHTML!='')
    {
      weatherUpdate(Number(document.querySelector('#current-latitude').innerHTML),
                    Number(document.querySelector('#current-longitude').innerHTML));
      window.setInterval(()=>{
        weatherUpdate(Number(document.querySelector('#current-latitude').innerHTML),
                      Number(document.querySelector('#current-longitude').innerHTML));
      },3000000);
    }
    else {
      navigator.geolocation.getCurrentPosition(showPosition,locationAccessBlocked);
    }

    function showPosition(position) {
      lat = position.coords.latitude;
      lon = position.coords.longitude;
      var request=new XMLHttpRequest();
      request.open("GET",location.protocol+"//"+location.host+"/webProject/app/API/user/set_location.jsp?lat="+lat+"&lon="+lon);
      request.onload=()=>{
        if(request.status==200)
        {
          console.log("location updated");
        }
      }
      request.send();
      document.querySelector('#current-latitude').innerHTML=lat;
      document.querySelector('#current-longitude').innerHTML=lon;
      weatherUpdate(lat, lon);
      window.setInterval(()=>{
        weatherUpdate(Number(document.querySelector('#current-latitude').innerHTML),
                      Number(document.querySelector('#current-longitude').innerHTML));
      },3000000);
    }


    function weatherUpdate(lat, lon) {
      var request = new XMLHttpRequest();
      request.open("GET", location.protocol+"//"+location.host+"/webProject/app/weather/weatherJSON.jsp?lat="+lat+"&lon="+lon);
      request.onload = () => {
        if(request.status==200){
          var data = JSON.parse(request.responseText);
          document.querySelector("#current-location").innerHTML=data.name;
          document.querySelector('#currTemp').innerHTML = Math.round(data.main.temp);
          document.querySelector('#feelTemp').innerHTML = Math.round(data.main.feels_like);
          document.querySelector('#desc').innerHTML = data.weather[0].description;
          document.querySelector('#weather-icon').href.baseVal = "/webProject/assets/img/weather/" +data.weather[0].icon + "@2x.png";
          document.querySelector('#clouds').innerHTML = data.clouds.all;
          document.querySelector('#wind-speed').innerHTML = data.wind.speed;
          /*document.querySelector('#wind-direction').innerHTML = data.wind.deg;*/
        }

      }
      request.send();
    }

    document.querySelector('.btn-ok').addEventListener("click",()=>{
      document.querySelector('.set-location').style.display='none';
      if(document.querySelector('#current-longitude').innerHTML!='' && document.querySelector('#current-latitude').innerHTML!='')
      {
        var request=new XMLHttpRequest();
        request.open("GET",location.protocol+"//"+location.host+"/webProject/app/API/user/set_location.jsp?lat="+document.querySelector('#current-latitude').innerHTML+"&lon="
                            +document.querySelector('#current-longitude').innerHTML);
        request.onload=()=>{
          if(request.status==200)
          {
            console.log("location updated");
          }
        }
        request.send();
        weatherUpdate(Number(document.querySelector('#current-latitude').innerHTML),Number(document.querySelector('#current-longitude').innerHTML));
      }
    })
    function locationAccessBlocked(){
      alert("Location access blocked. Set Location manually.");
      document.querySelector('.set-location').style.display='block';
      /* location from internet address */
      document.querySelector('#current-latitude').innerHTML=22.57;
      document.querySelector('#current-longitude').innerHTML=88.36;
      var request=new XMLHttpRequest();
      request.open("GET",location.protocol+"//"+location.host+"/webProject/app/API/user/set_location.jsp?lat="+document.querySelector('#current-latitude').innerHTML+"&lon="
                          +document.querySelector('#current-longitude').innerHTML);
      request.onload=()=>{
        if(request.status==200)
        {
          console.log("location updated");
        }
      }
      request.send();
      setLocation(88.36,22.57);

    }

    /***             ****/
    document.querySelector('.set-location').addEventListener('click',(evt)=>{
      console.log(evt.target.classList.contains('set-location'))
      if(evt.target.classList.contains('set-location'))
      {
        document.querySelector('.set-location').style.display='none';
        if(document.querySelector('#current-longitude').innerHTML!='' && document.querySelector('#current-latitude').innerHTML!='')
        {
          window.setInterval(()=>{
            weatherUpdate(Number(document.querySelector('#current-latitude').innerHTML),
                          Number(document.querySelector('#current-longitude').innerHTML));
          },3000000);
          weatherUpdate(Number(document.querySelector('#current-latitude').innerHTML),
                        Number(document.querySelector('#current-longitude').innerHTML));

        }
        else{
          alert("Your location is not set!");
        }

      }

    });
    document.querySelector('#location-icon').onclick=()=>{
      document.querySelector('.set-location').style.display='block';
      if(document.querySelector('#current-longitude').innerHTML!='' && document.querySelector('#current-latitude').innerHTML!='')
        setLocation(Number(document.querySelector('#current-longitude').innerHTML),
                    Number(document.querySelector('#current-latitude').innerHTML));
    }

    function setLocation(lon,lat){
        if (!mapboxgl.supported()) {
          alert('Your browser does not support Mapbox GL');
        } else {
          mapboxgl.accessToken = 'pk.eyJ1IjoicmFuaml0amFuYTAyNyIsImEiOiJjazlkMmV1OXQwN2wzM2xrMm5rdzNoNHd4In0._yq6R2svhu-71s0WerS7dA';
          var map = new mapboxgl.Map({
            container: 'map',
            style: 'mapbox://styles/mapbox/streets-v11',
            interactive:'true',
            center:[ lon,lat],
            zoom:10
          });
          map.addControl(
            new MapboxGeocoder({
            accessToken: mapboxgl.accessToken,
            mapboxgl: mapboxgl
            })
            );
          var marker = new mapboxgl.Marker( { draggable:true})
            .setLngLat([ lon,lat])
            .addTo(map);
          function onDragEnd() {
          var lngLat = marker.getLngLat();
          coordinates.style.display = 'block';
          coordinates.innerHTML =
          'Longitude: ' + lngLat.lng + '<br />Latitude: ' + lngLat.lat;
          document.querySelector('#current-longitude').innerHTML=lngLat.lng;
          document.querySelector('#current-latitude').innerHTML=lngLat.lat;
          }

          marker.on('dragend', onDragEnd);
        }
      }
}

/* crop suggestion */
function get_suggestion(title,url) {
  var request=new XMLHttpRequest();
  request.open("GET",location.protocol+"//"+location.host+"/webProject/suggestion/crop?lat=23&lon=88");
  request.onload=()=>{
      if(request.status==200){
        var data=JSON.parse(request.responseText);
        console.log(data);
        if(data.success){
          for (var i of data.cropids) {
            var aLink=document.createElement('a');
            aLink.href=location.protocol+"//"+location.host+"/webProject/article?id="+i.id;
            aLink.text="Cultivation Guide: "+i.name.replace(/^./,i.name[0].toUpperCase())
            aLink.classList.add("link-article");
            var aDiv =document.createElement('div');
            aDiv.classList.add("article");
            aDiv.append(aLink);
            var aLi=document.createElement('li');
            aLi.append(aDiv);
            document.querySelector('.crop-suggestion').append(aLi);
          }

        }
        loadArticle(title,url);
      }
  }
  request.send();

}

/* calendar */
function calendar_util(title,url) {

    eventdata=null;
    fillCalendar(new Date().getFullYear(),new Date().getMonth());
    document.getElementById('btn-prev').onclick=()=>{
        fillCalendar(Number(document.getElementById('prev-year').innerText), Number(document.getElementById('prev-month').innerText));
    };
    document.getElementById('btn-next').onclick = () => {
            fillCalendar(Number(document.getElementById('next-year').innerText), Number(document.getElementById('next-month').innerText));
    };



    function fillCalendar(year,month)
    {
        months = [['January', 31],
            ['February', 28, 29],
            ['March', 31],
            ['April', 30],
            ['May', 31],
            ['June', 30],
            ['July', 31],
            ['August', 31],
            ['September', 30],
            ['October', 31],
            ['November', 30],
            ['December', 31]
            ]
        d = new Date(year, month);
        month = d.getMonth();
        year = d.getFullYear();
        document.getElementById('cal-month').innerText = months[month][0];
        document.getElementById('cal-year').innerText = year;
        noOfDays = months[month][1];
        if (month == 1 && ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0))
            noOfDays = 29;


        d = new Date(year, month, 1);
        ad = d.getDay() - 1;
        dates = document.querySelectorAll('.cal-num');
        for (let i = 1; i <= noOfDays; i++) {
            val = ad + i;
            r = Math.floor(val / 7);
            c = val % 7;
            dates[r].children[c].innerHTML =  "<span class='date-day'>"+ i +"</span>" +
                                                "<span class='date-month' hidden>"+ month +"</span>" +
                                                "<span class='date-year' hidden>"+ year +"</span>" +
                                                "<span class='event-count' hidden >0</span>";
            dates[r].children[c].className="curr-month";
            dates[r].children[c].onclick=addEvent;

        }

        //mark today

        today = new Date();
        if (today.getMonth() == month && today.getFullYear() == year) {
            console.log("running")
            date = today.getDate();
            val = ad + date;
            r = Math.floor(val / 7);
            c = val % 7;

            dates[r].children[c].classList.add("today");
        }

        // fill prev month

        prevMonth = (month + 12 - 1) % 12;
        prevYear = year;
        if (prevMonth > month)
            prevYear = year - 1;
        noOfDaysPrevMonth = months[prevMonth][1];
        if (prevMonth == 1 && ((prevYear % 4 == 0 && prevYear % 100 != 0) || prevYear % 400 == 0))
            noOfDaysPrevMonth = 29;
        pi = noOfDaysPrevMonth;
        for (var i = ad; i >= 0; i--) {
            dates[0].children[i].innerHTML = "<span class='date-day'>" + pi-- + "</span>" +
                "<span class='date-month' hidden>" + prevMonth + "</span>" +
                "<span class='date-year' hidden>" + prevYear + "</span>";
            dates[0].children[i].className="prev-month";
            //dates[0].children[i].onclick = addEvent;
        }
        document.getElementById('prev-month').innerText = prevMonth;
        document.getElementById('prev-year').innerText = prevYear;
        // fill next month
        nextMonth = (month + 12 + 1) % 12;
        nextYear = year;
        if (nextMonth < month)
            nextYear = year + 1;
        ni = 1;
        nval = noOfDays + ad + ni;
        nr = Math.floor(nval / 7);
        nc = nval % 7;
        for (var c = nc; c < 7; c++) {
            dates[nr].children[c].innerHTML =  "<span class='date-day'>" + ni++  +"</span>" +
            "<span class='date-month' hidden>" + nextMonth + "</span>" +
                "<span class='date-year' hidden>" + nextYear + "</span>";
            dates[nr].children[c].className="next-month";
            //dates[nr].children[c].onclick = addEvent;
        }
        for (var r = nr + 1; r < 6; r++) {

            for (var c = 0; c < 7; c++) {
                dates[r].children[c].innerText ="";// ni++;
                //dates[r].children[c].className="next-month";
            }
        }

        document.getElementById('next-month').innerText = nextMonth;
        document.getElementById('next-year').innerText = nextYear;


        // testing phase
        fetchEvent();
        activateModal();

    }

    function fetchEvent() {

            document.querySelector('.crop-stats').classList.remove('show');
            document.querySelector('.event-type-stats').classList.remove('show');
            if(eventdata==null)
            {
              request = new XMLHttpRequest();
              request.open("GET", location.protocol + "//" + location.host + "/webProject/calendar/events");
              request.onload = () => {
                  eventdata = JSON.parse(request.responseText)['events']
                  console.log(eventdata);
                  fetchEventUtil(eventdata);
              }
              request.send();

            }
            else {
              fetchEventUtil(eventdata);
            }
        }

  function fetchEventUtil(data)
  {
      monthList = ['January', 'February', 'March', 'April', 'May', 'June', 'July',
          'August', 'September', 'October', 'November', 'December']
      var currmonth = monthList.indexOf(document.getElementById('cal-month').innerText);
      console.log(currmonth)
      var curryear = document.getElementById('cal-year').innerText;
      console.log(curryear);

      ///
      currmonth=(currmonth+1)
      var d = new Date(curryear, currmonth-1, 1);
      var ad = d.getDay() - 1;
      var dates = document.querySelectorAll('.cal-num');
      mdata=(data.filter(e => e.date.match(new RegExp(curryear+'-0*'+currmonth+'-.*'))))
      var eventstats={};
      eventstats.noofevents=mdata.length;
      eventstats.eventdays=new Set();
      eventstats.events={}
      eventstats.events.crop=new Object();
      eventstats.events.eventtype={};
      for(let i=0;i<mdata.length;i++)
      {
          var ed = new Date(mdata[i].date);
          console.log(ed.getDate())
          eventstats.eventdays.add(ed.getDate());
          if(eventstats.events.crop.hasOwnProperty(mdata[i].crop))
          {
            eventstats.events.crop[mdata[i].crop]+=1;
          }
          else{
            eventstats.events.crop[mdata[i].crop]=1;
          }

          if(eventstats.events.eventtype.hasOwnProperty(mdata[i].eventtype))
          {
            eventstats.events.eventtype[mdata[i].eventtype]+=1;
          }
          else{
            eventstats.events.eventtype[mdata[i].eventtype]=1;
          }
          var val = ad + ed.getDate();
          var r = Math.floor(val / 7);
          var c = val % 7;
          dates[r].children[c].innerHTML += "<span class='event-id' hidden>" + mdata[i].id + "</span>" +
              "<span class='crop' hidden >" + mdata[i].crop + "</span>" +
              "<span class='event-type' hidden >" + mdata[i].eventtype + "</span>" +
              "<span class='remark' hidden>" + mdata[i].remark + "</span>";
          //dates[r].children[c].style.textDecoration = "underline";
          dates[r].children[c].onclick=showEvent;
          dates[r].children[c].classList.add('event-display')
          dates[r].children[c].querySelector('.event-count').innerText=Number(dates[r].children[c].querySelector('.event-count').innerText)+1
      }
      console.log(eventstats)
      document.querySelector('#table1').innerHTML="<tr><th>No of Events</th><td>"+eventstats.noofevents+"</td></tr>"
                                +"<tr><th>No of days of Event</th><td>"+eventstats.eventdays.size+"</td></tr>"
                                +"<tr><th>No of Crops Mentioned</th><td>"+Object.keys(eventstats.events.crop).length+"</td></tr>";
      document.querySelector('.stats-overview').classList.add('show');
      document.querySelector('#table2-body').innerHTML=""
      for(let c in eventstats.events.crop){
        var tr=document.createElement('tr');
        var td1=document.createElement('td');
        var td2=document.createElement('td');
        td1.innerHTML=c;
        td2.innerHTML=eventstats.events.crop[c];
        tr.append(td1);
        tr.append(td2);
        document.querySelector('#table2-body').append(tr);
      }
      document.querySelector('#table3-body').innerHTML=""
      for(let c in eventstats.events.eventtype){
        var tr=document.createElement('tr');
        var td1=document.createElement('td');
        var td2=document.createElement('td');
        td1.innerHTML=c;
        td2.innerHTML=eventstats.events.eventtype[c];
        tr.append(td1);
        tr.append(td2);
        document.querySelector('#table3-body').append(tr);
      }

      if(eventstats.noofevents>0){
        document.querySelector('.crop-stats').classList.add('show');
        document.querySelector('.event-type-stats').classList.add('show');
      }
      document.querySelector('.spinner').style.display="none"; // remove spinner
      /* push current state */
      document.title=title;
      history.pushState({'title':title,'text':document.body.innerHTML},title,url);

  }


    function activateModal(){
        document.querySelectorAll('.close').forEach(function (item) {
            item.onclick = (event) => {
                console.log(event.target);
                event.target.offsetParent.style.display="none";
            };
        });
        window.onclick=evt=>{
            document.querySelectorAll('.modal').forEach(function (item) {
                if(evt.target==item)
                    item.style.display = "none";
        });
        }

    }
    function addEvent(evt){
        document.querySelector('#add-event-modal').style.display="block";
        console.log(evt.target.offsetParent)
        if(evt.target.className!='date-day'){
            document.querySelector('#inp-date').value = evt.target.querySelector('.date-day').innerText;
            document.querySelector('#inp-month').value = evt.target.querySelector('.date-month').innerText;
            document.querySelector('#inp-year').value = evt.target.querySelector('.date-year').innerText;
        }
        else
        {
            document.querySelector('#inp-date').value=evt.target.innerText;
            document.querySelector('#inp-month').value = evt.target.offsetParent.children[1].innerText;
            document.querySelector('#inp-year').value = evt.target.offsetParent.children[2].innerText;
        }
    }
    function showEvent(evt) {
        document.querySelector('#show-event-modal').style.display = "block";

        console.log(evt.target.offsetParent)
        if (evt.target.className != 'date-day') {
            document.querySelector('#inp-date').value = evt.target.querySelector('.date-day').innerText;
            document.querySelector('#inp-month').value = evt.target.querySelector('.date-month').innerText;
            document.querySelector('#inp-year').value = evt.target.querySelector('.date-year').innerText;

            // show
            var count=Number(evt.target.querySelector('.event-count').innerText);
            console.log('count: '+count)
            table=[]
            for(i=0;i<count;i++)
            {
                table.push(document.createElement('table'));
            }
            console.log(table)
            tr = []
            for (i = 0; i < 3*count; i++)
                tr.push(document.createElement('tr'))

            th = []
            for (i = 0; i < 3*count; i++)
                th.push(document.createElement('th'));
            for(i=0;i<count;i++){
                th[0 + i * 3].innerText = 'Crop';
                th[1 + i * 3].innerText = 'Event Type';
                th[2 + i * 3].innerText = 'Remark';
            }


            td = []
            for (i = 0; i < 3 * count; i++)
                td.push(document.createElement('td'));


            for(i=0;i<count;i++)
            {

                td[i*3].innerText = evt.target.querySelectorAll('.crop')[i].innerText;
                td[1+i*3].innerText = evt.target.querySelectorAll('.event-type')[i].innerText;
                td[2+i*3].innerText = evt.target.querySelectorAll('.remark')[i].innerText;
            }
            for(k=0;k<count;k++){
                for (i = 0; i < 3; i++) {
                    tr[i + k * 3].append(th[i + k * 3]);
                    tr[i + k * 3].append(td[i + k * 3]);
                    table[k].append(tr[i + k * 3])
                }
            }
            document.querySelector('#show-event-modal').querySelector('.event-list').innerHTML=""
            for(k=0;k<count;k++){
                var li=document.createElement('li');
                li.append(table[k]);
                document.querySelector('#show-event-modal').querySelector('.event-list').append(li);
            }
            document.querySelector('#show-event-modal').querySelector('.event-date').innerText =
                  evt.target.querySelector('.date-day').innerText + '/'
                + (Number(evt.target.querySelector('.date-month').innerText) + 1) + '/'
                + evt.target.querySelector('.date-year').innerText;


        }
        else {
            document.querySelector('#inp-date').value = evt.target.innerText;
            document.querySelector('#inp-month').value = evt.target.offsetParent.children[1].innerText;
            document.querySelector('#inp-year').value = evt.target.offsetParent.children[2].innerText;

            // show
            var count = Number(evt.target.parentNode.children[3].innerText);
            console.log('count: ' + count)
            table = []
            for (i = 0; i < count; i++) {
                table.push(document.createElement('table'));
            }
            console.log(table)
            tr = []
            for (i = 0; i < 3 * count; i++)
                tr.push(document.createElement('tr'))

            th = []
            for (i = 0; i < 3 * count; i++)
                th.push(document.createElement('th'));
            for (i = 0; i < count; i++) {
                th[0 + i * 3].innerText = 'Crop';
                th[1 + i * 3].innerText = 'Event Type';
                th[2 + i * 3].innerText = 'Remark';
            }


            td = []
            for (i = 0; i < 3 * count; i++)
                td.push(document.createElement('td'));


            for (i = 0; i < count; i++) {

                td[0 + i * 3].innerText = evt.target.parentNode.children[5+i*4].innerText;
                td[1 + i * 3].innerText = evt.target.parentNode.children[6+i*4].innerText;
                td[2 + i * 3].innerText = evt.target.parentNode.children[7+i*4].innerText;
            }
            for (k = 0; k < count; k++) {
                for (i = 0; i < 3; i++) {
                    tr[i + k * 3].append(th[i + k * 3]);
                    tr[i + k * 3].append(td[i + k * 3]);
                    table[k].append(tr[i + k * 3])
                }
            }
            document.querySelector('#show-event-modal').querySelector('.event-list').innerHTML = ""
            for (k = 0; k < count; k++) {
                var li = document.createElement('li');
                li.append(table[k]);
                document.querySelector('#show-event-modal').querySelector('.event-list').append(li);
            }
            document.querySelector('#show-event-modal').querySelector('.event-date').innerText= evt.target.innerText + '/'
                + (Number(evt.target.offsetParent.children[1].innerText) + 1) + '/'
                + evt.target.offsetParent.children[2].innerText;
        }
    }

}

/** dashboard **/
function loadArticle(title,url) {
  document.querySelectorAll(".link-article").forEach((item, i) => {
    item.onclick=()=>{
      getPage("/article/article_view.jsp"+item.search,
      ()=>{
        document.querySelector('.spinner').style.display="none";
        document.title="Article";
        history.pushState({'title':"Article",'text':document.body.innerHTML},"Article","article"+item.search);
      }
      ,"Article","article"+item.search);
      return false;
    }
  });

  document.querySelector('.spinner').style.display="none"; //remove spinner
  /* push current state */
  document.title=title;
  history.pushState({'title':title,'text':document.body.innerHTML},title,url);


}

document.addEventListener("DOMContentLoaded",()=>{
  document.querySelector("#link-home").onclick=loadHome;
  document.querySelector("#link-calendar").onclick=loadCalendar;
  document.querySelector("#link-price").onclick=loadPrice;
  document.querySelector("#link-chat").onclick=()=>{
      document.querySelector('.spinner').style.display="block";
    getPage('/chat/chat_view.jsp'+document.querySelector("#link-chat").search
    , chat,"Ask Experts | Dashboard","ask-expert"+document.querySelector("#link-chat").search);

    return false;
  }
  document.querySelector("#link-profile").onclick=loadProfile;
  document.querySelector("#link-forecast").onclick=loadForecast;
  function loadHome() {
    getPage('/user/dashboard_view.jsp',get_suggestion,"Welcome | Dashboard","dashboard");

    return false;
  }
  function loadCalendar(){
    getPage('/calendar/calendar_view.jsp', calendar_util,"Calendar | Dashboard","calendar");
    return false;
  }
  function loadPrice(){
    getPage('/price/mandiPrice.jsp', crop_price,"Crop Price | Dashboard","crop-price");
    return false;
  }
  function loadProfile(){
    getPage('/user/profile_view.jsp',
          ()=>{
            document.querySelector('.spinner').style.display="none";
            document.title="My Profile | Dashboard";
            history.pushState({'title':'My Profile | Dashboard','text':document.body.innerHTML},'My Profile | Dashboard',"profile");
          },
          "My Profile | Dashboard",
          "profile"
        );
    return false;
  }
  function loadForecast() {
    getPage("/weather/weather_forecast_view.jsp",
          ()=>{
            document.querySelector('.spinner').style.display="none";
            document.title="Weather | Dashboard";
            history.pushState({'title':'Weather | Dashboard','text':document.body.innerHTML},'My Profile | Dashboard',"weather");
          },
          "Weather Forecast",
          "weather"
        );
    return false;
  }

  window.onpopstate=e=>{
    const data=e.state;
    document.title=data.title;
    document.body.innerHTML=data.text;
  }

});
