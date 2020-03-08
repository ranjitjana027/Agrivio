
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
</head>
<body>
	<%@ page import="java.sql.*" %>  
	<%! String errorMessage; %>
	<% 
	if(session.getAttribute("userid")!=null){
		out.print("<script>alert(\"You're already logged in\"); location.href=\"../user/homepage.jsp \"</script>");
	}
	if(!request.getMethod().equals("GET")){
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
				session.setAttribute("user",rs.getString("firstname")+" "+rs.getString("lastname"));
				session.setAttribute("mobile",rs.getString("mobile"));
			}
			if((String)session.getAttribute("userid")!=null)
				response.sendRedirect("../user/homepage.jsp");
			else
				errorMessage="Invalid Username/Password.";
		} 
		catch (Exception e) { 
			e.printStackTrace(); 
		} 
	}
	%>
	<form method="POST">
		<input type="text" name="mobile" placeholder="Mobile"><br>
		<input type="password" name="password" placeholder="Password"><br>
		<input type="submit" value="Submit">
	</form>
	<div>
		<%= (errorMessage!=null)?errorMessage:"" %>
	</div>

</body>
</html>
