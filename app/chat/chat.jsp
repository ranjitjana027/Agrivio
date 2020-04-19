<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat Room</title>
    <link rel="stylesheet" href="../../assets/css/chat/chat.css">
      <script src="../../assets/js/chat/chat.js" charset="utf-8"></script>
</head>
<body>

<%
System.out.println(request.getParameter("room")==null);
	if(session.getAttribute("userid")==null)
		response.sendRedirect("../auth/login.jsp");
  else if(request.getParameter("room")==null || ( session.getAttribute("role").equals("FARMER") && !request.getParameter("room").equals(session.getAttribute("userid"))) )
    response.sendRedirect("../user/dashboard.jsp");
  else {
%>
<%@ page import="java.sql.*" %>
<%
    try {

			// Initialize the database
			//String dbURL =  "jdbc:oracle:thin:dummy/passsword@localhost:1521:XE";
			//Connection con = DriverManager.getConnection(dbURL );
      new org.postgresql.Driver();
			java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

      String username = dbUri.getUserInfo().split(":")[0];
      String password = dbUri.getUserInfo().split(":")[1];
      String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

      Connection con=DriverManager.getConnection(dbUrl, username, password);




			//Statement stmt = con.createStatement();
			PreparedStatement st = con.prepareStatement("SELECT * FROM chat_messages where room= ?");//+session.getAttribute("userid"));
			st.setInt(1, Integer.parseInt(request.getParameter("room")));
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
                    <span class="time"><%= rs.getTimestamp("c_time") %></span>
                    <span class="sender"><%= ((String)session.getAttribute("userid")).equals(rs.getString("sender"))?"You":rs.getString("sender_name")  %></span>
                </small>

            </div>
            <%
                    }
                    con.close();
                }
        		catch (Exception e) {
        			e.printStackTrace();
        		}

            %>

        </div>
        <div class="input-message">
            <input type="number" id="userid" value="<%= ((String)session.getAttribute("userid")) %>" readonly hidden />
            <input type="number" id="room" value="<%= request.getParameter("room") %>" readonly hidden />
            <input type="text" class="chat-input" />
            <input type="submit" value="Send" class="submit" />
        </div>
    </div>
</body>
</html>
<%
}
%>
