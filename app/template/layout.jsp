<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getParameter("title")  %></title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.svg">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/lib/spinner.css">
    <script src="${pageContext.request.contextPath}/assets/js/lib/spinner.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/template/layout.css">
    <link rel="stylesheet" href='${pageContext.request.contextPath}<%= request.getParameter("cssfile") %>'>
    <script src="${pageContext.request.contextPath}/assets/js/template/layout.js" charset="utf-8"></script>
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
    <!-- page header -->
    <div class="page-header">
      <div class="header-top">
          <div class="top-subheader row">
            <div class="col-xs-4 col-sm-2 desktop-hidden menu-icon-container" style="">
              <div class="menu-icon">

              </div>
            </div>

            <div class="col-5 col-sm-3 mobile-hidden  main-logo">
              <a href="${pageContext.request.contextPath}/index">
                <!--img class="logo" src="${pageContext.request.contextPath}/assets/img/logo-sm.png" alt="AgriCulture Logo"-->
                <img class="website-name" src="${pageContext.request.contextPath}/assets/img/agrivio-2.png"  alt="agrivio" >
              </a>

            </div>

            <!--div class="col-6 tablet-hidden mobile-hidden caption" >
      				An ambitious agricultural expermient
      			</div-->
            <div class="col-7 col-xs-8 col-sm-7 user-nav-bar" style="">

              <!-- Search Box for tablet and desktop -->
              <div class="search-box mobile-hidden">
                <form action="${pageContext.request.contextPath}/search" id="search-form" >
                  <div class="inline-input" style="">
                    <input type="search" name="q" placeholder="Search...">
                  </div>
                  <div class="search-icon" onclick="document.querySelector('#search-form').submit();">
                     <svg viewBox="0 0 20 20">
                        <circle cx="8" cy="10" r="7" fill="none" stroke="snow" stroke-width="2px" />
                        <path d="M13,13 L20,19" stroke="snow" stroke-width="4px" />
                      </svg>
                  </div>
                </form>
              </div>
              <!-- search icon logo for mobile-->
              <div class="search-logo tablet-hidden desktop-hidden">
                <svg viewBox="0 0 40 40">
                  <circle cx="20" cy="20" r="10" stroke="white" stroke-width="3px" fill="none" />
                  <path d="M28,28 L35,33" stroke="white" stroke-width="5px"/>
                </svg>
              </div>
              <!-- notification bell icon -->
              <div class="bell-icon">
                <svg width="60px" viewBox="0 0 100 100" style="position:relative;">
                  <path d="M0,85 S15,85 20,35 A10,10 0 0,1 80,35 S85,85 100,85 z" stroke-width="1px"  />
                  <circle cx="50" cy="2" r="7" stroke-width="1px" />
                  <path d="M35,87 A17,17 0 0,0 65,87" stroke-width="1px"/>
                  <div id="notification-count">25</div>
                </svg>
              </div>
              <!-- notification list -->
              <%@ page import="java.sql.*" %>
              <%
                Connection con = null;
                Statement st = null;
                ResultSet rs = null;
                  try {

                    // Initialize the database
                    new org.postgresql.Driver();
                    java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

                    String username = dbUri.getUserInfo().split(":")[0];
                    String password = dbUri.getUserInfo().split(":")[1];
                    String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

                    con=DriverManager.getConnection(dbUrl, username, password);
                    st=con.createStatement();
                    rs=st.executeQuery("select * from notifications where user_id="+(String)session.getAttribute("userid")+" order by n_time desc");
              %>
              <div class="notification-list hidden">
                <div class="notification-header" >
                  <header>
                    Notifications
                  </header>
                </div>
                <div class="notifications">
                <%  while(rs.next()){ %>
                  <div class='notification <%= rs.getBoolean("read")?"read": ""%>' n_id='<%= rs.getString("id") %>'>
                    <%= rs.getString("content") %>
                  </div>
                  <% }
                  }
                  catch (Exception e) {
                      /*errorMessage="Something went wrong";*/
                      e.printStackTrace();
                  }
                  finally {

                    if (rs != null) {
                      try { rs.close(); } catch (SQLException e) { ; }
                      rs = null;
                    }
                    if (st != null) {
                      try { st.close(); } catch (SQLException e) { ; }
                      st = null;
                    }
                    if (con != null) {
                      try { con.close(); } catch (SQLException e) { ; }
                      con = null;
                    }
                  }
                  %>
                  <script>
                    var c=0;
                    document.querySelectorAll(".notification").forEach(item=>{
                      if(!item.classList.contains("read"))
                      c++;
                    });
                    document.querySelector("#notification-count").innerHTML=c;
                    if(c<1){
                      document.querySelector("#notification-count").classList.add("hidden")
                    }
                  </script>
                  <!--<div class="notification">
                    Quisque condimentum lacinia felis, ut commodo ligula rhoncus eu.
                    Vivamus interdum purus nisl, eget pulvinar sem pellentesque nec.
                  </div>
                  <div class="notification">
                    Nullam sodales est a dui laoreet, facilisis hendrerit dui commodo.
                    Integer ac massa nibh. In sagittis nisl sed dolor vehicula, eget accumsan odio ullamcorper.
                  </div>
                  <div class="notification">
                    Nulla posuere lacus eu arcu luctus mattis.
                    Pellentesque varius nisi dui, vel convallis ligula egestas porttitor.
                  </div>
                  <div class="notification">
                    Class aptent taciti sociosqu ad litora torquent per conubia nostra,
                    per inceptos himenaeos.
                    Quisque tincidunt nunc eu placerat laoreet.
                  </div>
                  <div class="notification">
                    Nunc erat lorem, consectetur sed viverra at, finibus ut massa.
                    Sed ligula leo, fringilla a dapibus vel, venenatis at velit.
                  </div>
                  <div class="notification">
                    Integer vel lacus malesuada, laoreet est a, convallis ipsum.
                    Nulla tincidunt neque non dui aliquet condimentum.
                  </div>
                  <div class="notification">
                    Vestibulum tincidunt volutpat tempor.
                    Vivamus congue hendrerit iaculis.
                  </div>
                  <div class="notification">
                    Praesent placerat lectus eros, a bibendum velit ullamcorper quis.
                    Vestibulum sagittis felis sodales sagittis mattis.
                  </div>
                  <div class="notification">
                    Vivamus pulvinar tortor eros, auctor eleifend tellus pellentesque in.
                    Maecenas in placerat nisi, id euismod massa.
                  </div>-->
                </div>

              </div>

              <!-- user icon -->
              <div class="user-icon-container">
                <svg class="user-icon" viewBox=" 0 0 40 40">
                  <defs>
                    <pattern id="user-icon-pattern" x="0" y="0" height="200" width="200" patternUnits="userSpaceOnUse" >
                      <circle cx="20" cy="14" r="9" stroke="black" fill="none" stroke-width="2px" />
                      <path d="M0,40 S20,0 40,40" stroke="black" fill="none" stroke-width="2px" />
                    </pattern>
                  </defs>
                  <circle cx="20" cy="20" r="20" stroke="black"  fill="url(#user-icon-pattern)" stroke-width="2px" />
                </svg>
              </div>
              <!-- account navigation -->
              <div class="account-nav hidden" >
                <ul>
                  <li><a href="${pageContext.request.contextPath}/latest/profile">Account</a> </li>
                  <% if( ((String)session.getAttribute("role")).equals("ADMIN") ){ %>
                  <li><a href="${pageContext.request.contextPath}/admin/dashboard">Admin Console</a> </li>
                  <% } %>
                  <li><a href="#">Subscription</a> </li>
                  <li><a href="${pageContext.request.contextPath}/logout">Logout</a> </li>
                </ul>
              </div>

            </div>
          </div>
      </div>
      <div class="header-bottom">
        <!-- mobile search bar -->
        <div class="mobile-search-bar" >
          <div class="search-box desktop-hidden tablet-hidden">
            <form action="${pageContext.request.contextPath}/search" id="search-form-mobile" >
              <div class="inline-input" >
                <input type="search" name="q"  placeholder="Search...">
              </div>
              <div class="search-icon" onclick="document.querySelector('#search-form-mobile').submit();" style="">
                 <!---svg viewBox="0 0 20 20">
                    <circle cx="8" cy="10" r="7" fill="none" stroke="snow" stroke-width="2px" />
                    <path d="M13,13 L20,19" stroke="snow" stroke-width="4px" />
                  </svg-->
                  <span>&#10153;</span>
              </div>
            </form>
          </div>
        </div>
        <!--user nav link -->
        <div class="row user-nav" >
          <div  class="col-12 col-sm-12 col-xs-12">
            <ul>
              <li class="desktop-hidden tablet-hidden">
                <a href="${pageContext.request.contextPath}/index">Home</a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/latest/suggestion/crops">Suggestion</a>
              </li>
              <li >
                <a href="${pageContext.request.contextPath}/latest/article/guides/all"><span class="desktop-hidden">Cultivation </span> Guides</a>
              </li>

              <li>
                <a href="${pageContext.request.contextPath}/latest/price/crops" >Crop Price</a>
              </li>
              <!--li>
                <a href="/weather" id="link-forecast"><span class="desktop-hidden">Weather </span> Forecast</a>
              </li-->
              <li>
                <a href="${pageContext.request.contextPath}/latest/events" ><span class="desktop-hidden">Cultivation </span> Events</a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/latest/ask-expert">Ask Expert</a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/latest/article/plants/all">Plants</a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/latest/article/pests/all">Pests</a>
              </li>
              <li>
                <a href="#">About <span class="desktop-hidden"> Website</span></a>
              </li>
              <li>
                <a href="#">Contact <span class="desktop-hidden"> Us</span></a>
              </li>

            </ul>
          </div>
        </div>
      </div>
    </div>
    <!-- main content here  -->
    <div class="page-content">
      <!-- include page here -->
      <jsp:include page="<%= request.getParameter(\"filename\") %>" />

    </div>
    <!-- page footer -->
    <div class="page-footer">
      <div class="footer-top">
      <div class="row" >
        <div class="col-3 col-xs-12">
          .
        </div>
        <div class="col-3 col-xs-12">
          <ul>
            <li class="footer-title">Services</li>
            <li><a href="${pageContext.request.contextPath}/latest/suggestion/crops">Suggestion</a> </li>
            <li><a href="${pageContext.request.contextPath}/latest/article/guides/all">Guides</a> </li>
            <li><a href="${pageContext.request.contextPath}/latest/price/crops">Crop Price</a> </li>
            <!--li><a href="#">Weather Forecast</a> </li-->
            <li><a href="${pageContext.request.contextPath}/latest/events">Events</a> </li>
            <li><a href="${pageContext.request.contextPath}/latest/ask-expert">Ask Expert</a> </li>
            <!--li><a href="#">Benificial Insects</a> </li>
            <li><a href="#">Plant Diseases</a> </li-->
            <li><a href="${pageContext.request.contextPath}/latest/article/plants/all">Plants</a> </li>
            <li><a href="${pageContext.request.contextPath}/latest/article/pests/all">Pests</a> </li>
            <li><a href="#">Search</a> </li>
          </ul>
        </div>
        <div class="col-3 col-xs-12">
          <ul>
            <li class="footer-title">Site Navigation</li>
            <li><a href="${pageContext.request.contextPath}/index">Home</a> </li>
            <li><a href="#">About</a> </li>
            <li><a href="#">Subscription</a> </li>
            <li><a href="#">Contact</a> </li>
            <li><a href="#">Terms &amp; Conditions</a> </li>
            <li><a href="#">Privacy Policy</a> </li>
          </ul>
        </div>
        <div class="col-3 col-xs-12">
          <ul>
            <li class="footer-title">Join Our Community</li>
            <li>
              <a href="#">Facebook</a>
            </li>
            <li><a href="#">Twitter</a> </li>
            <li><a href="#">Instagram</a> </li>
            <li><a href="#">Youtube</a> </li>
            <li><a href="#">Pinterest</a> </li>
          </ul>
        </div>
      </div>
      </div>
      <div class="footer-bottom">
      &copy; 2020 <span class="website-name">agrivio</span>. All rights reserved.
      </div>
    </div>
  </body>
</html>
