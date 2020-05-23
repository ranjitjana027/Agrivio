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
    rs=st.executeQuery("select * from article where id="+id);
    if(rs.next()){
%>
<div style="margin:2% 0;">
<div class="row" >
  <div class="col-8 col-xs-12" >
    <div class="article" style="padding:10px;">
      <div class="article-header">
        <%= rs.getString("title") %>
      </div>
      <div class="article-metadata">
        Published on : <span> <%= rs.getDate("published_on") %></span>
      </div>
      <div class="article-content">
      <%= rs.getString("content") %>
      </div>
    </div>
  </div>
  <%
    }
    rs.close();
    rs=st.executeQuery("select id, title from article order by published_on desc");
  %>
  <div class="col-4 col-sm-12 col-xs-12"  >
    <div class="suggestion">
      <div class="suggestion-header">
        Related Articles
      </div>
      <div class="parent">
      <%
        int counter=0;
        while(rs.next() && counter++<6){
      %>
        <div class="custom-class">
          <div class="suggestion-article">
            <img src="../../assets/img/farmland.jpg" alt="">
            <div class="suggestion-article-header">
              <a href='${pageContext.request.contextPath}/latest/article?id=<%= rs.getString("id") %>'><%= rs.getString("title") %></a>
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
