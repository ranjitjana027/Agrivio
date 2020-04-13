<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<% response.setContentType("application/json");


try { 

			// Initialize the database 
			new org.postgresql.Driver();
			java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

			String username = dbUri.getUserInfo().split(":")[0];
			String password = dbUri.getUserInfo().split(":")[1];
			String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

			Connection con=DriverManager.getConnection(dbUrl, username, password);

			//Statement stmt = con.createStatement();
			PreparedStatement st = con.prepareStatement("SELECT * FROM events where user_id="+(String)session.getAttribute("userid"));
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
        "remark":"<%= rs.getString("remark")==null?"":rs.getString("remark") %>"
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
        "remark":"<%= rs.getString("remark")==null?"":rs.getString("remark") %>"
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
