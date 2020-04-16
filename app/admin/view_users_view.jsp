<%@ page import="java.sql.*" %>
<%
    try {

			// Initialize the database

      new org.postgresql.Driver();
			java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

      String username = dbUri.getUserInfo().split(":")[0];
      String password = dbUri.getUserInfo().split(":")[1];
      String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

      Connection con=DriverManager.getConnection(dbUrl, username, password);




			//Statement stmt = con.createStatement();
			PreparedStatement st1 = con.prepareStatement("SELECT * FROM farmers");
			//st.setString(1, session.getAttribute("userid"));
			ResultSet farmerSet=st1.executeQuery();
      PreparedStatement st2 = con.prepareStatement("SELECT * FROM experts");
      //st.setString(1, session.getAttribute("userid"));
      ResultSet expertSet=st2.executeQuery();



%>

<div class="page-header">
  View All Users
</div>
<div class="row">
  <div class="column">
    <div class="table-header">
      Farmers
    </div>
    <div class="table">
      <table id="farmers">
        <thead>
          <th>Name</th>
          <th>Mobile</th>
          <th>Email</th>
          <th>Premium</th>
        </thead>
        <tbody>
        <%
                while(farmerSet.next())
                {
            %>
        <tr>
          <td><%= farmerSet.getString("fullname") %></td>
          <td><%= farmerSet.getString("mobile") %></td>
          <td><%= farmerSet.getString("email") %></td>
          <td><%= farmerSet.getBoolean("premium")?"&#9989;":"&#10060;" %></td>

        </tr>
      <%
                }
      %>

        </tbody>
      </table>
    </div>

  </div>
  <div class="column">
    <div class="table-header">
      Experts
    </div>
    <div class="table">
      <table>
        <thead>
          <th>Name</th>
          <th>Mobile</th>
          <th>Email</th>
        </thead>
        <tbody>
        <%
                while(expertSet.next())
                {
            %>
        <tr>
          <td><%= expertSet.getString("fullname") %></td>
          <td><%= expertSet.getString("mobile") %></td>
          <td><%= expertSet.getString("email") %></td>

        </tr>
      <%
                }
      %>
      <%
            }
        catch (Exception e) {
          e.printStackTrace();
        }

      %>
        </tbody>
      </table>
    </div>
  </div>

</div>
