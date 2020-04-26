<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String lon=request.getParameter("lon");
String lat=request.getParameter("lat");
String url="https://api.openweathermap.org/data/2.5/weather?lat="+lat+"&lon="+lon+"&appid=bbd7cea7000ec20b5d560c73b59adcc4&units=metric";
//System.out.print(url);
//response.sendRedirect(url);
%>

<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

   <c:import var = "data" url = "<%= url %>"/>
   ${data}
