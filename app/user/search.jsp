<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONValue" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%
Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;
  try{
    new org.postgresql.Driver();
    java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

    String username = dbUri.getUserInfo().split(":")[0];
    String password = dbUri.getUserInfo().split(":")[1];
    String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

    con=DriverManager.getConnection(dbUrl, username, password);

    String q=request.getParameter("q");
    ps=con.prepareStatement("select id, name, title, intro from articles where lower(title) like ? or lower(name) like ?");
    ps.setString(1,"%"+q+"%");
    ps.setString(2,"%"+q+"%");
    rs=ps.executeQuery();
    JSONObject obj=new JSONObject();
    obj.put("success",true);
    JSONArray list=new JSONArray();
    while(rs.next()){
      JSONObject article=new JSONObject();
      article.put("id",rs.getString("id"));
      article.put("name",rs.getString("name"));
      article.put("title",rs.getString("title"));
      article.put("intro",rs.getString("intro"));
      list.add(article);
    }
    obj.put("results",list);



 %>
 <%= obj  %>
<% }
catch(Exception e){
  e.printStackTrace();
  out.println("{\"success\":false}");
}
finally{
  if(rs!=null){
    try{ rs.close(); }catch(Exception e){;}
    rs=null;
  }
  if(ps!=null){
    try{ ps.close(); }catch(Exception e){;}
    ps=null;
  }
  if(con!=null){
    try{ con.close(); }catch(Exception e){;}
    con=null;
  }
}
%>
