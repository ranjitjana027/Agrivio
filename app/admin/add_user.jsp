
<%
if( session.getAttribute("userid")==null || session.getAttribute("role")==null || !session.getAttribute("role").equals("ADMIN"))
  response.sendRedirect("../index.jsp");
else {
%>
<%@ page import="java.sql.*" %>
<%
String error_message="";
String message="";
if(request.getMethod().equals("POST"))
{

  if(!request.getParameter("password1").equals(request.getParameter("password2"))){
    error_message="Passwords did not match";
  }
  else{
    try{
        // Initialize the database
        new org.postgresql.Driver();
        java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

        String username = dbUri.getUserInfo().split(":")[0];
        String password = dbUri.getUserInfo().split(":")[1];
        String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

        Connection con=DriverManager.getConnection(dbUrl, username, password);
        Statement stmt = con.createStatement();
        String insert;

        if(request.getParameter("role").equals("FARMER"))
        {
            PreparedStatement ps=con.prepareStatement("insert into users(firstname, lastname, mobile, email, password, premium)"+
            "values( ?,?,?,?,?,?)");
            ps.setString(1,request.getParameter("firstname"));
            ps.setString(2,request.getParameter("lastname"));
            ps.setString(3,request.getParameter("mobile"));
            ps.setString(4,request.getParameter("email"));
            ps.setString(5,request.getParameter("password2"));
            ps.setBoolean(6,Boolean.valueOf(request.getParameter("premium")));
            ps.executeUpdate();
            ps.close();
        }
        else{
          PreparedStatement ps=con.prepareStatement("insert into users(firstname, lastname, mobile, email, password, role)"+
          "values( ?,?,?,?,?,?)");
          ps.setString(1,request.getParameter("firstname"));
          ps.setString(2,request.getParameter("lastname"));
          ps.setString(3,request.getParameter("mobile"));
          ps.setString(4,request.getParameter("email"));
          ps.setString(5,request.getParameter("password2"));
          ps.setString(6,request.getParameter("role"));
          ps.executeUpdate();
          ps.close();
        }



        con.close();
        message="Successfully added a user";

    }
    catch(Exception e){
        e.printStackTrace();
        error_message="Error occured while adding the article";
    }
  }

}
%>
<jsp:forward page="layout.jsp">
  <jsp:param name="filename" value="add_user" />
  <jsp:param name="errormessage" value="<%= error_message %>" />
  <jsp:param name="message" value="<%= message %>" />
  <jsp:param name="title" value="Add a User" />
</jsp:forward>
<% } %>
