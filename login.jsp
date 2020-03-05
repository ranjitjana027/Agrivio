

<%@ page import="java.sql.*" %>  
<% 
		try { 

			// Initialize the database 
			String dbURL =  "jdbc:oracle:thin:dummy/passsword@localhost:1521:XE"; 		
			Connection con = DriverManager.getConnection(dbURL );
 
			//Statement stmt = con.createStatement();
			PreparedStatement st = con.prepareStatement("SELECT * FROM farmers where mobile=?  and password=?");
			st.setString(1, request.getParameter("mobile")); 
			st.setString(2, request.getParameter("password"));
			ResultSet rs=st.executeQuery();
			
			
			if(rs.next())
			{
				out.println(rs.getString("id"));
				session.setAttribute("userid",rs.getString("id") );
			}
			if((String)session.getAttribute("userid")!=null)
response.sendRedirect("homepage.jsp");

response.sendRedirect("welcome.html");
		} 
	catch (Exception e) { 
			e.printStackTrace(); 
		} 
	 
%>
