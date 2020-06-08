<%@ page import="java.sql.*" %>
<%

Connection con = null;
Statement st = null;
  try {

      // Initialize the database
      new org.postgresql.Driver();
      java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

      String username = dbUri.getUserInfo().split(":")[0];
      String password = dbUri.getUserInfo().split(":")[1];
      String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

      con=DriverManager.getConnection(dbUrl, username, password);
      st=con.createStatement();

      String lastId=request.getParameter("lastId");
      st.executeUpdate("update notifications set read=true where  user_id="+(String)session.getAttribute("userid") +" and id<="+lastId);
      
    }
    catch (Exception e) {
        e.printStackTrace();
    }
    finally {

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
