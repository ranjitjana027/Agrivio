
<%
if(session.getAttribute("userid")==null || !session.getAttribute("role").equals("ADMIN"))
  response.sendRedirect(request.getContextPath()+"/index");
else {
%>
<jsp:forward page="/app/admin/layout.jsp">
  <jsp:param name="filename" value="view_users" />
  <jsp:param name="title" value="View all Users" />
</jsp:forward>

<% }
%>
