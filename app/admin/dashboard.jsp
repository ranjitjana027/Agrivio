<%
if( session.getAttribute("userid")==null || !session.getAttribute("role").equals("ADMIN"))
  response.sendRedirect(request.getContextPath()+"/index");
else {
%>
<div class="">
  <h2>Admin Console</h2>
  <h3><%=  request.getContextPath() %></h4>
  <ul>
    <li><a href="../admin/add-article">Add an Article</a> </li>
    <li><a href="../admin/add-user">Add a User</a> </li>
    <li><a href="../admin/view-users">View all Users</a> </li>
    <li><a href="../admin/add-soil-info">Add Soil Info</a> </li>
    <li><a href="../admin/add-crop-info">Add Crop Info</a> </li>
    <li><a href="../admin/chat">View Chats</a> </li>
    <li><a href="../admin/view-messages">View Messages</a> </li>
  </ul>
</div>
<%
}
%>
