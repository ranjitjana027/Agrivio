<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONValue" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%
String lon=request.getParameter("lon");
String lat=request.getParameter("lat");
String url="https://rest.isric.org/soilgrids/v2.0/classification/query?lon="+lon+"&lat="+lat;
if(lat!=null && lon!=null){
  try{
%>
  <c:import var = "data" url = "<%=url%>"/>
  <% Object obj=JSONValue.parse((String)pageContext.getAttribute("data"));
    JSONObject obj1=(JSONObject)obj;
    String st="";
    if(obj1.get("properties")!=null){
      st=(String)obj1.get("wrb_class_name");
    }
  %>
   <jsp:useBean id="cs" class="bean.CropSuggestion" scope="page" />
   <jsp:setProperty name="cs" property="soil_taxonomy" value="<%= st %>" />
   <%

   JSONObject obj3=new JSONObject();
   obj3.put("success",true);
   obj3.put("cropids",cs.getSuggestion());
   %>
   <%= obj3  %>
<% }
catch(Exception e){
  e.printStackTrace();
  out.println("{\"success\":false}");
}
}
else{
  out.println("{\"success\":false}");
}

%>