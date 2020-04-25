  <%@ page import="java.sql.*" %>
	<%! String errorMessage; %>
	<%
	if(session.getAttribute("userid")!=null){
        errorMessage=null;
        if(!request.getMethod().equals("GET")){
            try {

                // Initialize the database
                new org.postgresql.Driver();
                java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

                String username = dbUri.getUserInfo().split(":")[0];
                String password = dbUri.getUserInfo().split(":")[1];
                String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

                Connection con=DriverManager.getConnection(dbUrl, username, password);
                Statement stmt = con.createStatement();
                int d=Integer.parseInt(request.getParameter("inp-date"));
                int m=Integer.parseInt(request.getParameter("inp-month"));
                int y=Integer.parseInt(request.getParameter("inp-year"));
                String date=String.format("%4d-%02d-%02d",y,m+1,d);
                String insert=("insert into events(day,crop,eventtype,remark,user_id) values( TO_DATE('"+
                            date+"', 'YYYY-MM-DD'), '"+request.getParameter("crop")+
                            "','"+request.getParameter("eventtype")+"', '"+request.getParameter("remark")+"', "+
                            (String)session.getAttribute("userid") +")");

                stmt.executeUpdate(insert);

                stmt.close();
                con.close();
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    else
        errorMessage="You are not logged in.";
	%>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/calendar/calendar.css">
  <script src="${pageContext.request.contextPath}/assets/js/calendar/calendar.js" charset="utf-8"></script>

    <div class="calendar" >
      <div class="calendar-content">
        <div class="" style="height:40px; ">
          <svg style="max-height:400px!important; width:660px;">
            <path d="M-10,60 C-10,0 40,0 40,40 "
            stroke="gray" fill="none" stroke-width="2px" />

            <circle cx="20" cy="60" r="6" />
            <path d="M20,60 C20,0  70,0 70,40 "
            stroke="gray" fill="none" stroke-width="2px"  />

            <circle cx="50" cy="60" r="6" />
            <path d="M50,60 C50,0  100,0 100,040 "
            stroke="gray" fill="none"  stroke-width="2px" />

            <circle cx="80" cy="60" r="6" />
            <path d="M80,60 C80,0  130,0 130,40 "
            stroke="gray" fill="none" stroke-width="2px"  />

            <circle cx="110" cy="60" r="6" />
            <path d="M110,60 C110,0 160,0 160,40 "
            stroke="gray" fill="none"  stroke-width="2px" />

            <circle cx="140" cy="60" r="6" />
            <path d="M140,60 C140,0  190,0 190,40 "
            stroke="gray" fill="none" stroke-width="2px"  />

            <circle cx="170" cy="60" r="6" />
            <path d="M170,60 C170,0  220,0 220,40 "
            stroke="gray" fill="none" stroke-width="2px"  />

            <circle cx="200" cy="60" r="6" />
            <path d="M200,60 C200,0  250,0 250,40 "
            stroke="gray" fill="none" stroke-width="2px"  />

            <circle cx="230" cy="60" r="6" />
            <path d="M230,60 C230,0  280,0 280,40 "
            stroke="gray" fill="none"  stroke-width="2px" />

            <circle cx="260" cy="60" r="6" />
            <path d="M260,60 C260,0  310,0 310,40 "
            stroke="gray" fill="none"  stroke-width="2px" />

            <circle cx="290" cy="60" r="6" />
            <path d="M290,60 C290,0  340,0 340,40 "
            stroke="gray" fill="none"  stroke-width="2px" />

            <circle cx="320" cy="60" r="6" />
            <path d="M320,60 C320,0  370,0 370,40 "
            stroke="gray" fill="none"  stroke-width="2px" />

            <circle cx="350" cy="60" r="6" />
            <path d="M350,60 C350,0  400,0 400,40 "
            stroke="gray" fill="none" stroke-width="2px"  />

            <circle cx="380" cy="60" r="6" />
            <path d="M380,60 C380,0  430,0 430,40 "
            stroke="gray" fill="none"  stroke-width="2px" />

            <circle cx="410" cy="60" r="6" />
            <path d="M410,60 C410,0  460,0 460,40 "
            stroke="gray" fill="none" stroke-width="2px"  />

            <circle cx="440" cy="60" r="6" />
            <path d="M440,60 C440,0  490,0 490,40 "
            stroke="gray" fill="none" stroke-width="2px"  />

            <circle cx="470" cy="60" r="6" />
            <path d="M470,60 C470,0  520,0 520,40 "
            stroke="gray" fill="none" stroke-width="2px"  />

            <circle cx="500" cy="60" r="6" />
            <path d="M500,60 C500,0  550,0 550,40 "
            stroke="gray" fill="none"  stroke-width="2px" />

            <circle cx="530" cy="60" r="6" />
            <path d="M530,60 C530,0  580,0 580,40 "
            stroke="gray" fill="none" stroke-width="2px"  />

            <circle cx="560" cy="60" r="6" />
            <path d="M560,60 C560,0  610,0 610,40 "
            stroke="gray" fill="none"  stroke-width="2px" />

            <circle cx="590" cy="60" r="6" />
            <path d="M590,60 C590,0  640,0 640,40 "
            stroke="gray" fill="none"  stroke-width="2px" />

            <circle cx="620" cy="60" r="6" />
            <path d="M620,60 C620,0  670,0 660,40 "
            stroke="gray" fill="none"  stroke-width="2px" />

          </svg>

        </div>
        <div class="cal-box">
          <div class="cal-head">
              <div class = "change-month-arrow" >
                  <svg width="30" height="20" id="btn-prev">
                      <path d="M30,0 L0, 10 L30, 20 z" fill="black" stroke="black" />
                  </svg>
                  <span id="prev-month" hidden></span>
                  <span id="prev-year" hidden></span>
              </div>
              <div style="display: inline-block; padding-top:20px;">
                  <h3><span id="cal-month"></span>, <span id="cal-year"></span></h3>
              </div>
              <div class = "change-month-arrow">

                  <svg width="30" height="20" id="btn-next">
                      <path d="M0,0 L30, 10 L0, 20 z" fill="black" stroke="black" />
                  </svg>

                  <span id="next-month" hidden></span>
                  <span id="next-year" hidden></span>
              </div>
          </div>
          <div class="cal-main" >
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
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                  </tr>
                  <tr class="cal-num">
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                  </tr>
                  <tr class="cal-num">
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                  </tr>
                  <tr class="cal-num">
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                  </tr>
                  <tr class="cal-num">
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                  </tr>
                  <tr class="cal-num">
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></td>
                      <td ></tr>
                  </tr>

              </table>

          </div>

        </div>
      </div>
      <div class="calendar-stats">
        <div class="stats-overview">
          <label for="table1" class="table-label">This month</label>
          <table id="table1">

          </table><br>
        </div>
        <div class="crop-stats">
          <label for="" class="table-label">Crops</label>
          <table>
            <tr>
              <th>Crop</th><th>No of Events</th>
            </tr>
            <tbody id="table2-body">

            </tbody>

          </table><br>
        </div>
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
    <div class="modal" id="add-event-modal">
        <div class="modal-content" style="text-align: center;">
            <span class="close">&times;</span>
            <form method="POST" style="margin-bottom: 30px;">

                <h2 >Add Event</h2>
                <div >
                    <input type="number" name="inp-date" id="inp-date" hidden>
                    <input type="number" name="inp-month" id="inp-month" hidden>
                    <input type="number" name="inp-year" id="inp-year" hidden>
                </div>

                <div style="display: inline-block;">
                    <label for="">Crop: </label>
                    <select name="crop">
                        <option value="Paddy">Paddy</option>
                        <option value="Wheat">Wheat</option>
                        <option value="Dal">Dal</option>
                        <option value="Vegetable1">Vegetable1</option>
                        <option value="Vegetable2">Vegetable2</option>
                        <option value="Vegetable3">Vegetable3</option>
                        <option value="Vegetable4">Vegetable4</option>
                    </select>
                </div>
                <div style="display: inline-block;">
                    <label for="">Event: </label>
                    <select name="eventtype">
                        <option value="Sowing">Sowing</option>
                        <option value="Harvesting">Harvesting</option>
                        <option value="Fertilizing">Fertilizing</option>
                    </select>
                </div>
                <div>
                    <label for="">Remark: </label>
                    <input type="text" name="remark" placeholder="Remark">
                </div>

                <div style="display: inline-block;">
                    <input type="submit" value="Add Event">
                </div>
            </form>
        </div>
    </div>
    <div class="modal" id="show-event-modal">
        <div class="modal-content" style="text-align: center;">
            <span class="close">&times;</span>
            <h2 style="display: inline;">Event Details</h2>
            <h4><b>Date :</b> <span class="event-date"></span> </h4>
            <ul class="event-list"></ul>
            <div style="display: inline-block; user-select:none; -webkit-user-select:none; -moz-user-select:none; text-align: right; width: 100%;">

                <svg height="60" width="60" onclick="document.querySelector('#show-event-modal').style.display='none'; document.querySelector('#add-event-modal').style.display='block';" style="cursor: pointer;">
                    <path d="M10,30 L30,30 " stroke="blue" stroke-width="5" />
                    <path d="M30,30 L50,30" stroke="#ffc107" stroke-width="5" />
                    <path d="M30,30 L30,50" stroke="red" stroke-width="5" />
                    <path d="M30,30 L30,10" stroke="green" stroke-width="5" />
                    <circle cx="30" cy="30" r="30" fill="gray" opacity="0.1" />
                </svg>

            </div>

        </div>
    </div>
