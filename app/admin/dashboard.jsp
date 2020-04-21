<%
if( session.getAttribute("userid")==null || !session.getAttribute("role").equals("ADMIN"))
  response.sendRedirect("../index.jsp");
else {
%>
<div class="">
  <h2>Admin Panel</h2>
  <h3><%=  request.getContextPath() %></h4>
  <ul>
    <li><a href="../admin/add-article">Add an Article</a> </li>
    <li><a href="../admin/add-user.">Add a User</a> </li>
    <li><a href="../admin/view-users">View all Users</a> </li>
    <li><a href="../admin/view-chats">View Chats</a> </li>
  </ul>
</div>
<%
}
%>
