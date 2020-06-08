document.addEventListener("DOMContentLoaded",()=>{

      document.querySelector(".chat-input").disabled=true;
      document.querySelector(".submit").disabled=true;
      document.querySelector('.chat-room').innerHTML="Loading";
      get_chats(document.querySelector("#room").value);
      chat();
      function chat(){
          if(window.WebSocket)
          {
            if(typeof(ws)=="undefined" || ws.readyState!=1)
              ws=new WebSocket((window.location.protocol == 'http:' ? 'ws:' :'wss:') + window.location.host +
              '/webProject/chat/' + document.querySelector('#room').value + '/' +document.querySelector('#userid').value);
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

      function get_chats(room){
        var request=new XMLHttpRequest();
        request.open("GET",location.protocol+"//"+location.host+"/webProject/latest/view-chats?room="+room);
        request.onload=()=>{
          if(request.status==200){
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
                  outerDiv.append(s2);
                  outerDiv.append(p);
                  outerDiv.append(s);
                  d.append(outerDiv);
              }
              document.querySelector('.chat-room').append(d);
            });
            document.querySelector('.chat-room').scrollTop=document.querySelector('.chat-room').scrollHeight-document.querySelector('.chat-room').offsetHeight;
            document.querySelector(".chat-input").disabled=false;
            document.querySelector(".submit").disabled=false;
          }
          else{
            document.querySelector('.chat-room').innerHTML="Unable to fetch chats. Refresh page to retry."
          }
        };
        request.send();
      }

});
