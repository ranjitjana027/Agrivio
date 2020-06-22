<%@tag description="Admin Console Layout Wrapper Tag" pageEncoding="UTF-8"%>
<%@ attribute name="header" fragment="true" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.svg">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/lib/spinner.css">
    <script src="${pageContext.request.contextPath}/assets/js/lib/spinner.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/layout.css">
    <script src="${pageContext.request.contextPath}/assets/js/admin/layout.js" charset="utf-8"></script>
    <jsp:invoke fragment="header" />
  </head>
  <body>
    <div class="spinner" style="">
      <div class="spinner-container" style="">
        <svg height="300">
          <ellipse id="circle1" cx="150" cy="150" r="0" stroke="snow" fill="none" />
          <ellipse id="circle2" cx="150" cy="150" r="0" stroke="snow" fill="none" />
          <ellipse id="circle3" cx="150" cy="150" r="0" stroke="snow" fill="none" />
          <ellipse id="circle4" cx="150" cy="150" r="0" stroke="snow" fill="none" />
        </svg>
      </div>

    </div>
    <div class="container">
      <!-- side bar -->
      <div class="grid-sidebar">
        <div class="logo ">
          <span  class="desktop-hidden tablet-hidden close" style="font-size:40px; float:right; cursor:pointer; color:red; margin:-20px -10px 0  0;" >
            &times;
          </span>
          <a href="${pageContext.request.contextPath}/index"><img src="../../assets/img/agrivio-1.png" alt="logo" height="40"></a>
        </div>
        <div class="">
          <!--header class="page-header">Admin Panel</header-->
          <ul class="nav-tab">
            <header class="nav-header">
               ADMIN
            </header>
            <li class="nav-item">
              <a href="${pageContext.request.contextPath}/admin/add-article"><i>&#xf039;</i> Add an Article</a>
            </li>
            <li class="nav-item">
              <a href="${pageContext.request.contextPath}/admin/view-users"><i>&#xf039;</i> View all Users</a>
            </li>
            <li class="nav-item">
              <a href="${pageContext.request.contextPath}/admin/chat"><i>&#xf039;</i> View Chats</a>
            </li>
            <li class="nav-item">
              <a href="${pageContext.request.contextPath}/admin/view-messages"><i>&#xf039;</i> View Messages</a>
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
            <li class="nav-item">
              <a href="${pageContext.request.contextPath}/admin/ads"><i>&#xf039;</i> Advertisements</a>
            </li >
          </ul>
        </div>
      </div>
      <!--  header -->
      <div class="grid-content ">
        <div class="grid-header">
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
                <li><a href="${pageContext.request.contextPath}/latest/profile">Account</a> </li>

                <li><a href="${pageContext.request.contextPath}/index">Exit Console</a> </li>

                <li><a href="${pageContext.request.contextPath}/logout">Logout</a> </li>
              </ul>
            </div>
          </div>
        </div>
        <!-- main content -->
        <div class="grid-item">
          <jsp:doBody />
        </div>
        <div class="grid-footer">

        </div>
      </div>

    </div>
    <script type="text/javascript">
      document.querySelector(" div.grid-header > div.nav-bar-icon").onclick=document.querySelector('.close').onclick=()=>{
        document.querySelector('.grid-sidebar').classList.toggle('zero-width')
      }
    </script>
  </body>
</html>
