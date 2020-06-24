<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@tag description="Layout Wrapper Tag" pageEncoding="UTF-8"%>
<%@ attribute name="header" fragment="true" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.svg">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/template/layout.css">
    <script src="${pageContext.request.contextPath}/assets/js/template/layout.js" charset="utf-8"></script>
    <jsp:invoke fragment="header" />
  </head>
  <body>

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
              <c:catch var="exception">
                <c:set var="dbUri"  value="<%=new java.net.URI(System.getenv(\"DATABASE_URL\")) %>"/>

                <sql:setDataSource
                  var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />
                <sql:query dataSource="${connection}" var="result">
                  select * from notifications where user_id=? and n_time<= (now() at time zone 'utc') and not removed order by n_time desc
                  <sql:param value="${Integer.parseInt(sessionScope.userid)}"/>
                </sql:query>
              </c:catch>

              <div class="notification-list hidden">
                <div class="notification-header" >
                  <header>
                    Notifications
                  </header>
                </div>
                <div class="notifications">
                  <c:if test="${ empty exception}">
                    <c:forEach var="i" items="${result.rows}" >
                      <div class='notification ${ i.read?"read": ""}' n_id='${i.id}'>
                        <div>${i.content}</div><small><fmt:formatDate value="${i.n_time}"
                          timeZone="IST" pattern="dd MMM ''yy" /></small>
                      </div>
                    </c:forEach>
                  </c:if>
                  <c:if test="${ empty sessionScope.userid}">
                    <div class="notification">
                      <a href="${pageContext.request.contextPath}/login">Login</a> to get access to event management and direct interaction with experts. Don''t have an account, <a href="${pageContext.request.contextPath}/signup">create one</a>.
                    </div>
                  </c:if>
                </div>
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
                  <c:if test="${not empty sessionScope.userid}">
                    <li><a href="${pageContext.request.contextPath}/latest/profile">My Account</a> </li>
                  </c:if>
                  <c:if test="${empty sessionScope.userid}">
                    <li><a href="${pageContext.request.contextPath}/login">Login</a> </li>
                    <li><a href="${pageContext.request.contextPath}/signup">Signup</a> </li>
                  </c:if>
                  <c:if test="${sessionScope.role=='ADMIN'}">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard">Admin Console</a> </li>
                  </c:if>

                  <c:if test="${not empty sessionScope.userid}">
                    <li><a href="${pageContext.request.contextPath}/logout">Logout</a> </li>
                  </c:if>
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
                <a href="${pageContext.request.contextPath}/latest/article"><span class="desktop-hidden">Cultivation </span> Articles</a>
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

              <!--<li>
                <a href="${pageContext.request.contextPath}/latest/article/plants/all">Plants</a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/latest/article/pests/all">Pests</a>
              </li>-->

              <li>
                <a href="${pageContext.request.contextPath}/latest/balance-sheet">Notebook</a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/latest/about-us">About <span class="desktop-hidden"> Us</span></a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/latest/contact">Contact <span class="desktop-hidden"> Us</span></a>
              </li>

            </ul>
          </div>
        </div>
      </div>
    </div>
    <!-- main content here  -->
    <div class="page-content">
      <!-- include page here -->
      <jsp:doBody />

    </div>
    <!-- page footer -->
    <div class="page-footer">
      <div class="footer-top">
      <div class="row" >
        <div class="col-3 col-xs-12">
        <img src="/assets/img/logo.svg" style="height:4rem; margin: 1rem auto; display: block;">
          <div class="website-logo">agrivio</div>
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
            <li><a href="${pageContext.request.contextPath}/latest/balance-sheet">Notebook</a> </li>
            <li><a href="${pageContext.request.contextPath}/latest/article/plants/all">Plants</a> </li>
            <li><a href="${pageContext.request.contextPath}/latest/article/pests/all">Pests</a> </li>
            <li><a href="#">Search</a> </li>
          </ul>
        </div>
        <div class="col-3 col-xs-12">
          <ul>
            <li class="footer-title">Site Navigation</li>
            <li><a href="${pageContext.request.contextPath}/index">Home</a> </li>
            <li><a href="${pageContext.request.contextPath}/latest/about-us">About</a> </li>

            <li><a href="${pageContext.request.contextPath}/latest/contact">Contact</a> </li>
            <c:if test="${empty sessionScope.userid}">
              <li><a href="${pageContext.request.contextPath}/login">Login</a> </li>
              <li><a href="${pageContext.request.contextPath}/signup">Signup</a> </li>
            </c:if>
            <li><a href="#">Terms &amp; Conditions</a> </li>
            <li><a href="#">Privacy Policy</a> </li>
          </ul>
        </div>
        <div class="col-3 col-xs-12">
          <ul class="connect">
            <li class="footer-title">Join Our Community</li>
            <li>
              <a href="#"><img src="${pageContext.request.contextPath}/assets/icons/social-media/facebook.png"></a>
            </li>
            <li><a href="#"><img src="${pageContext.request.contextPath}/assets/icons/social-media/twitter.png"></a> </li>
            <li><a href="#"><img src="${pageContext.request.contextPath}/assets/icons/social-media/instagram.png"></a> </li>
            <li><a href="https://www.youtube.com/channel/UC9AiSIADENC8Ui9lVlpFIFg" target="_blank"><img src="${pageContext.request.contextPath}/assets/icons/social-media/youtube.png"></a> </li>
            <!--li><a href="#"><img src="${pageContext.request.contextPath}/assets/icons/social-media/pinterest.png"></a> </li-->
          </ul>
        </div>
      </div>
      </div>
      <hr>
      <div class="footer-bottom">
      &copy; 2020 Agrivio Limited. All rights reserved.
      </div>
    </div>
  </body>
</html>
