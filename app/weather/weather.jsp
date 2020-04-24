<script src="/webProject/assets/js/weather/weather.js" charset="utf-8"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/weather/weather.css">
<script src='https://api.mapbox.com/mapbox-gl-js/v1.8.1/mapbox-gl.js'></script>
<link href='https://api.mapbox.com/mapbox-gl-js/v1.8.1/mapbox-gl.css' rel='stylesheet' />

<div class="target" style="height:170px;
							display: grid;
							grid-template-columns: 100px auto;
							grid-template-rows: auto auto;
							background-color:#fbfffa;
							color: #009635;
							width:268px;
							font-family: sans-serif;
							padding:5px 10px;
							border-radius: 4px;
							margin: 6px;
							box-shadow: 0px 2px 5px rgba(0,0,0,0.5);">
	<div class="" style="height:60px;">
		<span style="font-size:12px;">Currently</span>
		<svg style="height:70px; width:100%; fill:#03c16f;">
			<text x="0" y="40" style="font-size:50px;">

				<tspan x="0" id="currTemp"></tspan>
				<tspan x="60" style="baseline-shift:super; font-size:30px;">&deg;</tspan>
				<tspan x="60" style="font-size:30px;">c</tspan>
				<tspan></tspan>
			</text>
		</svg>
	</div>
	<div class="" style="height:60px;">
		<svg style="height:70px; width:100%; fill:#018383;">
			<text>
				<tspan x="0" y="30" id="desc"></tspan>
				<tspan x="0" y="55">Feels Like</tspan>
				<tspan id="feelTemp"> </tspan>
				<tspan>&deg;</tspan>
			</text>
		</svg>
	</div>
	<div style="height:100px;">
		<svg viewBox="00 0 100 100">
			<image id="weather-icon" xlink:href="" x="0" y="0" height="100" width="100" />
		</svg>
	</div>
	<div>
		<svg style="height:70px; width:100%; fill:#018383;">
			<text>
				<tspan x="0" y="30">Wind </tspan>
				<tspan id="wind-speed"> </tspan>
				<tspan> km/h </tspan>
				<tspan id="wind-direction"></tspan>
				<tspan x="0" y="55">CloudCover</tspan>
				<tspan id="clouds">45 </tspan>
				<tspan>&#37;</tspan>
			</text>
		</svg>
	</div>

</div>
<div class="location-info">
	Your current location:
	<svg viewBox="0 0 70 90" height="20px" id="location-icon">
		<path d="M35,85 L15,55 C-35,-15 105,-15 55,55 z " stroke="#08796f" fill="none" stroke-width="4px" />
		<circle cx="35" cy="30" r="17" stroke="#08796f"  fill="none" stroke-width="4px"/>
	</svg>
	<span id="current-location"> Kolkata</span>
	<span id="current-longitude" hidden></span>
	<span id="current-latitude" hidden></span>
</div>
	<div class="set-location">

		<div class="set-location-content" style="width:60%;">
			<div>
				Drag the marker to your location.
			</div>
			<div class="" style="width:100%;">
				<div class="target" style="height:500px; width:100%;" >
					<div id='map' ></div>
					<pre id="coordinates" class="coordinates">cfedf</pre>
				</div>
				<div class="">
					<button type="button"
						class="btn-ok"
						onclick="document.querySelector('.set-location').style.display='none'">
						Save
					</button>


				</div>
			</div>
		</div>
	</div>
	<script src="https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-geocoder/v4.5.1/mapbox-gl-geocoder.min.js"></script>
	<link
		rel="stylesheet"
		href="https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-geocoder/v4.5.1/mapbox-gl-geocoder.css"
		type="text/css"
	/>
