<%@ page import="java.sql.*" %>
<%
	Connection con=null;
	Statement stmt=null;
	ResultSet rs=null;
	try{
		new org.postgresql.Driver();
		java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

		String username = dbUri.getUserInfo().split(":")[0];
		String password = dbUri.getUserInfo().split(":")[1];
		String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

		con=DriverManager.getConnection(dbUrl, username, password);

		stmt =con.createStatement();
		String qstring="SELECT DISTINCT on (user_id) * from  location_info where user_id="
																					+session.getAttribute("userid")+" order by user_id, loc_time desc";
		rs=stmt.executeQuery(qstring);


%>


<script src="/webProject/assets/js/weather/weather.js" charset="utf-8"></script>
<script src='https://api.mapbox.com/mapbox-gl-js/v1.8.1/mapbox-gl.js'></script>
<link href='https://api.mapbox.com/mapbox-gl-js/v1.8.1/mapbox-gl.css' rel='stylesheet' />
<div class="loading-div-container" id="loading-1">
	<div class="loading-div">
		<svg class="loading-svg" viewBox="0 0 140 160">
			<path d="M7,100 L20,85 40,95 M20,90 A51,51 0 0,0 120,90 M100,65 L120,75 133,60 M120,70 A51,51 0 0,0 20,70"
				stroke="green" stroke-width="10px" fill="none" >
				<animateTransform
					attributeName="transform"
					type="rotate"
					begin="0s"
					dur="1.1s"
					from="0 70  80"
					to="360 70 80"
					repeatCount="indefinite"
					/>
			</path>
		</svg>
	</div>
</div>
<div class="current-weather-container">
<div class="current-weather" >
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
				<tspan id="clouds"> </tspan>
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
	<span id="current-location"> </span>
<% if(rs.next()){ %>
	<span id="current-longitude" hidden><%= (rs.getArray("last_location")!=null)? ((Float[])(rs.getArray("last_location")).getArray())[1]:"" %></span>
	<span id="current-latitude" hidden><%= (rs.getArray("last_location")!=null)?  ((Float[])(rs.getArray("last_location")).getArray())[0]:"" %></span>
<% } else { %>
<span id="current-longitude" hidden></span>
<span id="current-latitude" hidden></span>
<% } %>
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

</div>
	<script src="https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-geocoder/v4.5.1/mapbox-gl-geocoder.min.js"></script>
	<link
		rel="stylesheet"
		href="https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-geocoder/v4.5.1/mapbox-gl-geocoder.css"
		type="text/css"
	/>
	<%

			stmt.close();
			rs.close();
			con.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally {

			if (rs != null) {
				try { rs.close(); } catch (SQLException e) { ; }
				rs = null;
			}
			if (stmt != null) {
				try { stmt.close(); } catch (SQLException e) { ; }
				stmt = null;
			}
			if (con != null) {
				try { con.close(); } catch (SQLException e) { ; }
				con = null;
			}
		}
	%>
