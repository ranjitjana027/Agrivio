<%
System.out.println(request.getParameter("room")==null);
	if(session.getAttribute("userid")==null)
		response.sendRedirect("${pageContext.request.contextPath}/login");
  else if(request.getParameter("room")==null || ( session.getAttribute("role").equals("FARMER") && !request.getParameter("room").equals(session.getAttribute("userid"))) )
    response.sendRedirect("${pageContext.request.contextPath}/dashboard");
  else {
%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/chat/chat.css">
<script src="${pageContext.request.contextPath}/assets/js/chat/chat.js" charset="utf-8"></script>
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
    <div class="chat">
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
                    <span
                        class="sender"><%= ((String)session.getAttribute("userid")).equals(rs.getString("sender"))?"You":rs.getString("sender_name")  %></span>
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
    <div class="faq">
        <div class="article">
            <a href="#">
                <h3>This Is an Article Name</h3>
            </a>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the
                industry's standard dummy text ever since the 1500s.</p>
        </div>
        <div class="article">
            <a href="#">
                <h3>This Is an Article Name</h3>
            </a>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the
                industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and
                scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap
                into electronic typesetting, remaining essentially unchanged.</p>
        </div>
        <div class="article">
            <a href="#">
                <h3>This Is an Article Name</h3>
            </a>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>
        </div>
        <div class="article">
            <a href="#">
                <h3>This Is an Article Name</h3>
            </a>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the
                industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and
                scrambled it to make a type specimen book.</p>
        </div>
        <div class="article">
            <a href="#">
                <h3>This Is an Article Name</h3>
            </a>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the
                industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and
                scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap
                into electronic typesetting, remaining essentially unchanged.</p>
        </div>
        <div class="article">
            <a href="#">
                <h3>This Is an Article Name</h3>
            </a>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the
                industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and
                scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap
                into electronic typesetting, remaining essentially unchanged.</p>
        </div>
        <div class="article">
            <a href="#">
                <h3>This Is an Article Name</h3>
            </a>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the
                industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and
                scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap
                into electronic typesetting, remaining essentially unchanged.</p>
        </div>
        <div class="article">
            <a href="#">
                <h3>This Is an Article Name</h3>
            </a>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the
                industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and
                scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap
                into electronic typesetting, remaining essentially unchanged.</p>
        </div>
    </div>
</div>
<%
}
%>