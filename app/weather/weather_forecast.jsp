<%
if(session.getAttribute("userid")==null){
  response.sendRedirect(request.getContextPath()+"/index");
}
else if( session.getAttribute("role").equals("FARMER")){
%>


<jsp:include page="/app/user/layout.jsp">
  <jsp:param name="filename" value="../weather/weather_forecast_view.jsp" />
  <jsp:param name="title" value="Weather Forecast" />
</jsp:include>


<%
}
else if(session.getAttribute("role").equals("ADMIN") || session.getAttribute("role").equals("EXPERT")){
  out.println("Coming Soon");
} else {
  out.println("Page doesn't exist");
}
%>
