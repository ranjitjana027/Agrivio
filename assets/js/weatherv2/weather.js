document.addEventListener("DOMContentLoaded",()=>{
  function showSuggestion(){
    document.querySelector("#recommendation-table").classList.remove("hidden");
    document.querySelector(".current-weather").classList.remove("hidden");
    document.querySelector(".location-info").classList.remove("hidden")
    document.querySelectorAll(".no-location-info").forEach((item, i) => {
      item.classList.add("hidden");
    });

  }

  function hideSuggestion(){
    document.querySelector("#recommendation-table").classList.add("hidden");
    document.querySelector(".current-weather").classList.add("hidden");
    document.querySelector(".location-info").classList.add("hidden");
    document.querySelectorAll(".no-location-info").forEach((item, i) => {
      item.classList.remove("hidden");
    });
  }

  if(document.querySelector('#current-longitude').innerHTML=='' || document.querySelector('#current-latitude').innerHTML==''){
    hideSuggestion();
  }

  document.querySelector("#gps-location-btn").addEventListener("click",()=>{
    hideSuggestion();
    navigator.geolocation.getCurrentPosition(showPosition,locationAccessBlocked);
  });

  document.querySelector("#manual-location-btn").addEventListener("click",()=>{
    hideSuggestion();
    document.querySelector(".set-location").style.display="block";
    setLocation(88.36,22.57);
  });

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
    get_suggestion();
  }


  function weatherUpdate(lat, lon) {
    /*document.querySelector('#loading-1').style.display="block";*/
    document.querySelector('.current-weather').style.display="none";
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
        /*document.querySelector('#wind-direction').innerHTML = data.wind.deg;
        document.querySelector('#loading-1').style.display="none";*/
        document.querySelector('.current-weather').style.display="grid";
        showSuggestion();
      }

    }
    request.send();
  }
/*
  function currentWeather(key) {
    var request = new XMLHttpRequest();
    request.open("GET", location.protocol+"//"+location.host+"/webProject/api/weather/current-weather?key="+key);
    request.onload = () => {
      var data = JSON.parse(request.responseText);
      console.log(data);
      console.log(data[0].Temperature.Metric.Value);
      document.querySelector('#currTemp').innerHTML = Math.round(data[0].Temperature.Metric.Value);
      document.querySelector('#feelTemp').innerHTML = Math.round(data[0].RealFeelTemperature.Metric.Value);
      document.querySelector('#desc').innerHTML = data[0].WeatherText;
      var wi = (Number(data[0].WeatherIcon) > 9) ? data[0].WeatherIcon : '0' + data[0].WeatherIcon;

      document.querySelector('#weather-icon').href.baseVal = "/webProject/assets/img/weather/" + wi + "-s.png";
      document.querySelector('#clouds').innerHTML = data[0].CloudCover;
      document.querySelector('#wind-speed').innerHTML = data[0].Wind.Speed.Metric.Value;
      document.querySelector('#wind-direction').innerHTML = data[0].Wind.Direction.English;
    }
    request.send();
  }
*/

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
      weatherUpdate(Number(document.querySelector('#current-latitude').innerHTML),
                  Number(document.querySelector('#current-longitude').innerHTML));
      get_suggestion();
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
        weatherUpdate(Number(document.querySelector('#current-latitude').innerHTML),
                      Number(document.querySelector('#current-longitude').innerHTML));
        get_suggestion();

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

    /* crop suggestion */
    function get_suggestion() {
      //document.querySelector('#loading-2').style.display="block";
      var request=new XMLHttpRequest();
      request.open("GET",location.protocol+"//"+location.host+"/webProject/suggestion/crop?lat="+
              document.querySelector('#current-latitude').innerHTML +"&lon="+
              document.querySelector('#current-longitude').innerHTML);
      request.onload=()=>{
          if(request.status==200){
            var data=JSON.parse(request.responseText);
            console.log(data);
            if(data.success){
              document.querySelector('#recommendation-table-body').innerHTML='';
              for (var i of data.cropids) {
                var tr=document.createElement("tr");
                var td1=document.createElement("td");
                td1.innerHTML=i.name;
                var td2=document.createElement("td");
                td2.innerHTML=i.rabi?"&#9989;":"&#10060;"
                var td3=document.createElement("td");
                td3.innerHTML=i.kharif?"&#9989;":"&#10060;"
                var td4=document.createElement("td");
                td4.innerHTML=i.summer?"&#9989;":"&#10060;"
                tr.append(td1);
                tr.append(td2);
                tr.append(td3);
                tr.append(td4);
                document.querySelector('#recommendation-table-body').append(tr);
              }
              /*if(data.cropids.length==0){
                document.querySelector('.crop-suggestion').innerHTML="<p style='text-align:center;color:#8e8e8ed6;'>Nothing to show.</p>"
              }
              */
            //  document.querySelector('#loading-2').style.display="none";

            }
            //loadArticle(title,url);
          }
      }
      request.send();

    }
})
