<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<% response.setContentType("application/json");


try { 

			// Initialize the database 
			String dbURL =  "jdbc:oracle:thin:dummy/passsword@localhost:1521:XE"; 		
			Connection con = DriverManager.getConnection(dbURL );

			//Statement stmt = con.createStatement();
			PreparedStatement st = con.prepareStatement("SELECT * FROM events where farmer="+(String)session.getAttribute("userid"));
			//st.setString(1, request.getParameter("mobile")); 
			//st.setString(2, request.getParameter("password"));
			ResultSet rs=st.executeQuery();
%>
{ "events": [
<%			
			if(rs.next())
			{
%>
        {
        "id":"<%= (rs.getString("id")) %>",
        "date":"<%= (rs.getString("day").substring(0,10)) %>",
        "crop":"<%= rs.getString("crop") %>",
        "eventtype":"<%= rs.getString("eventtype") %>",
        "remark":"<%= rs.getString("remark") %>"
        }
<%
				
			}
%>
<%			
			while(rs.next())
			{
%>
        , {
        "id":"<%= (rs.getString("id")) %>",
        "date":"<%= (rs.getString("day").substring(0,10)) %>",
        "crop":"<%= rs.getString("crop") %>",
        "eventtype":"<%= rs.getString("eventtype") %>",
        "remark":"<%= rs.getString("remark") %>"
        }
<%
				
			}
%>
]
}
<%
			
		} 
		catch (Exception e) { 
			e.printStackTrace(); 
		} 


%>
