<%
if(session.getAttribute("userid")==null )
	response.sendRedirect("../index.jsp");
%>
<%
if(!session.getAttribute("role").equals("ADMIN"))
  response.sendRedirect("../index.jsp");
else {
%>

<jsp:forward page="layout.jsp">
  <jsp:param name="filename" value="view_users" />
</jsp:forward>

<% }
%>
