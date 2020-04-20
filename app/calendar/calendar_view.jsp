
  <link rel="stylesheet" href="../../assets/css/calendar/calendar.css">
<script src="../../assets/js/calendar/calendar.js" charset="utf-8"></script>
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
    <div class="calendar" >
        <div class="cal-head">
            <div style="display: inline; user-select:none; -webkit-user-select:none; -moz-user-select:none; padding-top:15px;">
                <svg width="30" height="20" id="btn-prev">
                    <path d="M30,0 L0, 10 L30, 20 z" fill="black" stroke="black" />
                </svg>
                <span id="prev-month" hidden></span>
                <span id="prev-year" hidden></span>
            </div>
            <div style="display: inline-block;">
                <h3><span id="cal-month"></span>, <span id="cal-year"></span></h3>
            </div>
            <div style="display: inline; user-select:none; -webkit-user-select:none; -moz-user-select:none; padding-top:15px;">

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
