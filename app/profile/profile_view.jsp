<%@ page import="java.sql.*" %>
<%
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
      rs=st.executeQuery("select * from users where id="+(String)session.getAttribute("userid"));
      if(rs.next()){
%>
<div class="profile-header">
  User Profile
</div>
<div class="row">
  <div class="col-4 col-sm-4 col-xs-12">
    <div class="profile-overview">
      <div class="profile-pic">
        <img src="${pageContext.request.contextPath}/assets/img/user.png" alt="Profile Pic">
      </div>
      <div class="username">
        <%= rs.getString("firstname")%> <%= rs.getString("lastname")%>
      </div>
      <div class="premium-sticker" style="">
        <%= rs.getBoolean("premium")?"Premium":"Basic" %>
      </div>
    </div>
    <div class="account-action mobile-hidden">
      <div class="">
        <a href="#">Change Password</a>
      </div>
      <div class="">
        <a href="#">Change Mobile No</a>
      </div>
    </div>
  </div>
  <div class="col-8 col-sm-8 col-xs-12">
    <div class="profile-details">

      <div class="personal-info">
        <header>
          Account Details
        </header>
        <div class="row  profile-data">
          <div class="col-4 col-sm-4 col-xs-4">
            Name
          </div>
          <div class="col-8 col-sm-8 col-xs-8">
            <%= rs.getString("firstname")%> <%= rs.getString("lastname")%>
          </div>

        </div>
        <div class="row  profile-data">
          <div class="col-4 col-sm-4 col-xs-4">
            Mobile
          </div>
          <div class="col-8 col-sm-8 col-xs-8">
            <%= rs.getString("mobile") %>
          </div>
        </div>
        <div class="row profile-data">
          <div class="col-4 col-sm-4 col-xs-4">
            Email
          </div>
          <div class="col-8 col-sm-8 col-xs-8">
            <%= rs.getString("email") %>
          </div>
        </div>
        <div class="row  profile-data">
          <div class="col-4 col-sm-4 col-xs-4">
            Password
          </div>
          <div class="col-8 col-sm-8 col-xs-8">
            XXXXXXXX
          </div>

        </div>
        <div class="row profile-data">
          <div class="col-4 col-sm-4 col-xs-4">
            Premium
          </div>
          <div class="col-8 col-sm-8 col-xs-8">
            <%= rs.getBoolean("premium")?"Subscribed":"Not Subscribed" %>
          </div>
        </div>
      </div>
    </div>
    <div class="account-action desktop-hidden tablet-hidden">
      <div class="">
        <a href="#">Change Password</a>
      </div>
      <div class="">
        <a href="#">Change Mobile No</a>
      </div>
    </div>
  </div>

</div>
<%
      }
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
