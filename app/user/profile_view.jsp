<%@ page import="java.sql.*" %>
<%
if(session.getAttribute("userid")!=null){
Connection con = null;
Statement st = null;
ResultSet rs = null;
  try {

      // Initialize the database
      new org.postgresql.Driver();
      java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

      String username = dbUri.getUserInfo().split(":")[0];
      String password = dbUri.getUserInfo().split(":")[1];
      String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

      con=DriverManager.getConnection(dbUrl, username, password);
      st=con.createStatement();
      String q="select * from farmers where id="+session.getAttribute("userid");
      rs=st.executeQuery(q);
      if(rs.next()){
%>
<div class="profile-details">
  <div class="profile-pic">
    <img src="" alt="">
  </div>
  <div class="personal-info">
    <header>
      Your Details
    </header>
    <table>
      <tr>
        <th>Name</th><td><%= rs.getString("fullname") %></td><td>Edit</td>
      </tr>
      <tr>
        <th>Mobile</th><td><%= rs.getString("mobile") %></td><td>Change</td>
      </tr>
      <tr>
        <th>Email</th><td><%= rs.getString("email") %></td>
        <td><%= rs.getString("email").equals("")?"Add":"Change" %></td>
      </tr>
      <tr>
        <th>Password</th><td>XXXXXXXX</td><td>Change</td>
      </tr>
      <tr>
        <th>Premium</th><td><%= rs.getBoolean("premium")?"&#9989;":"&#10060;" %></td><td><%= rs.getBoolean("premium")?"":"Activate" %></td>
      </tr>
    </table>
  </div>

</div>
<%
    }
  }
  catch(Exception e){
    e.printStackTrace();
  }
  finally{
    if(rs!=null){
      try{ rs.close();}catch(Exception e){;}
      rs=null;
    }
    if(st!=null){
      try{ st.close();}catch(Exception e){;}
      st=null;
    }
    if(con!=null){
      try{ con.close();}catch(Exception e){;}
      con=null;
    }
  }
}
%>
