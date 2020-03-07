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
			grid-template-rows: 10% 35% auto;
			grid-template-columns: 20% auto 20%;
			width: 100vw;
  			height: 100vh;
  			padding: 0;
  			margin: 0;

		}
		.grid-item0{
			
			border: solid green;
			
			overflow-y: auto;
		}
	</style>
</head>
<body>
	<%
	if(session.getAttribute("userid")==null)
		response.sendRedirect("welcome.html");
	%>
	<div class="grid">
		<div class="grid-item0">
			
		</div>
		<div class="grid-item0">
			<h3>
				Hi 
				<% String user=((String)session.getAttribute("user"));
					if(user!=null)
					out.print(user);
					else 
					out.print("Guest!");
				%> 
			</h3>
		</div>
		<div class="grid-item0">
			<a href="logout.jsp">Logout</a>
		</div>
		<div class="grid-item0">
			<jsp:include page="weather.html"/>
		</div>
		<div class="grid-item0">
			<jsp:include page="addEvent.jsp" />
		</div>
		<div class="grid-item0">
			
		</div>
		<div class="grid-item0">
			
		</div>
		<div class="grid-item0">
			
		</div>
		<div class="grid-item0">
			
		</div>
	</div>


</body>
</html>