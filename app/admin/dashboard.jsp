<%
if( session.getAttribute("userid")==null || !session.getAttribute("role").equals("ADMIN"))
  response.sendRedirect("../index.jsp");
<<<<<<< HEAD
else {
=======

>>>>>>> 928d8f3063a58bba87afba3f86587dc700ab8f1e
%>
<div class="">
  <h2>Admin Panel</h2>
  <ul>
    <li><a href="../admin/add_article.jsp">Add an Article</a> </li>
    <li><a href="../admin/add_user.jsp">Add a User</a> </li>
    <li><a href="../admin/view_users.jsp">View all Users</a> </li>
    <li><a href="../admin/view_chats.jsp">View Chats</a> </li>
  </ul>
</div>
<%
}
%>
