<% if (session.getAttribute("userid")==null){
  response.sendRedirect(request.getContextPath()+"/login?redirect=/article");
} else {
%>
<%@ page import="java.sql.*" %>
<%
  Connection con=null;
  ResultSet rs=null;
  Statement stmt=null;
  try{
    new org.postgresql.Driver();
    java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

    String username = dbUri.getUserInfo().split(":")[0];
    String password = dbUri.getUserInfo().split(":")[1];
    String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

    con=DriverManager.getConnection(dbUrl, username, password);
    stmt=con.createStatement();
    String query="select * from articles where id="+request.getParameter("id");
    rs=stmt.executeQuery(query);
    if(rs.next()){
%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/article/article.css">
<div class="article">
    <header class="section">
        <h2 class="heading"><%= rs.getString("name") %></h2>

        <div class="bg">
            <h3>Other Names</h3>
            <ul class="data">
                <li>Name1</li>
                <li>Name2</li>
            </ul>
        </div>
        <div class="bg">
            <h3>Overview</h3>
            <ul>
                <li>Cost per Acre : <span class="data"><%= rs.getString("cpa") %></span> </li>
                <li>Minimum time for production : <span class="data"><%= rs.getString("min_prod_time") %></span>
                </li>
                <li>How much profitable : <span class="data"></span><%= rs.getString("profit") %></li>
            </ul>
        </div>
    </header>
    <article class="section">
        <div class="section-body">
            <div class="requirements">
                <h3 class="heading bg">Requirements</h3>
                <div class="weather">
                    <h4>Weather</h4>
                    <ul>
                        <li>Temperature<span class="data"><%= rs.getString("min_temp") %> -
                                <%= rs.getString("max_temp") %></span></li>
                        <li>Humidity<span class="data"><%= rs.getString("humidity") %></span></li>
                        <li>Rainfall<span class="data"><%= rs.getString("rainfall") %></span></li>
                    </ul>
                </div>
                <div class="soil">
                    <h4>Soil</h4>
                    <span class="data"><%= rs.getString("soil") %></span>
                </div>
                <div class="land">
                    <h4>Type of land</h4>
                    <span class="data"><%= rs.getString("land") %></span>
                </div>
                <div class="season">
                    <h4>Season</h4>
                    <span class="data"><%= rs.getString("season") %></span>
                </div>
            </div>
            <div class="content">
                <h3 class="heading bg">Content</h3>
                <div>
                    <h4>Preparation of Soil.</h4>
                    <p class="data"><%= rs.getString("soil_prep") %></p>
                </div>
                <div>
                    <h4>Sowing</h4>
                    <p class="data"><%= rs.getString("sowing") %></p>
                </div>
                <div>
                    <h4>Nurturing</h4>
                    <p class="data"><%= rs.getString("nurturing") %></p>
                </div>
                <div>
                    <h4>Harvesting/Production</h4>
                    <p class="data"><%= rs.getString("production") %></p>
                </div>
                <div>
                    <h4>Cooling off</h4>
                    <p class="data"><%= rs.getString("coolingoff") %></p>
                </div>
                <div>
                    <h4>Extra</h4>
                    <p class="data"><%= rs.getString("extra") %></p>
                </div>
            </div>
        </div>
</div>
</article>
<footer class="article">
    <div class="section">
        <h3 class="heading bg">Conclusion</h3>
        <p class="data"><%= rs.getString("conclusion") %></p>
    </div>
</footer>
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
    if (stmt != null) {
      try { stmt.close(); } catch (SQLException e) { ; }
      stmt = null;
    }
    if (con != null) {
      try { con.close(); } catch (SQLException e) { ; }
      con = null;
    }
  }

%>

<% } %>