<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<c:set var="dbUri"  value="<%=new java.net.URI(System.getenv(\"DATABASE_URL\")) %>"/>

<sql:setDataSource var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}"/>

<sql:query dataSource="${connection}" var="result">
  select * from farmers;
</sql:query>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/template/layout.css">
    <div class="chat-content">
      <div class="chat-room-selector">
        <div class="chat-header" style="text-align: center; cursor: default;">
          Users
        </div>
        <c:forEach var="rs" items="${result.rows}">

          <div class="user-chat-room">
            <div class="user-card">
              <div class="user-name">
                ${rs.fullname}
              </div>
              <div class="user-email">
                ${rs.mobile}
              </div>
              <div class="user-id hidden">
                ${rs.id}
              </div>
            </div>
          </div>
        </c:forEach>


      </div>
      <div class="chat-container mobile-hidden">
        <div class="chat-header transparent" id="room-name-header">
          <span id="back-arrow" class="desktop-hidden">&lArr;</span> <span id="room-name">Anonymous Guy</span>
        </div>
        <div class="room-select-alert mobile-hidden">
          Select a user to display messages;
        </div>
        <div class="chat transparent">
            <div class="chat-room">
            </div>
            <div class="input-message">
                <div class="row">
                    <div class="col-1 col-sm-1 col-xs-1">
                      <svg viewBox="0 0 40 40" class="pulse">
                        <circle id="outerCircle" cx="20" cy="25" />
                        <circle id="innerCircle" cx="20" cy="25" r="8" />
                      </svg>
                    </div>
                    <div class="col-9 col-sm-8 col-xs-7" style="padding:5px;">
                        <input type="number" id="userid" value="${sessionScope.userid}" readonly hidden />
                        <input type="number" id="room"  readonly hidden />
                        <input type="text" class="chat-input" placeholder="Type here .." />
                    </div>
                    <div class="col-2 col-sm-3 col-xs-4">
                        <input type="submit" value="Send" class="submit" />
                    </div>
                </div>
            </div>
        </div>
      </div>
    </div>
    <script type="text/javascript">
    document.querySelectorAll('.chat-room-selector > .user-chat-room').forEach(item=>{
      item.addEventListener('click',()=>{
          document.querySelectorAll('.chat-room-selector > .user-chat-room').forEach(itm=>{
            itm.classList.remove("active-room");
          });
          item.classList.add("active-room");
          document.querySelector(".chat-input").disabled=true;
          document.querySelector(".submit").disabled=true;
          document.querySelector(".pulse").classList.remove("connected");
          document.querySelector("#room-name").innerText=item.querySelector(".user-name").innerText
          document.querySelector(".chat").classList.remove("transparent");
          document.querySelector("#room-name-header").classList.remove("transparent");
          document.querySelector('.room-select-alert').classList.add("hidden");
          document.querySelector('.chat-room-selector').classList.add('mobile-hidden');
          document.querySelector('.chat-container').classList.remove('mobile-hidden');

          document.querySelector("#room").value=item.querySelector('.user-id').innerText.trim();
          document.querySelector('.chat-room').innerHTML="Loading";
          get_chats(document.querySelector("#room").value);
          chat();

      });
    });

    document.querySelector("#back-arrow").addEventListener("click",()=>{
      document.querySelector('.chat-room-selector').classList.remove('mobile-hidden');
      document.querySelector('.chat-container').classList.add('mobile-hidden');
    });

    // chat_messages
    function get_chats(room){
      var request=new XMLHttpRequest();
      request.open("GET",location.protocol+"//"+location.host+"/admin/view-chats?room="+room);
      request.onload=()=>{
        var data=JSON.parse(request.responseText);
        console.log(data);
        document.querySelector('.chat-room').innerHTML="";
        data.messages.forEach(item=>{
          var d=document.createElement('div');
          if(item.status)
          {
              d.classList.add('status');
              if (item.sender == document.querySelector('#userid').value) {
              d.innerText='You '+item.content;
              }
              else {
                  d.innerText=item.sender_name+' '+item.content;
              }

          }
          else
          {
              var outerDiv=document.createElement("div");
              outerDiv.classList.add('chat-message');
              var p=document.createElement('p');
              p.classList.add('content');
              var s=document.createElement('small');
              var s1=document.createElement('span');
              var s2=document.createElement('span');
              s1.classList.add('time');
              s1.classList.add("sent");
              s2.classList.add('sender');
              s1.innerText=new Date(item.date+" GMT+00:00").toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
              s2.innerText=item.sender_name;
              if(item.sender==document.querySelector('#userid').value){
                  s2.innerText="You";
                  d.classList.add('you');
              }
              else{
                  d.classList.add('they');
              }

              p.innerText=item.content;
              s.append(s1);
              s.append(s2);
              outerDiv.append(p);
              outerDiv.append(s);
              d.append(outerDiv);
          }
          document.querySelector('.chat-room').append(d);
        });
        document.querySelector('.chat-room').scrollTop=document.querySelector('.chat-room').scrollHeight-document.querySelector('.chat-room').offsetHeight;
        document.querySelector(".chat-input").disabled=false;
        document.querySelector(".submit").disabled=false;
      };
      request.send();
    }


    // websocket
    function chat(){
        if(window.WebSocket)
        {
          if(typeof(ws)=="undefined" || ws.readyState!=1){
            ws=new WebSocket((window.location.protocol == 'http:' ? 'ws:' :'wss:') + window.location.host +
            '/chat/' + document.querySelector('#room').value + '/' +document.querySelector('#userid').value);
          }
          else{
            ws.close();
            ws=new WebSocket((window.location.protocol == 'http:' ? 'ws:' :'wss:') + window.location.host +
            '/chat/' + document.querySelector('#room').value + '/' +document.querySelector('#userid').value);
          }

        }
        else{
            alert("Browser doesn't support WebSocket");
            return;
        }
        chatroom=document.querySelector('.chat-room');
        chatroom.scrollTop=chatroom.scrollHeight-chatroom.offsetHeight;
        ws.onopen=()=>{
            console.log("connecting");
            document.querySelector('.chat-input').onkeydown=evt=>{
                if(evt.keyCode==13 && document.querySelector('.chat-input').value.trim()!="")
                {
                    send_message();
                }
            }
            document.querySelector('.submit').onclick=evt=>{
                if(document.querySelector('.chat-input').value.trim()!="")
                {
                  send_message();
                }
            }
        }
        ws.onclose=()=>{
            console.log("disconnected");
            document.querySelector(".pulse").classList.remove("connected");
        }
        ws.onmessage=message=>{
            console.log(JSON.parse(message.data));
            var data=JSON.parse(message.data);
            if(data.status)
            {
              if(data.content=="joined" && data.room==document.querySelector("#room").value)
                document.querySelector(".pulse").classList.add("connected");
              else if (data.room == document.querySelector("#room").value && data.content == "has left")
                document.querySelector(".pulse").classList.remove("connected");
            }
            else if(data.room == document.querySelector("#room").value){
              var target=Array.from(document.querySelectorAll('small > .timestamp' ) ).filter( item => item.innerText == data.timestamp );
              if(target.length>0 && data.sender==document.querySelector("#userid").value)
              {
                target[0].parentElement.firstElementChild.classList.add('sent')
              }
              else{
                add_message(data);
              }
            }
        }
    }

    function add_message(msg){

      var d=document.createElement('div');
      var outerDiv=document.createElement("div");
      outerDiv.classList.add('chat-message');
      var p=document.createElement('p');
      p.classList.add('content');
      var s=document.createElement('small');
      var s1=document.createElement('span');
      var s2=document.createElement('span');
      s1.classList.add('time');
      s2.classList.add('sender');
      s1.innerText=new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
      if(msg.sender==document.querySelector("#userid").value){
        s1.classList.add('sent')
        s2.innerText = 'You';
        d.classList.add('you');
      }
      else{
        s2.innerText=msg.sender_name;
        d.classList.add('they');
      }
      p.innerText=msg.content;
      s.append(s1);
      outerDiv.append(s2);
      outerDiv.append(p);
      outerDiv.append(s);
      d.append(outerDiv);
      chatroom=document.querySelector('.chat-room');
      chatroom.append(d);
      chatroom.scrollTop=chatroom.scrollHeight-chatroom.offsetHeight;


    }

    function send_message(){
      var msg={
        timestamp: new Date().getTime(),
        content:document.querySelector('.chat-input').value.trim()
      };
      ws.send(JSON.stringify(msg));

      var d=document.createElement('div');
      var outerDiv=document.createElement("div");
      outerDiv.classList.add('chat-message');
      var p=document.createElement('p');
      p.classList.add('content');
      var s=document.createElement('small');
      var s1=document.createElement('span');
      var s2=document.createElement('span');
      s1.classList.add('time');
      s1.classList.add('sending');
      s2.classList.add('sender');
      s1.innerText=new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
      s2.innerText="You";
      d.classList.add('you');
      var s3= document.createElement('span');
      s3.classList.add("timestamp");
      s3.classList.add("hidden");
      s3.innerText = msg.timestamp;
      p.innerText=msg.content;
      s.append(s1);
      s.append(s3);
      outerDiv.append(s2);
      outerDiv.append(p);
      outerDiv.append(s);
      d.append(outerDiv);
      chatroom=document.querySelector('.chat-room');
      chatroom.append(d);
      chatroom.scrollTop=chatroom.scrollHeight-chatroom.offsetHeight;

      document.querySelector('.chat-input').value="";

    }
    </script>
