<!DOCTYPE html>
<html>
<head>
	<title>Homepage</title>
	<style type="text/css">
		body{
			margin: 0;
			
		}
		.grid{
			display: grid;
			grid-template-rows: 70px 210px auto 100px;
			grid-template-columns: 20% auto 20% ;
			background-color:#009688;;
			margin: 0;
			min-height: 100vh;

		}
		.grid-item0{
			
			margin:5px;
			background-color:#f1d0f3;
			overflow-y: auto;
			padding:10px;
		}
		.grid-item1
		{
			position:sticky;
			top:0;
			grid-column:1/2;
		}
		.grid-item2
		{
			
			grid-column:2/3;
			position:sticky;
			top:0;
		}
		.grid-item3{
			position:sticky;
			top:0;
			grid-column:3/4;
			
		}
		.grid-item1, .grid-item2, .grid-item3, a{
			background-color: #123456;
			color:snow;
			text-decoration:none;
			margin-bottom:5px;
		}
		.grid-item5{
			padding:5px;
			margin:5px;
			grid-row:2/4;
			grid-column:2/3;
			overflow-y: auto;
			background-color:#f1d0f3;
		}
		.grid-item6{
			
			padding:5px;
			grid-row:2/4;
			grid-column:3/4;
			margin:5px;
			overflow: hidden;
			background-color:#f1d0f3;
		}
		.grid-item8{
			grid-column: 1/4;
			margin: 5px;
			padding: 5px;
			background-color: #f1d0f3;
			text-align: center;
		}
		#menu{
			color: blueviolet;
			list-style: none;
			padding: 10px;
			margin: 0 10px 0 10px;
			position: absolute;
			background-color: aquamarine;
			display: none;
		}
		#menu a{
			text-decoration: none;
		}
		#menubar{
			color: #c1c1c1;
			margin: 10px 0 0 10px;
			padding: 10px;
			
		}
		#menubar:hover + #menu, #menu:hover{
			display: block;
		}
		::-webkit-scrollbar{
			width: 25px;
		}
		::-webkit-scrollbar-track {
			background:#000102;
			border-radius: 20px;
			box-shadow: inset 0px 0px 5px #124112;
		}
		::-webkit-scrollbar-thumb {
			background: #f43685;
			border-radius: 20px;
			
		}
		::-webkit-scrollbar-thumb:hover{
			background: #f01d75;
		}
	</style>
	
</head>
<body>
	<%
	if(session.getAttribute("userid")==null)
		response.sendRedirect("../index.jsp");
	%>
	<div class="grid">
		<div class="grid-item1">
			<button id="menubar">Menu</button>
			<ul id="menu">
				<li><a href="#">My Profile</a></li>
				<li><a href="../calendar/calendar.jsp">My Events</a></li>
				<li><a href="#">Add Event</a></li>
				<li><a href="../auth/logout.jsp">Logout</a></li>
			</ul>
		</div>
		<div class="grid-item2">
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
			<!--script async src="https://cse.google.com/cse.js?cx=013700959376197218555:dczhvimwrno"></script>
			<div class="gcse-search"></div-->
		</div>
		<div class="grid-item3">
			<a href="../auth/logout.jsp">Logout</a>
			
		</div>
		<div class="grid-item0">
			<jsp:include page="../weather/weather.html"/>
		</div>
		<div class="grid-item5">
			<div>
				Welcome to our site!
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
		<!--div class="grid-item0">
			<jsp:include page="../article/article.jsp"/>
			
		</div>
		<div class="grid-item0">
			<h3>Trending Topics</h3>
			
		</div-->
		<div class="grid-item8">
			jhvjhbk
		</div>
	</div>


</body>
</html>