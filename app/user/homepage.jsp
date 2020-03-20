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
			grid-template-rows: 70px 210px auto;
			grid-template-columns: 20% auto 20%;
			background-color:#a8ebf1;
  			margin: 0;

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
				<li><a href="#">My Events</a></li>
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
		</div>
		<div class="grid-item3">
			<a href="../auth/logout.jsp">Logout</a>
			
		</div>
		<div class="grid-item0">
			<jsp:include page="../weather/weather.html"/>
		</div>
		<div class="grid-item5">
			<jsp:include page="../price/mandiPrice.jsp" />
			
		</div>
		<div class="grid-item6">
			<jsp:include page="../ad/ad.jsp"/>
			<h3>Trending Topics</h3>
		</div>
		<div class="grid-item0">
			<jsp:include page="../event/addEvent.jsp" />
			<div id="google_translate_element" style="display:block; bottom:0; position:fixed;"><p>Translate this page:</p></div>

			<script type="text/javascript">
			function googleTranslateElementInit() {
			new google.translate.TranslateElement({pageLanguage: 'en'}, 'google_translate_element');
			}
			</script>

			<script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>

		</div>
		<!--div class="grid-item0">
			<jsp:include page="../article/article.jsp"/>
			
		</div>
		<div class="grid-item0">
			<h3>Trending Topics</h3>
			
		</div-->
	</div>


</body>
</html>