<%
if(session.getAttribute("userid")==null )
	response.sendRedirect("../index.jsp");
else{
%>
<!DOCTYPE html>
<html>
<head>
	<title><%= ((String)session.getAttribute("role")).substring(0,1).toUpperCase()+((String)session.getAttribute("role")).substring(1).toLowerCase() %> | Dashboard</title>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<%
	if(session.getAttribute("role").equals("FARMER")){
	%>
		<link rel="stylesheet" href="../../assets/css/user/dashboard.css">
	<% }else if(session.getAttribute("role").equals("ADMIN")){
	%>
		<link rel="stylesheet" href="/css/master.css">
	<%
	}
	%>
	<script src="../../assets/js/admin/layout.js" charset="utf-8"></script>
</head>
<body>
	<%
	if(session.getAttribute("role").equals("FARMER")){
	%>
		<div class="grid">
			<div class="grid-item1 header">
				<div class="logo">

				</div>
				<div class="nav-bar-icon">
          &#9776;
        </div>
				<!-- useful nav link -->
        <div class="user-nav">
					<ul>
						<li>
							<a href="#">Home</a>
						</li>
						<li>
							<a href="#">Calendar</a>
						</li>
						<li>
							<a href="#">Crop Price</a>
						</li>
						<li>
							<a href="#">Weather</a>
						</li>
						<li>
							<a href="#">Ask Experts</a>
						</li>
					</ul>
        </div>
				<!--user icon with few nav link -->
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
              <li><a href="google.com">Link2</a> </li>
              <li><a href="#">Logout</a> </li>
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
			<div class="grid-item0">
				<jsp:include page="../weather/weather.html"/>
			</div>
			<div class="grid-item5">
				<div>
					Welcome to our site!<br>
					<h2>Stay Home, Be Safe.</h2>

					<jsp:include page="../article/article.html" />
				</div>
			</div>
			<div class="grid-item6">
				<h3>Trending Topics</h3>
				<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="275" height="94"
					viewBox="0 0 275 94">
					<defs>
						<style>
							.a {
								fill: #008e71;
								font-size: 40px;
								font-family: OldEnglishTextMT, Old English Text MT;
							}

							.b {
								filter: url(#a);
							}
						</style>
						<filter id="a" x="0" y="0" width="275" height="94" filterUnits="userSpaceOnUse">
							<feOffset dx="5" dy="5" input="SourceAlpha" />
							<feGaussianBlur stdDeviation="7.5" result="b" />
							<feFlood flood-color="#f80d0d" flood-opacity="0.161" />
							<feComposite operator="in" in2="b" />
							<feComposite in="SourceGraphic" />
						</filter>
					</defs>
					<g class="b" transform="matrix(1, 0, 0, 1, 0, 0)"><text class="a" transform="translate(132.5 57.5)">
							<tspan x="-114.248" y="0">Coming Soon</tspan>
						</text></g>
				</svg>
			</div>
			<div class="grid-item0">
				<jsp:include page="../ad/ad.jsp"/>
				<!--div id="google_translate_element" style="display:block; bottom:0; position:fixed;"></div>

				<script type="text/javascript">
				function googleTranslateElementInit() {
				new google.translate.TranslateElement({pageLanguage: 'en'}, 'google_translate_element');
				}
				</script>

				<script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
				-->
			</div>

			<div class="grid-item8">
				<div class="logo-small">

				</div>
				<div>
					<ul style="display:block;" class="bottom-nav">
						<li style="display:inline; font-size: 20px; padding:5px 25px;" class="nav-item"> <a href="#">About Us</a> </li>
						<li style="display:inline; font-size: 20px; padding:5px 25px;" class="nav-item"><a href="#">Terms of Use</a></li>
						<li style="display:inline; font-size: 20px; padding:5px 25px;" class="nav-item"><a href="#">Privacy Policy</a></li>
						<li style="display:inline; font-size: 20px; padding:5px 25px;" class="nav-item"><a href="#">Contact</a></li>
					</ul>
				</div>
				<div>
					&copy; copyright 2020. All right reserved.
				</div>
			</div>
		</div>
	<% }else if(session.getAttribute("role").equals("ADMIN")){
	%>

	<%
	response.sendRedirect("../admin/dashboard.jsp");
	}
	%>

	</body>
</html>
<%
}
%>
