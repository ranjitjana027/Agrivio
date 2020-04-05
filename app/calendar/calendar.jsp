<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calendar</title>
    <style>
        body {
            font-family: Calibri, sans-serif;
            font-family: 'Roboto Condensed', sans-serif;
            color: #333;
            background-image: linear-gradient(to right, #4CAF50  0%, #009688 100%);
        }
        .calendar{
            
            margin:4% 15%;
            width: 500px;
        }
        .cal-head{
            background-color: antiquewhite;
            
            text-align: center;
            padding: 5px;;
        }
        .cal-main{
            background-color: rgb(130, 238, 229);
            width: inherit;
            height: 400px;
        }
        table{
            column-count: auto;
            width: inherit;
            height: inherit;
            
        }
        .cal-day, .cal-num{
            text-align: center;
        }
        .cal-num{
            cursor: pointer;
        }
        .prev-month, .next-month{
            font-weight: lighter;
            opacity: 0.8;
        }
        .curr-month{
            font-weight: 600;
        }
        th{
            
            color: navy;
        }
        td, th{
            padding: 10px;
            
        }
        .today{
                border-radius: 50%;
                border: solid #333 2px;
                color: aliceblue;
                background-color: #333;
        }
        .modal{
            display: none;
            position: fixed;
            z-index: 1;
            width: 100%;
            height:100%;
            top:0;
            left: 0;
            background-color: rgba(0, 0, 0, 0.4);
        }
        .modal-content{
            display: block;
            background-color: aliceblue;
            width: 400px;
            margin: 5% auto;
            padding: 10px;
        }
        .close{
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        .event-display{
            text-decoration: rgb(230, 5, 136) underline;
        }
    </style>
</head>
<body>
    <%@ page import="java.sql.*" %>  
	<%! String errorMessage; %>
	<% 
	if(session.getAttribute("userid")!=null){
        errorMessage=null;
        if(!request.getMethod().equals("GET")){
            try { 

                // Initialize the database 
                String dbURL =  "jdbc:oracle:thin:dummy/passsword@localhost:1521:XE"; 		
                Connection con = DriverManager.getConnection(dbURL );

                Statement stmt = con.createStatement();
                int d=Integer.parseInt(request.getParameter("inp-date"));
                int m=Integer.parseInt(request.getParameter("inp-month"));
                int y=Integer.parseInt(request.getParameter("inp-year"));
                String date=String.format("%4d-%02d-%02d",y,m+1,d);
                String insert=("insert into events values( seq_event.nextval, TO_DATE('"+
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
            <div style="display: inline; user-select:none; -webkit-user-select:none; -moz-user-select:none;">
                <svg width="30" height="20" id="btn-prev">
                    <path d="M30,0 L0, 10 L30, 20 z" fill="black" stroke="black" />
                </svg>
                <span id="prev-month" hidden></span>
                <span id="prev-year" hidden></span>
            </div>
            <div style="display: inline-block; width: 400px;">
                <h3><span id="cal-month"></span>, <span id="cal-year"></span></h3>
            </div>
            <div style="display: inline; user-select:none; -webkit-user-select:none; -moz-user-select:none;">
            
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
    <script>
        
        fillCalendar(new Date().getFullYear(),new Date().getMonth());
        document.getElementById('btn-prev').onclick=()=>{
            fillCalendar(Number(document.getElementById('prev-year').innerText), Number(document.getElementById('prev-month').innerText));
        };
        document.getElementById('btn-next').onclick = () => {
                fillCalendar(Number(document.getElementById('next-year').innerText), Number(document.getElementById('next-month').innerText));
        };
        
        

        function fillCalendar(year,month)
        {
            months = [['January', 31],
                ['February', 28, 29],
                ['March', 31],
                ['April', 30],
                ['May', 31],
                ['June', 30],
                ['July', 31],
                ['August', 31],
                ['September', 30],
                ['October', 31],
                ['November', 30],
                ['December', 31]
                ]
            d = new Date(year, month);
            month = d.getMonth();
            year = d.getFullYear();
            document.getElementById('cal-month').innerText = months[month][0];
            document.getElementById('cal-year').innerText = year;
            noOfDays = months[month][1];
            if (month == 1 && ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0))
                noOfDays = 29;


            d = new Date(year, month, 1);
            ad = d.getDay() - 1;
            dates = document.querySelectorAll('.cal-num');
            for (let i = 1; i <= noOfDays; i++) {
                val = ad + i;
                r = Math.floor(val / 7);
                c = val % 7;
                dates[r].children[c].innerHTML =  "<span class='date-day'>"+ i +"</span>" +
                                                    "<span class='date-month' hidden>"+ month +"</span>" +
                                                    "<span class='date-year' hidden>"+ year +"</span>" +
                                                    "<span class='event-count' hidden >0</span>";
                dates[r].children[c].className="curr-month";
                dates[r].children[c].onclick=addEvent;

            }

            //mark today

            today = new Date();
            if (today.getMonth() == month && today.getFullYear() == year) {
                console.log("running")
                date = today.getDate();
                val = ad + date;
                r = Math.floor(val / 7);
                c = val % 7;

                dates[r].children[c].classList.add("today");
            }

            // fill prev month

            prevMonth = (month + 12 - 1) % 12;
            prevYear = year;
            if (prevMonth > month)
                prevYear = year - 1;
            noOfDaysPrevMonth = months[prevMonth][1];
            if (prevMonth == 1 && ((prevYear % 4 == 0 && prevYear % 100 != 0) || prevYear % 400 == 0))
                noOfDaysPrevMonth = 29;
            pi = noOfDaysPrevMonth;
            for (var i = ad; i >= 0; i--) {
                dates[0].children[i].innerHTML = "<span class='date-day'>" + pi-- + "</span>" +
                    "<span class='date-month' hidden>" + prevMonth + "</span>" +
                    "<span class='date-year' hidden>" + prevYear + "</span>";
                dates[0].children[i].className="prev-month";
                dates[0].children[i].onclick = addEvent;
            }
            document.getElementById('prev-month').innerText = prevMonth;
            document.getElementById('prev-year').innerText = prevYear;
            // fill next month
            nextMonth = (month + 12 + 1) % 12;
            nextYear = year;
            if (nextMonth < month)
                nextYear = year + 1;
            ni = 1;
            nval = noOfDays + ad + ni;
            nr = Math.floor(nval / 7);
            nc = nval % 7;
            for (var c = nc; c < 7; c++) {
                dates[nr].children[c].innerHTML =  "<span class='date-day'>" + ni++  +"</span>" +
                "<span class='date-month' hidden>" + nextMonth + "</span>" +
                    "<span class='date-year' hidden>" + nextYear + "</span>";
                dates[nr].children[c].className="next-month";
                dates[nr].children[c].onclick = addEvent;
            }
            for (var r = nr + 1; r < 6; r++) {

                for (var c = 0; c < 7; c++) {
                    dates[r].children[c].innerText ="";// ni++;
                    //dates[r].children[c].className="next-month";
                }
            }
            
            document.getElementById('next-month').innerText = nextMonth;
            document.getElementById('next-year').innerText = nextYear;


            // testing phase
            fetchEvent();
            activateModal();
        }

        function fetchEvent() {
                request = new XMLHttpRequest();
                request.open("GET", location.protocol + "//" + location.host + "/farmer/app/event/fetchEvents.jsp");
                request.onload = () => {
                    data = JSON.parse(request.responseText)['events']
                    console.log(data);
                    monthList = ['January', 'February', 'March', 'April', 'May', 'June', 'July',
                        'August', 'September', 'October', 'November', 'December']
                    var currmonth = monthList.indexOf(document.getElementById('cal-month').innerText);
                    console.log(currmonth)
                    var curryear = document.getElementById('cal-year').innerText;
                    console.log(curryear);

                    ///
                    currmonth=(currmonth+1)
                    var d = new Date(curryear, currmonth-1, 1);
                    var ad = d.getDay() - 1;
                    var dates = document.querySelectorAll('.cal-num');
                    mdata=(data.filter(e => e.date.match(new RegExp(curryear+'-0*'+currmonth+'-.*'))))
                    
                    for(let i=0;i<mdata.length;i++)
                    {
                        var ed = new Date(mdata[i].date);
                        console.log(ed.getDate())
                        var val = ad + ed.getDate();
                        var r = Math.floor(val / 7);
                        var c = val % 7;
                        dates[r].children[c].innerHTML += "<span class='event-id' hidden>" + mdata[i].id + "</span>" +
                            "<span class='crop' hidden >" + mdata[i].crop + "</span>" +
                            "<span class='event-type' hidden >" + mdata[i].eventtype + "</span>" +
                            "<span class='remark' hidden>" + mdata[i].remark + "</span>";
                        //dates[r].children[c].style.textDecoration = "underline";
                        dates[r].children[c].onclick=showEvent;
                        dates[r].children[c].classList.add('event-display')
                        dates[r].children[c].querySelector('.event-count').innerText=Number(dates[r].children[c].querySelector('.event-count').innerText)+1
                    }
                }
                request.send();

            }


        function activateModal(){
            document.querySelectorAll('.close').forEach(function (item) {
                item.onclick = (event) => {
                    console.log(event.target);
                    event.target.offsetParent.style.display="none";
                };
            });
            window.onclick=evt=>{
                document.querySelectorAll('.modal').forEach(function (item) {
                    if(evt.target==item)
                        item.style.display = "none";
            });
            }
            
        }
        function addEvent(evt){
            document.querySelector('#add-event-modal').style.display="block";
            console.log(evt.target.offsetParent)
            if(evt.target.className!='date-day'){
                document.querySelector('#inp-date').value = evt.target.querySelector('.date-day').innerText;
                document.querySelector('#inp-month').value = evt.target.querySelector('.date-month').innerText;
                document.querySelector('#inp-year').value = evt.target.querySelector('.date-year').innerText;
            }
            else
            {
                document.querySelector('#inp-date').value=evt.target.innerText;
                document.querySelector('#inp-month').value = evt.target.offsetParent.children[1].innerText;
                document.querySelector('#inp-year').value = evt.target.offsetParent.children[2].innerText;
            }
        }
        function showEvent(evt) {
            document.querySelector('#show-event-modal').style.display = "block";
            
            console.log(evt.target.offsetParent)
            if (evt.target.className != 'date-day') {
                document.querySelector('#inp-date').value = evt.target.querySelector('.date-day').innerText;
                document.querySelector('#inp-month').value = evt.target.querySelector('.date-month').innerText;
                document.querySelector('#inp-year').value = evt.target.querySelector('.date-year').innerText;

                // show
                var count=Number(evt.target.querySelector('.event-count').innerText);
                console.log('count: '+count)
                table=[]
                for(i=0;i<count;i++)
                {
                    table.push(document.createElement('table'));
                }
                console.log(table)
                tr = []
                for (i = 0; i < 3*count; i++)
                    tr.push(document.createElement('tr'))

                th = []
                for (i = 0; i < 3*count; i++)
                    th.push(document.createElement('th'));
                for(i=0;i<count;i++){
                    th[0 + i * 3].innerText = 'Crop';
                    th[1 + i * 3].innerText = 'Event Type';
                    th[2 + i * 3].innerText = 'Remark';
                }
                

                td = []
                for (i = 0; i < 3 * count; i++)
                    td.push(document.createElement('td'));

                
                for(i=0;i<count;i++)
                {
                    
                    td[i*3].innerText = evt.target.querySelectorAll('.crop')[i].innerText;
                    td[1+i*3].innerText = evt.target.querySelectorAll('.event-type')[i].innerText;
                    td[2+i*3].innerText = evt.target.querySelectorAll('.remark')[i].innerText;
                }
                for(k=0;k<count;k++){
                    for (i = 0; i < 3; i++) {
                        tr[i + k * 3].append(th[i + k * 3]);
                        tr[i + k * 3].append(td[i + k * 3]);
                        table[k].append(tr[i + k * 3])
                    }
                }
                document.querySelector('#show-event-modal').querySelector('.event-list').innerHTML=""
                for(k=0;k<count;k++){
                    var li=document.createElement('li');
                    li.append(table[k]);
                    document.querySelector('#show-event-modal').querySelector('.event-list').append(li);
                }
                document.querySelector('#show-event-modal').querySelector('.event-date').innerText = evt.target.querySelector('.date-day').innerText + '/'
                    + (Number(evt.target.querySelector('.date-month').innerText) + 1) + '/'
                    + evt.target.querySelector('.date-year').innerText;
                

            }
            else { 
                document.querySelector('#inp-date').value = evt.target.innerText;
                document.querySelector('#inp-month').value = evt.target.offsetParent.children[1].innerText;
                document.querySelector('#inp-year').value = evt.target.offsetParent.children[2].innerText;

                // show
                var count = Number(evt.target.parentNode.children[3].innerText);
                console.log('count: ' + count)
                table = []
                for (i = 0; i < count; i++) {
                    table.push(document.createElement('table'));
                }
                console.log(table)
                tr = []
                for (i = 0; i < 3 * count; i++)
                    tr.push(document.createElement('tr'))

                th = []
                for (i = 0; i < 3 * count; i++)
                    th.push(document.createElement('th'));
                for (i = 0; i < count; i++) {
                    th[0 + i * 3].innerText = 'Crop';
                    th[1 + i * 3].innerText = 'Event Type';
                    th[2 + i * 3].innerText = 'Remark';
                }


                td = []
                for (i = 0; i < 3 * count; i++)
                    td.push(document.createElement('td'));


                for (i = 0; i < count; i++) {
                    
                    td[0 + i * 3].innerText = evt.target.parentNode.children[5+i*4].innerText;
                    td[1 + i * 3].innerText = evt.target.parentNode.children[6+i*4].innerText;
                    td[2 + i * 3].innerText = evt.target.parentNode.children[7+i*4].innerText;
                }
                for (k = 0; k < count; k++) {
                    for (i = 0; i < 3; i++) {
                        tr[i + k * 3].append(th[i + k * 3]);
                        tr[i + k * 3].append(td[i + k * 3]);
                        table[k].append(tr[i + k * 3])
                    }
                }
                document.querySelector('#show-event-modal').querySelector('.event-list').innerHTML = ""
                for (k = 0; k < count; k++) {
                    var li = document.createElement('li');
                    li.append(table[k]);
                    document.querySelector('#show-event-modal').querySelector('.event-list').append(li);
                }
                document.querySelector('#show-event-modal').querySelector('.event-date').innerText= evt.target.innerText + '/'
                    + (Number(evt.target.offsetParent.children[1].innerText) + 1) + '/'
                    + evt.target.offsetParent.children[2].innerText;
            }
        }
    </script>
</body>
</html>