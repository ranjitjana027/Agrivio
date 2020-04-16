<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="../../assets/css/admin/layout.css">
    <link rel="stylesheet" href='../../assets/css/admin/<%= request.getParameter("filename")+".css"%>' >
  </head>
  <body>
    <div class="grid">
      <div class="">
        <svg>
          <circle cx="100" cy="35" r="30" fill="green" />
        </svg>
      </div>
      <div class="grid-header">

      </div>
      <div class="grid-sidebar">
        <!--header class="page-header">Admin Panel</header-->
        <ul class="nav-tab sticky">
          <header class="nav-header">
             ADMIN
          </header>
          <li class="nav-item">
            <a href="add_article.jsp"><i>&#xf039;</i> Add an Article</a>
          </li>
          <li class="nav-item">
            <a href="view_users.jsp"><i>&#xf039;</i> View all Users</a>
          </li>
          <li class="nav-item">
            <a href="add_user.jsp"><i>&#xf039;</i> Add an User</a>
          </li >
        </ul>
      </div>
      <div class="grid-item">
        <jsp:include page="<%= request.getParameter(\"filename\")+\"_view.jsp\"%>" >
        <jsp:param name="errormessage" value="<%= request.getParameter(\"errormessage\") %>" />
        <jsp:param name="message" value="<%= request.getParameter(\"message\") %>" />
        </jsp:include>
      </div>

      <div class="grid-footer">

      </div>
    </div>
  </body>
</html>
