<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<t:wrapper>
  <jsp:attribute name="header">
    <title>Crop Suggestion - Based on soil of you location</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/suggestion/suggestion.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/ads/ads.css">
  </jsp:attribute>
  <jsp:body>

    <div class="recommendation-system">
      <div class="row">
        <div class="col-4 col-sm-6 col-xs-12">
          <header>
            Set your location
          </header>
          <div class="user-location-options">

            <div class="">
              <button id="manual-location-btn">Manually</button><br> or <br><button id="gps-location-btn">using GPS</button>
            </div>
          </div>
          <script src="../../assets/js/weatherv2/weather.js" charset="utf-8"></script>
          <script src='https://api.mapbox.com/mapbox-gl-js/v1.8.1/mapbox-gl.js'></script>
          <link href='https://api.mapbox.com/mapbox-gl-js/v1.8.1/mapbox-gl.css' rel='stylesheet' />
          <!--div class="loading-div-container" id="loading-1">
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
          </div-->

          <div class="current-weather-container">
            <header>
              Current Weather
            </header>
            <p class="no-location-info">
              Weather info will appear after you set location.
            </p>
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
            <span id="current-longitude" hidden></span>
            <span id="current-latitude" hidden></span>
            </div>
            <div class="set-location">

                <div class="set-location-content" style="width:95%; max-width:800px;">
                  <div>
                    Drag the marker to your location.
                  </div>
                  <div class="" style="width:100%;">
                    <div class="target" style="height:500px; width:100%;" >
                      <div id='map' ></div>
                      <pre id="coordinates" class="coordinates"></pre>
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
        </div>
        <div class="col-8 col-sm-6 col-xs-12">
          <header>
            Recommended Crops
          </header>
          <p class="no-location-info">
            Recommendation will appear after you set location.
          </p>
          <table id="recommendation-table">
            <thead>
              <tr>
                <th rowspan="2">Crop</th><th colspan="3">Season</th> <!--<th>Cost</th><th>Profit</th>-->
              </tr>
              <tr>
                <th>Rabi</th><th>Kharif</th><th>Summer</th>
              </tr>
            </thead>
            <tbody id="recommendation-table-body">

            </tbody>

          </table>
        </div>
      </div>
      <div class="row">
        <div class="col-12 col-xs-12 col-sm-12">
          <div class="ad-section">
            <p>Ads</p>
            <div class="ads">
              <c:catch var="exception">
                  <c:set var="dbUri"  value="<%=new java.net.URI( System.getenv(\"DATABASE_URL\") ) %>"/>
                  <sql:setDataSource
                    var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />

                  <sql:query dataSource="${connection}" var="result">
                    select * from ads where lower(target) like '%cropprice%' order by id limit 7;
                  </sql:query>
              </c:catch>
              <c:if test="${result.rowCount>0}">
                <c:forEach items="${result.rows}" var="i">
                  ${i.code}
                </c:forEach>
              </c:if>
            </div>
          </div>
        </div>
      </div>
    </div>


  </jsp:body>
</t:wrapper>
