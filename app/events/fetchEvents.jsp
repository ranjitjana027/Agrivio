<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<% response.setContentType("application/json");
Connection con=null;
PreparedStatement st=null;
ResultSet rs=null;

try {

			// Initialize the database
			new org.postgresql.Driver();
			java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

			String username = dbUri.getUserInfo().split(":")[0];
			String password = dbUri.getUserInfo().split(":")[1];
			String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

			con=DriverManager.getConnection(dbUrl, username, password);

			//Statement stmt = con.createStatement();
			st = con.prepareStatement("SELECT * FROM events where user_id=? and not removed");
			st.setInt(1, Integer.parseInt((String)session.getAttribute("userid")));
			//st.setString(2, request.getParameter("password"));
			rs=st.executeQuery();
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
		finally {

			if (rs != null) {
				try { rs.close(); } catch (SQLException e) { ; }
				rs = null;
			}
			if (st != null) {
				try { st.close(); } catch (SQLException e) { ; }
				st = null;
			}
			if (con != null) {
				try { con.close(); } catch (SQLException e) { ; }
				con = null;
			}
		}


%>
