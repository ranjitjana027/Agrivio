
<%
if(session.getAttribute("userid")==null || !session.getAttribute("role").equals("ADMIN"))
  response.sendRedirect("../index.jsp");
else {
%>

<jsp:forward page="layout.jsp">
  <jsp:param name="filename" value="view_users" />
  <jsp:param name="title" value="View all Users" />
</jsp:forward>

<% }
%>
