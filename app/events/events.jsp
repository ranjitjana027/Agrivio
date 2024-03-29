<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<c:if test="${pageContext.request.method=='POST' and not empty param.crop and not empty param.eventtype}">
  <c:catch var="exception">
    <c:set var="dbUri"  value="<%=new java.net.URI(System.getenv(\"DATABASE_URL\")) %>"/>

    <sql:setDataSource
      var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />

    <c:choose>
      <c:when test="${not empty param.id}">
        <sql:update dataSource="${connection}">
          update events set crop=?, eventtype=?,remark=? where id=? and user_id=?
          <sql:param value="${param.crop}" />
          <sql:param value="${param.eventtype}" />
          <sql:param value="${param.remark}" />
          <sql:param value="${Integer.parseInt(param.id)}" />
          <sql:param value="${Integer.parseInt(sessionScope.userid)}" />
        </sql:update>
      </c:when>
      <c:otherwise>
        <sql:query dataSource="${connection}" var="result">
          insert into events(day,crop,eventtype,remark,user_id,remainder) values( TO_DATE(?,'YYYY-MM-DD'),?,?,?,?,?) returning id;
          <sql:param value="${ String.format(\"%4d-%02d-%02d\", Integer.parseInt( param['inp-year'] ) , Integer.parseInt ( param['inp-month'] )+1 , Integer.parseInt ( param['inp-date'] ) ) }" />
          <sql:param value="${param.crop}" />
          <sql:param value="${param.eventtype}" />
          <sql:param value="${param.remark}" />
          <sql:param value="${Integer.parseInt(sessionScope.userid)}" />
          <sql:param value="${param.remainder=='true'}"/>
        </sql:query>
        <c:if test="${param.remainder=='true' and result.rowCount>0}" >
          <sql:update dataSource="${connection}">
            insert into notifications(content,user_id,n_time, event_id) values ( ?,?,TO_TIMESTAMP(?,'YYYY-MM-DD') - interval '24 hours', ?), ( ?,?,TO_TIMESTAMP(?,'YYYY-MM-DD'),?);
            <sql:param value="<b>Remainder: </b> ${param.crop} ${param.eventtype } within 24 Hours." />
            <sql:param value="${Integer.parseInt(sessionScope.userid)}" />
            <sql:param value="${ String.format(\"%4d-%02d-%02d\", Integer.parseInt( param['inp-year'] ) , Integer.parseInt ( param['inp-month'] )+1 , Integer.parseInt ( param['inp-date'] ) ) }" />
            <sql:param value="${Integer.parseInt(result.rows[0].id)}"/>
            <sql:param value="<b>Alert: </b> It's time for ${param.crop} ${param.eventtype }." />
            <sql:param value="${Integer.parseInt(sessionScope.userid)}" />
            <sql:param value="${ String.format(\"%4d-%02d-%02d\", Integer.parseInt( param['inp-year'] ) , Integer.parseInt ( param['inp-month'] )+1 , Integer.parseInt ( param['inp-date'] ) ) }" />
            <sql:param value="${Integer.parseInt(result.rows[0].id)}"/>
          </sql:update>
          <c:set var="message" value="Event added successfully"/>
        </c:if>
      </c:otherwise>
    </c:choose>


  </c:catch>
  <c:if test="${not empty exception}">
    <c:set var="errormessage" value="Something went wrong. Don\'t add duplicate event"/>
  </c:if>
  <c:redirect url="${pageContext.request.requestURI}" />
</c:if>

