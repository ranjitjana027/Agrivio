document.addEventListener("DOMContentLoaded",()=>{
  function showPosition(position) {
    lat = position.coords.latitude;
    lon = position.coords.longitude;
    weatherUpdate(lat, lon);
  }
  navigator.geolocation.getCurrentPosition(showPosition,locationAccessBlocked);

  function weatherUpdate(lat, lon) {
    var request = new XMLHttpRequest();
    request.open("GET", "https://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=nXZ08gIFP1fjewMnLL7A8x5lCmchkeaW&q=" + lat + "%2C" + lon);
    request.onload = () => {
      var data = JSON.parse(request.responseText);
      currentWeather(data["Key"])
    }
    request.send();
  }

  function currentWeather(key) {
    var request = new XMLHttpRequest();
    request.open("GET", "https://dataservice.accuweather.com/currentconditions/v1/" + key + "?details=true&apikey=nXZ08gIFP1fjewMnLL7A8x5lCmchkeaW");
    request.onload = () => {
      var data = JSON.parse(request.responseText);
      console.log(data);
      console.log(data[0].Temperature.Metric.Value);
      document.querySelector('#currTemp').innerHTML = Math.round(data[0].Temperature.Metric.Value);
      document.querySelector('#feelTemp').innerHTML = Math.round(data[0].RealFeelTemperature.Metric.Value);
      document.querySelector('#desc').innerHTML = data[0].WeatherText;
      var wi = (Number(data[0].WeatherIcon) > 9) ? data[0].WeatherIcon : '0' + data[0].WeatherIcon;

      document.querySelector('#weather-icon').href.baseVal = "${pageContext.request.contextPath}/assets/img/weather/" + wi + "-s.png";
      document.querySelector('#clouds').innerHTML = data[0].CloudCover;
      document.querySelector('#wind-speed').innerHTML = data[0].Wind.Speed.Metric.Value;
      document.querySelector('#wind-direction').innerHTML = data[0].Wind.Direction.English;
    }
    request.send();
  }

  document.querySelector('.btn-ok').addEventListener("click",()=>{
    document.querySelector('.set-location').style.display='none';
    if(document.querySelector('#current-longitude').innerHTML!='' && document.querySelector('#current-latitude').innerHTML!='')
    weatherUpdate(Number(document.querySelector('#current-latitude').innerHTML),
                  Number(document.querySelector('#current-longitude').innerHTML))
  })
  function locationAccessBlocked(){
    alert("Location access blocked. Set Location manually.");
    document.querySelector('.set-location').style.display='block';
    setLocation(87,23);

  }

  /***             ****/
  document.querySelector('.set-location').addEventListener('click',(evt)=>{
    console.log(evt.target.classList.contains('set-location'))
    if(evt.target.classList.contains('set-location'))
    {
      document.querySelector('.set-location').style.display='none';
    }
  });
  document.querySelector('#location-icon').onclick=()=>{
    document.querySelector('.set-location').style.display='block';
    setLocation(87,23);
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
})
