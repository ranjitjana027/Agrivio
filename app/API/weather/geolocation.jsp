<%
String lon=request.getParameter("lon");
String lat=request.getParameter("lat");
String url="https://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=hPCoG20tWovCifAja5Fm8aGSsv88TAEN&q="+lat+"%2C"+lon;
//System.out.print(url);
//response.sendRedirect(url);
%>

<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

   <c:import var = "data" url = "<%= url %>"/>
   ${data}