<t:wrapper>
  <jsp:attribute name="header">
    <title>My Events - Manage all events in one place</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/events/events.css">
  </jsp:attribute>
  <jsp:body>
    <div class="calendar">
      <div class="calendar-header">
        Cultivation Events
      </div>

      <div class="row">
        <div class="col-8">
          <c:if test="${ not empty errormessage}">
            <div style="color:red; text-align:center; padding:1.5vw;">
              <span style="display:inline-block; background-color: white; box-shadow: 2px 2px 10px 2px #000000; padding: 5px 15px; "> ${errormessage}.
              <span style="background-color: white; cursor:pointer;" onclick="this.parentNode.parentNode.hidden=true;"> &#10007; </span></span>
            </div>
          </c:if>
          <c:if test="${ not empty message}">
            <div style="color:green; text-align:center; padding:1.5vw;">
              <span style="display:inline-block; background-color: white; box-shadow: 2px 2px 10px 2px #000000; padding: 5px 15px; ">  ${message}.
              <span style="background-color: white; cursor:pointer;" onclick="this.parentNode.parentNode.hidden=true;"> &#10004; </span></span>
            </div>
          </c:if>
          <div class="calendar-content">
              <div class="mobile-hidden" style="height:40px; ">
                  <svg viewBox="0 0 660 150" style="max-height:400px!important; width:100%;">
                      <path d="M-10,60 C-10,0 40,0 40,40 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="20" cy="60" r="6" />
                      <path d="M20,60 C20,0  70,0 70,40 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="50" cy="60" r="6" />
                      <path d="M50,60 C50,0  100,0 100,040 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="80" cy="60" r="6" />
                      <path d="M80,60 C80,0  130,0 130,40 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="110" cy="60" r="6" />
                      <path d="M110,60 C110,0 160,0 160,40 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="140" cy="60" r="6" />
                      <path d="M140,60 C140,0  190,0 190,40 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="170" cy="60" r="6" />
                      <path d="M170,60 C170,0  220,0 220,40 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="200" cy="60" r="6" />
                      <path d="M200,60 C200,0  250,0 250,40 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="230" cy="60" r="6" />
                      <path d="M230,60 C230,0  280,0 280,40 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="260" cy="60" r="6" />
                      <path d="M260,60 C260,0  310,0 310,40 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="290" cy="60" r="6" />
                      <path d="M290,60 C290,0  340,0 340,40 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="320" cy="60" r="6" />
                      <path d="M320,60 C320,0  370,0 370,40 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="350" cy="60" r="6" />
                      <path d="M350,60 C350,0  400,0 400,40 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="380" cy="60" r="6" />
                      <path d="M380,60 C380,0  430,0 430,40 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="410" cy="60" r="6" />
                      <path d="M410,60 C410,0  460,0 460,40 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="440" cy="60" r="6" />
                      <path d="M440,60 C440,0  490,0 490,40 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="470" cy="60" r="6" />
                      <path d="M470,60 C470,0  520,0 520,40 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="500" cy="60" r="6" />
                      <path d="M500,60 C500,0  550,0 550,40 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="530" cy="60" r="6" />
                      <path d="M530,60 C530,0  580,0 580,40 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="560" cy="60" r="6" />
                      <path d="M560,60 C560,0  610,0 610,40 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="590" cy="60" r="6" />
                      <path d="M590,60 C590,0  640,0 640,40 " stroke="gray" fill="none" stroke-width="2px" />

                      <circle cx="620" cy="60" r="6" />
                      <path d="M620,60 C620,0  670,0 660,40 " stroke="gray" fill="none" stroke-width="2px" />
                  </svg>

              </div>
              <div class="cal-box">
                  <div class="cal-head">
                      <div class="change-month-arrow">
                          <svg width="30" height="20" id="btn-prev">
                              <path d="M30,0 L0, 10 L30, 20 z" fill="black" stroke="black" />
                          </svg>
                          <span id="prev-month" hidden></span>
                          <span id="prev-year" hidden></span>
                      </div>
                      <div class="month-header">
                          <h3 style="color:white;"><span id="cal-month"></span>, <span id="cal-year"></span></h3>
                      </div>
                      <div class="change-month-arrow">

                          <svg width="30" height="20" id="btn-next">
                              <path d="M0,0 L30, 10 L0, 20 z" fill="black" stroke="black" />
                          </svg>

                          <span id="next-month" hidden></span>
                          <span id="next-year" hidden></span>
                      </div>
                  </div>
                  <div class="cal-main">
                      <table>
                          <tr class="cal-day">
                              <th>Sun</th>
                              <th>Mon</th>
                              <th>Tue</th>
                              <th>Wed</th>
                              <th>Thu</th>
                              <th>Fri</th>
                              <th>Sat</th>
                          </tr>
                          <tr class="cal-num">
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                          </tr>
                          <tr class="cal-num">
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                          </tr>
                          <tr class="cal-num">
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                          </tr>
                          <tr class="cal-num">
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                          </tr>
                          <tr class="cal-num">
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                          </tr>
                          <tr class="cal-num">
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td>
                          </tr>
                          </tr>

                      </table>

                  </div>

              </div>
          </div>
        </div>
        <div class="col-4">
          <div class="calendar-stats">
              <div class="row">
                <div class="col-12 col-sm-12 col-xs-12">
                  <div class="stats-overview">
                      <label for="table1" class="table-label">This month</label>
                      <table id="table1">

                      </table><br>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-12 col-sm-6 col-xs-12">
                  <div class="crop-stats">
                      <label for="" class="table-label">Crops</label>
                      <table>
                          <tr>
                              <th>Crop</th>
                              <th>No of Events</th>
                          </tr>
                          <tbody id="table2-body">

                          </tbody>

                      </table><br>
                  </div>
                </div>
                <div class="col-12 col-sm-6 col-xs-12">
                  <div class="event-type-stats">
                      <label for="" class="table-label">Type of Events</label>
                      <table>
                          <tr>
                              <th>Event Type</th>
                              <th>No of Events</th>
                          </tr>
                          <tbody id="table3-body">

                          </tbody>
                      </table>
                  </div>
                </div>
              </div>
          </div>
        </div>
      </div>
    </div>

    <div class="modal" id="add-event-modal">
        <div class="modal-content">
            <form method="POST">
                <header>
                  <h2>Edit Event</h2>
                  <span class="close">&times;</span>
                </header>
                <hr>
                <section>
                  <input name="id" id="event_id" readonly hidden >
                  <div>
                      <input type="number" name="inp-date" id="inp-date" hidden>
                      <input type="number" name="inp-month" id="inp-month" hidden>
                      <input type="number" name="inp-year" id="inp-year" hidden>
                  </div>

                  <div>
                      <div class="form-input">
                          <label for="crop_name">Crop</label>
                          <input type="text" name="crop" id="crop_name" placeholder="Crop" list="crop_name_list" required>
                          <datalist id="crop_name_list">
                              <option>Amaranth</option>
                              <option>Apple Gourd</option>
                              <option>Ash Gourd</option>
                              <option>Bajra</option>
                              <option>Barley</option>
                              <option>Beetroot</option>
                              <option>Bitter Gourd</option>
                              <option>Black-eyed pea</option>
                              <option>Bottle Gourd</option>
                              <option>Brinjal</option>
                              <option>Broad Beans</option>
                              <option>Brussels Sprout</option>
                              <option>Cabbage</option>
                              <option>Capsicum</option>
                              <option>Carrot</option>
                              <option>Cauliflower</option>
                              <option>Celery</option>
                              <option>Ceylon Spinach</option>
                              <option>Chickpea</option>
                              <option>Cilantro</option>
                              <option>Cotton</option>
                              <option>Cucumber</option>
                              <option>Drumstick</option>
                              <option>Elephant Foot Yam</option>
                              <option>French Beans</option>
                              <option>Garbanzo</option>
                              <option>Gooseberry</option>
                              <option>Gourd</option>
                              <option>Groundnuts</option>
                              <option>Indian Pea</option>
                              <option>Ivy Gourd</option>
                              <option>Jackfruit</option>
                              <option>Jowar</option>
                              <option>Jute</option>
                              <option>Kidney Bean</option>
                              <option>Lentil</option>
                              <option>Lettuce</option>
                              <option>Lotus Root</option>
                              <option>Malabar Spinach</option>
                              <option>Mint</option>
                              <option>Moth Bean</option>
                              <option>Mushroom</option>
                              <option>Mustard</option>
                              <option>Okra</option>
                              <option>Onion</option>
                              <option>Pea</option>
                              <option>Pigeon Pea</option>
                              <option>Pointed Gourd</option>
                              <option>Potato</option>
                              <option>Pumkin</option>
                              <option>Radish</option>
                              <option>Red Amaranth</option>
                              <option>Red Lentil</option>
                              <option>Rice</option>
                              <option>Ridge Gourd</option>
                              <option>Snake Gourd</option>
                              <option>Spinach</option>
                              <option>Spring Onion</option>
                              <option>String Beans</option>
                              <option>Sugarcane</option>
                              <option>Sweet Corn/Maize</option>
                              <option>Sweet Potato</option>
                              <option>Taro</option>
                              <option>Teasle Gourd</option>
                              <option>Tomato</option>
                              <option>Turnip</option>
                              <option>Turnip Greens</option>
                              <option>Water Spinach</option>
                              <option>Winter Melon</option>
                              <option>Wheat</option>
                          </datalist>
                      </div>
                      <div class="form-input">
                          <label for="event_type">Event</label>
                          <input type="text" name="eventtype" id="event_type" placeholder="Event Type" list="event_type_list" required>
                          <datalist id="event_type_list">
                              <option value="Sowing">Sowing</option>
                              <option value="Harvesting">Harvesting</option>
                              <option value="Fertilizing">Fertilizing</option>
                          </datalist>
                      </div>
                      <div class="form-input">
                          <label for="event_remark">Remark</label>
                          <input type="text" name="remark" id="event_remark" placeholder="Remark">
                      </div>
                  </div>
                  <div class="form-input">
                    <input type="checkbox" id="edit" style="display: none;">
                    <div>
                      <input type="checkbox" name="remainder" id="remainder" value="true" style="width:auto;">
                      <label for="remainder">Add as Remainder</label>
                    </div>
                  </div>
                </section>
                <hr>
                <footer>
                  <div class="form-input">
                      <input type="button" value="Remove" onclick="remRec(this);">
                      <input type="submit" value="Save" id="submit-btn" onclick="addRec(this);" disabled>
                  </div>
                </footer>
            </form>
        </div>
    </div>

    <div class="modal" id="show-event-modal">
        <div class="modal-content">
            <header>
              <h2>Event Details</h2>
              <span class="close">&times;</span>
            </header>
            <hr>
            <section>
              <h4><b>Date :</b> <span class="event-date"></span> </h4>
              <div style="overflow:auto;">
                <ul class="event-list"></ul>
              </div>
            </section>
            <footer>
              <div class="add-event-icon-container">
                  <svg onclick=" document.querySelector('.modal-content form').reset();
                  var date_parts=document.querySelector('span.event-date').innerText.split('/');
                  document.querySelector('#inp-date').value=date_parts[0];
                  document.querySelector('#inp-month').value=Number(date_parts[1])-1;
                  document.querySelector('#inp-year').value=date_parts[2];
                  document.querySelector('#show-event-modal').style.display='none';
                  document.querySelector('#add-event-modal').style.display='block';
                  ">
                      <path d="M10,30 L30,30 " stroke="blue" stroke-width="5" />
                      <path d="M30,30 L50,30" stroke="#ffc107" stroke-width="5" />
                      <path d="M30,30 L30,50" stroke="red" stroke-width="5" />
                      <path d="M30,30 L30,10" stroke="green" stroke-width="5" />
                      <circle cx="30" cy="30" r="30" fill="gray" opacity="0.1" />
                  </svg>
              </div>
            </footer>

        </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/js/lib/custom-select.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/assets/js/calendar/calendar.js" charset="utf-8"></script>
  </jsp:body>
</t:wrapper>
