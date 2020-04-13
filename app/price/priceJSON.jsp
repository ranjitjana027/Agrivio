<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% response.setContentType("application/json"); %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

   <c:import var = "data" url = "https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd000001850c76ce49e246686075684ef0e11614&format=json&offset=0&limit=9999"/>
   ${data}

