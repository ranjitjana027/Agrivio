<%
if((String)session.getAttribute("userid")!=null)
response.sendRedirect("homepage.jsp");
else
response.sendRedirect("welcome.html");
 %>
