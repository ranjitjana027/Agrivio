
		<script type="text/javascript">
				function showPosition(position) {
		        lat= position.coords.latitude ;
		        lon= position.coords.longitude;
		        weatherUpdate(lat,lon);
		      }
		    navigator.geolocation.getCurrentPosition(showPosition);

		    function weatherUpdate(lat,lon){
		      var request=new XMLHttpRequest();
		      request.open("GET","http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=nXZ08gIFP1fjewMnLL7A8x5lCmchkeaW&q="+lat+"%2C"+lon);
		      request.onload=()=>{
		        var data=JSON.parse(request.responseText);
		        currentWeather(data["Key"])
		      }
		      request.send();
		    }

		    function currentWeather(key){
		      var request=new XMLHttpRequest();
		      request.open("GET","http://dataservice.accuweather.com/currentconditions/v1/"+key+"?details=true&apikey=nXZ08gIFP1fjewMnLL7A8x5lCmchkeaW");
		      request.onload=()=>{
		        var data=JSON.parse(request.responseText);
		        console.log(data);
		        console.log(data[0].Temperature.Metric.Value);
		        document.querySelector('#currTemp').innerHTML=Math.round(data[0].Temperature.Metric.Value);
		        document.querySelector('#feelTemp').innerHTML=Math.round(data[0].RealFeelTemperature.Metric.Value);
		        document.querySelector('#desc').innerHTML=data[0].WeatherText;
						var wi=(Number(data[0].WeatherIcon) >9 )? data[0].WeatherIcon:'0'+data[0].WeatherIcon;

						document.querySelector('#weather-icon').href.baseVal="${pageContext.request.contextPath}/assets/img/weather/"+wi+"-s.png";
						document.querySelector('#clouds').innerHTML=data[0].CloudCover;
		      }
		      request.send();
		    }

		</script>


    <div class="target" style="height:170px;
															display: grid;
															grid-template-columns: 100px auto;
															grid-template-rows: auto auto;
															background-color:snow;
															width:268px;
															font-family: sans-serif;
															padding:5px 10px;">
      <div class="" style="height:60px;">
				<span style="font-size:12px;">Currently</span>
        <svg style="height:70px; width:100%;">
          <text x="0" y="40" style="font-size:50px;">

            <tspan x="0" id="currTemp">35</tspan>
            <tspan x="60" style="baseline-shift:super; font-size:30px;">&deg;</tspan>
            <tspan x="60" style="font-size:30px;">c</tspan>
            <tspan></tspan>
          </text>
        </svg>
      </div>
      <div class="" style="height:60px;">
        <svg style="height:70px; width:100%;">
          <text>
            <tspan x="0" y="30" id="desc">As good as any</tspan>
            <tspan x="0" y="55" >Feels Like</tspan>
            <tspan id="feelTemp">45 </tspan><tspan>&deg;</tspan>
          </text>
        </svg>
      </div>
			<div style="height:100px;">
				<svg viewBox="00 0 100 100" >
				 <image id="weather-icon" xlink:href="" x="0" y="0" height="100" width="100"/>
				</svg>
			</div>
			<div>
				<svg style="height:70px; width:100%;">
          <text>
            <tspan x="0" y="30" >Wind </tspan>
						<tspan id="wind-speed">85 </tspan><tspan>km/h</tspan>
						<tspan>NE</tsapn>
            <tspan x="0" y="55" >CloudCover</tspan>
            <tspan id="clouds">45 </tspan><tspan>&#37;</tspan>
          </text>
        </svg>
			</div>

    </div>
