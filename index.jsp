<%
if((String)session.getAttribute("user")!=null)
response.sendRedirect("homepage.jsp");

response.sendRedirect("welcome.html");
 %>
