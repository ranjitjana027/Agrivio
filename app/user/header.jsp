<div class="grid-header">
  <div class="logo">
    WebsiteName
  </div>
  <!--div class="nav-bar-icon">
    &#9776;
  </div-->
  <!-- useful nav link -->
  <div class="user-nav">
    <ul>
      <li>
        <a href="${pageContext.request.contextPath}/dashboard">Home</a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/calendar">Calendar</a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/crop-price">Crop Price</a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/weather">Weather</a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/ask-expert?room=<%= request.getParameter("userid") %>">Ask Experts</a>
      </li>
    </ul>
  </div>
  <!--search box -->
  <div class="search-box">
    <form >
      <input type="search" name="q" value="" placeholder="Search..">
      <button type="submit" >
        <svg height="30" width="35">
          <circle cx="8" cy="10" r="7" fill="none" stroke="snow" stroke-width="2px" />
          <path d="M13,13 L20,19" stroke="snow" stroke-width="3px" />
        </svg>
      </button>
    </form>
  </div>
  <!--user icon with few nav link -->
  <div class="" >
    <svg style="display:block;">
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
        <li><a href="google.com">Link2</a> </li>
        <li><a href="${pageContext.request.contextPath}/logout">Logout</a> </li>
      </ul>
    </div>
  </div>
  <!--div class="header-item" >
    <button class="menubar">Menu</button>
    <ul class="menu">
      <li class="menu-item"><a href="#">My Profile</a></li>
      <li class="menu-item"><a href="../calendar/calendar.jsp">My Events</a></li>
      <li class="menu-item"><a href="#">Add Event</a></li>
      <li class="menu-item"><a href="../auth/logout.jsp">Logout</a></li>
    </ul>
  </div>

  <div class="header-item">
    <input type="text"><button>Search</button>
    <h3 style="display:inline-block;">
      Hi
      <% String user=((String)session.getAttribute("user"));
        if(user!=null)
        out.print(user);
        else
        out.print("Guest!");
      %>
    </h3>

  </div>
  <div class="header-item">

  </div>-->
</div>
