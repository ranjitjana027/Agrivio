<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat Room</title>
    <link rel="stylesheet" href="../../assets/css/chat/chat.css">
</head>
<body>
<%
	if((String)session.getAttribute("userid")==null)
		response.sendRedirect("../auth/login.jsp");
%>
<%@ page import="java.sql.*" %>
<%
    try { 
			
			// Initialize the database 
			//String dbURL =  "jdbc:oracle:thin:dummy/passsword@localhost:1521:XE"; 		
			//Connection con = DriverManager.getConnection(dbURL );
			java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

                String username = dbUri.getUserInfo().split(":")[0];
                String password = dbUri.getUserInfo().split(":")[1];
                String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

                Connection con=DriverManager.getConnection(dbUrl, username, password);
                



			//Statement stmt = con.createStatement();
			PreparedStatement st = con.prepareStatement("SELECT * FROM chats where sender="+session.getAttribute("userid"));
			//st.setString(1, session.getAttribute("userid")); 
			ResultSet rs=st.executeQuery();
			
			

%>
    <div class="container">
        <div class="chat-room">
            <div class="chat-message <%= !((String)session.getAttribute("userid")).equals("you")?"you":"they" %>">
                <p class="content">Hi I Want to ask you some question?</p>
                <small>
                    <span class="time">7:01pm</span>
                    <span class="sender">You</span>
                </small>
            </div>
            <div class="status">
                You joined.
            </div>
            <div class="chat-message <%= ((String)session.getAttribute("userid")).equals("you")?"you":"they" %>">
        
                <p class="content">This is a message content</p>
                <small>
                    <span class="time">7:06pm</span>
                    <span class="sender">Expert</span>
                </small>
        
            </div>
            <%
                    while(rs.next())
                    {
                %>
            <div
                class="chat-message <%= ((String)session.getAttribute("userid")).equals(rs.getString("sender"))?"you":"they" %>">
        
                <p class="content"><%= rs.getString("content") %></p>
                <small>
                    <span class="time"><%= rs.getString("c_time") %></span>
                    <span class="sender"><%= rs.getString("sender") %></span>
                </small>
        
            </div>
            <%
                    }
                } 
        		catch (Exception e) { 
        			e.printStackTrace(); 
        		} 
        
                %>
        
        
        
        
        
        </div>
        <div class="input-message">
            <input type="number" id="userid" value="<%= ((String)session.getAttribute("userid")) %>" readonly hidden />
            <input type="text" class="chat-input" />
            <input type="submit" value="Send" class="submit" />
        </div>
    </div>
    
    <script>

    chat();
    function chat(){
        if(window.WebSocket)
        {
            ws=new WebSocket('ws://' + window.location.host +
            '/farmer/chat/' + document.querySelector('#userid').value);
        }
        else{
            alert("Browser doesn't support WebSocket");
            return;
        }
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
                    d.innerText=d.sender+d.content;
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
        }
    }
    </script>
</body>
</html>