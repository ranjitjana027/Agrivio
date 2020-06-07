<%@ page import="java.sql.*" %>
<%
  Connection con=null;
  Statement st=null;
  ResultSet rs=null;

  try{
    new org.postgresql.Driver();
    java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

    String username = dbUri.getUserInfo().split(":")[0];
    String password = dbUri.getUserInfo().split(":")[1];
    String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

    con=DriverManager.getConnection(dbUrl, username, password);
    st=con.createStatement();
    rs=st.executeQuery("select * from article where type='GUIDE' order by published_on desc limit 5");
%>
<div class="front-page">
  <div class="recently-featured">
    <header>Recently Featured</header>
    <div class="row">
      <div class="col-12">
      <% if(rs.next()){ %>
        <div class="main-article">
          <div>
            <a href='${pageContext.request.contextPath}/latest/article/guides?id=<%= rs.getString("id") %>'>
              <img src='data:image/jpeg;base64,<%=new String(java.util.Base64.getEncoder().encode(rs.getBytes("thumbnail")),"UTF-8")%>' alt="">
            </a>
          </div>
          <div class="article-header">
            <div class="article-link">
              <a href='${pageContext.request.contextPath}/latest/article/guides?id=<%= rs.getString("id") %>'><%= rs.getString("title") %></a>
            </div>
            <div class="article-intro">
              <%= rs.getString("content") %>
            </div>
          </div>
        </div>
        <% } %>
      </div>
    </div>
    <div class="row">
      <% while(rs.next()){ %>
      <div class="col-3 col-sm-3 col-xs-12">
        <div class="other-article">
          <div class="article-image">
          <a href='${pageContext.request.contextPath}/latest/article/guides?id=<%= rs.getString("id") %>'>
            <img src='data:image/jpeg;base64,<%=new String(java.util.Base64.getEncoder().encode(rs.getBytes("thumbnail")),"UTF-8")%>' alt="">
          </a>
          </div>
          <div class="article-link">
            <a href='${pageContext.request.contextPath}/latest/article/guides?id=<%= rs.getString("id") %>'>
              <%= rs.getString("title") %>
            </a>
          </div>
        </div>
      </div>
      <% } %>
    </div>
  </div>
  <%
    rs.close();
    rs=st.executeQuery("select * from article where type='GUIDE' order by published_on limit 5");
  %>
  <div class="recommendation">
    <header>Recommended for You</header>
    <div class="row">
      <div class="col-12">
      <% if(rs.next()){ %>
        <div class="main-article">
          <div>
            <a href='${pageContext.request.contextPath}/latest/article/guides?id=<%= rs.getString("id") %>'>
              <img src='data:image/jpeg;base64,<%=new String(java.util.Base64.getEncoder().encode(rs.getBytes("thumbnail")),"UTF-8")%>' alt="">
            </a>
          </div>
          <div class="article-header">
            <div class="article-link">
              <a href='${pageContext.request.contextPath}/latest/article/guides?id=<%= rs.getString("id") %>'><%= rs.getString("title") %></a>
            </div>
            <div class="article-intro">
              <%= rs.getString("content") %>
            </div>
          </div>
        </div>
        <% } %>
      </div>
    </div>
    <div class="row">
    <% while(rs.next()){ %>
    <div class="col-3 col-sm-3 col-xs-12">
      <div class="other-article">
        <div class="article-image">
          <a href='${pageContext.request.contextPath}/latest/article/guides?id=<%= rs.getString("id") %>'>
            <img src='data:image/jpeg;base64,<%=new String(java.util.Base64.getEncoder().encode(rs.getBytes("thumbnail")),"UTF-8")%>' alt="">
          </a>
        </div>
        <div class="article-link">
          <a href='${pageContext.request.contextPath}/latest/article/guides?id=<%= rs.getString("id") %>'>
            <%= rs.getString("title") %>
          </a>
        </div>
      </div>
    </div>
    <% } %>
    </div>
  </div>
  <div id="view-all-guides">
    <button onclick="location.href='${pageContext.request.contextPath}/latest/article/guides/all'">View All</button>
  </div>
</div>
<%
}
catch (Exception e) {
  e.printStackTrace();
}
finally{
  if(con!=null){
    try{ con.close(); } catch(Exception e){;}
    con=null;
  }
  if(st!=null){
    try{ st.close(); } catch(Exception e){;}
    st=null;
  }
  if(rs!=null){
    try{ rs.close(); } catch(Exception e){;}
    rs=null;
  }
}
%>
