<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% response.setContentType("application/json");

%>
<jsp:include page="https://api.openweathermap.org/data/2.5/weather?lat=22.386905322264752&lon=87.70078331150233&appid=bbd7cea7000ec20b5d560c73b59adcc4&units=metric" />