
  eventdata=null;
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
          //dates[0].children[i].onclick = addEvent;
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
          //dates[nr].children[c].onclick = addEvent;
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

          document.querySelector('.crop-stats').classList.remove('show');
          document.querySelector('.event-type-stats').classList.remove('show');
          if(eventdata==null)
          {
            request = new XMLHttpRequest();
            request.open("GET", location.protocol + "//" + location.host + "/webProject/calendar/events");
            request.onload = () => {
                eventdata = JSON.parse(request.responseText)['events']
                console.log(eventdata);
                fetchEventUtil(eventdata);
            }
            request.send();

          }
          else {
            fetchEventUtil(eventdata);
          }
      }

function fetchEventUtil(data)
{
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
    var eventstats={};
    eventstats.noofevents=mdata.length;
    eventstats.eventdays=new Set();
    eventstats.events={}
    eventstats.events.crop=new Object();
    eventstats.events.eventtype={};
    for(let i=0;i<mdata.length;i++)
    {
        var ed = new Date(mdata[i].date);
        console.log(ed.getDate())
        eventstats.eventdays.add(ed.getDate());
        if(eventstats.events.crop.hasOwnProperty(mdata[i].crop))
        {
          eventstats.events.crop[mdata[i].crop]+=1;
        }
        else{
          eventstats.events.crop[mdata[i].crop]=1;
        }

        if(eventstats.events.eventtype.hasOwnProperty(mdata[i].eventtype))
        {
          eventstats.events.eventtype[mdata[i].eventtype]+=1;
        }
        else{
          eventstats.events.eventtype[mdata[i].eventtype]=1;
        }
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
    console.log(eventstats)
    document.querySelector('#table1').innerHTML="<tr><th>No of Events</th><td>"+eventstats.noofevents+"</td></tr>"
                              +"<tr><th>No of days of Event</th><td>"+eventstats.eventdays.size+"</td></tr>"
                              +"<tr><th>No of Crops Mentioned</th><td>"+Object.keys(eventstats.events.crop).length+"</td></tr>";
    document.querySelector('.stats-overview').classList.add('show');
    document.querySelector('#table2-body').innerHTML=""
    for(let c in eventstats.events.crop){
      var tr=document.createElement('tr');
      var td1=document.createElement('td');
      var td2=document.createElement('td');
      td1.innerHTML=c;
      td2.innerHTML=eventstats.events.crop[c];
      tr.append(td1);
      tr.append(td2);
      document.querySelector('#table2-body').append(tr);
    }
    document.querySelector('#table3-body').innerHTML=""
    for(let c in eventstats.events.eventtype){
      var tr=document.createElement('tr');
      var td1=document.createElement('td');
      var td2=document.createElement('td');
      td1.innerHTML=c;
      td2.innerHTML=eventstats.events.eventtype[c];
      tr.append(td1);
      tr.append(td2);
      document.querySelector('#table3-body').append(tr);
    }

    if(eventstats.noofevents>0){
      document.querySelector('.crop-stats').classList.add('show');
      document.querySelector('.event-type-stats').classList.add('show');
    }
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
          document.querySelector('#show-event-modal').querySelector('.event-date').innerText =
                evt.target.querySelector('.date-day').innerText + '/'
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
