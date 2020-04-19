<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin | <%= request.getParameter("title") %> </title>
    <link rel="stylesheet" href="../../assets/css/admin/layout.css">
      <script src="../../assets/js/admin/layout.js" charset="utf-8"></script>
    <link rel="stylesheet" href='../../assets/css/admin/<%= request.getParameter("filename")+".css"%>' >
    <style media="screen">
      title{
        text-transform: uppercase;
      }
    </style>
  </head>
  <body>
    <div class="grid">


      <!--  header -->
      <div class="grid-header sticky">
        <div class="nav-bar-icon">
          &#9776;
        </div>
        <div class="">

        </div>
        <div class="" >
          <svg style="display:block;">
            <defs>
              <pattern id="user-icon-pattern" x="0" y="0" height="200" width="200" patternUnits="userSpaceOnUse" >
                <image x="39" y="15" xlink:href="../../assets/img/user.png" height="40" width="70" ></image>
              </pattern>
            </defs>
            <circle cx="75" cy="35" r="20" stroke="black"  fill="url(#user-icon-pattern)" class="user-icon" />
          </svg>
          <div class="user-menu">
            <ul>
              <li><a href="#">Your Profile</a> </li>
              <li><a href="https://www.google.com">Link2</a> </li>
              <li><a href="../auth/logout.jsp">Logout</a> </li>
            </ul>
          </div>
        </div>
      </div>
      <!-- side bar -->
      <div class="grid-sidebar">
        <div class="logo sticky">
            logo
        </div>
        <div class="sticky">
          <!--header class="page-header">Admin Panel</header-->
          <ul class="nav-tab">
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
      </div>

      <!-- main content -->
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
