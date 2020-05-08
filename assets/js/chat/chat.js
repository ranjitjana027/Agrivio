document.addEventListener("DOMContentLoaded",()=>{

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
              console.log("connected");
              document.querySelector('.chat-input').onkeydown=evt=>{
                  if(evt.keyCode==13)
                  {
                      ws.send(document.querySelector('.chat-input').value);
                      document.querySelector('.chat-input').value="";

                  }
              }
              document.querySelector('.submit').onclick=evt=>{
                  var newObj=
                  ws.send(document.querySelector('.chat-input').value);
                  document.querySelector('.chat-input').value="";
              }
          }
          ws.onclose=()=>{
              console.log("disconnected");
          }
          ws.onmessage=message=>{
              console.log(JSON.parse(message.data));
              var data=JSON.parse(message.data);
              var d=document.createElement('div');
              if(data.status)
              {
                  d.classList.add('status');
                  if (data.sender == document.querySelector('#userid').value) {
                  d.innerText='You '+data.content;
                  }
                  else {
                      d.innerText=data.sender_name+' '+data.content;
                  }

              }
              else
              {   d.classList.add('chat-message');
                  var p=document.createElement('p');
                  p.classList.add('content');
                  var s=document.createElement('small');
                  var s1=document.createElement('span');
                  var s2=document.createElement('span');
                  s1.classList.add('time');
                  s2.classList.add('sender');
                  s1.innerText=data.date;
                  s2.innerText=data.sender;
                  if(data.sender==document.querySelector('#userid').value){
                      s2.innerText="You";
                      d.classList.add('you');
                  }
                  else{
                      d.classList.add('they');
                  }

                  p.innerText=data.content;
                  s.append(s1);
                  s.append(s2);
                  d.append(p);
                  d.append(s);
              }
              document.querySelector('.chat-room').append(d);
              chatroom.scrollTop=chatroom.scrollHeight-chatroom.offsetHeight;
          }
      }

});
