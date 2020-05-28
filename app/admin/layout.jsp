<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin | <%= request.getParameter("title") %> </title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/layout.css">
      <script src="${pageContext.request.contextPath}/assets/js/admin/layout.js" charset="utf-8"></script>
    <link rel="stylesheet" href='${pageContext.request.contextPath}/assets/css/admin/<%= request.getParameter("filename")+".css"%>' >

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
          <svg style="display:block; max-width:150px; max-height:70px;">
            <defs>
              <pattern id="user-icon-pattern" x="0" y="0" height="200" width="200" patternUnits="userSpaceOnUse" >
                <image x="39" y="15" xlink:href="${pageContext.request.contextPath}/assets/img/user.png" height="40" width="70" ></image>
              </pattern>
            </defs>
            <circle cx="75" cy="35" r="20" stroke="black"  fill="url(#user-icon-pattern)" class="user-icon" />
          </svg>
          <div class="user-menu">
            <ul>
              <li><a href="#">Your Profile</a> </li>
              <li><a href="https://www.google.com">Link2</a> </li>
              <li><a href="${pageContext.request.contextPath}/logout">Logout</a> </li>
            </ul>
          </div>
        </div>
      </div>
      <!-- side bar -->
      <div class="grid-sidebar">
        <div class="logo sticky">
            logo
        </div>
        <div class="">
          <!--header class="page-header">Admin Panel</header-->
          <ul class="nav-tab">
            <header class="nav-header">
               <%= session.getAttribute("role") %>
            </header>
            <li class="nav-item">
              <a href="${pageContext.request.contextPath}/admin/add-article"><i>&#xf039;</i> Add an Article</a>
            </li>
            <li class="nav-item">
              <a href="${pageContext.request.contextPath}/admin/view-users"><i>&#xf039;</i> View all Users</a>
            </li>
            <li class="nav-item">
              <a href="${pageContext.request.contextPath}/admin/add-user"><i>&#xf039;</i> Add an User</a>
            </li >
            <li class="nav-item">
              <a href="${pageContext.request.contextPath}/admin/add-soil-info"><i>&#xf039;</i> Add Soil Info</a>
            </li>
            <li class="nav-item">
              <a href="${pageContext.request.contextPath}/admin/add-crop-info"><i>&#xf039;</i> Add Crop Info</a>
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
