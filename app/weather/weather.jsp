
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


		      }
		      request.send();
		    }

		</script>


    <div class="target" style="height:100px;
															display: grid;
															grid-template-columns: 90px 120px auto;
															background-color:lightgreen;
															width:100%;
															font-family: sans-serif;">
      <div class="" style="background-color:snow;">
        <svg>
          <text x="0" y="50" style="font-size:50px;">
            <tspan x="0" id="currTemp"></tspan>
            <tspan x="60" style="baseline-shift:super; font-size:30px;">&deg;</tspan>
            <tspan x="60" style="font-size:30px;">c</tspan>
            <tspan></tspan>
          </text>
        </svg>
      </div>
      <div class="" style="background-color:aliceblue;">
        <svg>
          <text>
            <tspan x="0" y="25" id="desc"></tspan>
            <tspan x="0" y="50" >Feels Like</tspan>
            <tspan id="feelTemp"> </tspan><tspan>&deg;</tspan>
          </text>
        </svg>
      </div>

    </div>
