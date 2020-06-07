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
    int id=Integer.parseInt(request.getParameter("id"));
    rs=st.executeQuery("select * from article where type='GUIDE' and id="+id);
%>
<div style="margin:2% 0;">
<div class="row" >
  <div class="col-8 col-xs-12" >
  <%     if(rs.next()){ %>
    <div class="article" >
      <div class="article-header">
        <%= rs.getString("title") %>
      </div>
      <div class="article-metadata">
        Published on : <span> <%= rs.getDate("published_on") %></span>, Written by <span><%= rs.getString("author") %></span>
      </div>
      <div  class='article-image'>
        <%= "<img src='data:image/jpeg;base64,"+new String(java.util.Base64.getEncoder().encode(rs.getBytes("thumbnail")),"UTF-8")+"' />" %>
      </div>
      <div class="article-content">
      <%= rs.getString("content") %>
      </div>
    </div>
    <% } else{ %>
      <div>
      <h2> Not Found </h2>
      </div>
      <% } %>
  </div>
  <%
    rs.close();
    rs=st.executeQuery("select id, title,thumbnail from article where type='GUIDE' and  id<>"+request.getParameter("id")+" order by published_on desc limit 6");
  %>
  <div class="col-4 col-sm-12 col-xs-12"  >
    <div class="suggestion">
      <div class="suggestion-header">
        Latest Articles
      </div>
      <div class="parent">
      <%
        int counter=0;
        while(rs.next() && counter++<6){
      %>
        <div class="custom-class">
          <div class="suggestion-article">
            <div class="article-image">
              <a href='${pageContext.request.contextPath}/latest/article/guides?id=<%= rs.getString("id") %>'>
                <img src='data:image/jpeg;base64,<%=new String(java.util.Base64.getEncoder().encode(rs.getBytes("thumbnail")),"UTF-8")%>' alt="">
              </a>
            </div>
            <div class="suggestion-article-header">
              <a href='${pageContext.request.contextPath}/latest/article/guides?id=<%= rs.getString("id") %>'><%= rs.getString("title") %></a>
            </div>
          </div>
        </div>
        <% } %>
      </div>
    </div>
  </div>
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
