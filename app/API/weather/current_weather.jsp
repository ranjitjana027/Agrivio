<%
String locationKey=request.getParameter("key");
String url="http://dataservice.accuweather.com/currentconditions/v1/"+locationKey+"?apikey=hPCoG20tWovCifAja5Fm8aGSsv88TAEN&details=true";
//System.out.print(url);
//response.sendRedirect(url);
%>

<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

   <c:import var = "data" url = "<%= url %>"/>
   ${data}
