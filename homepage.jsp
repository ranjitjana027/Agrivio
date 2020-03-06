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
			grid-template-rows: 10% 50% auto;
			grid-template-columns: 20% auto 20%;
			width: 100vw;
  			height: 100vh;
  			padding: 0;
  			margin: 0;

		}
		.grid-item0{
			
			border: solid green;
			
			overflow-y: scroll;;
		}
	</style>
</head>
<body>
	<h1>
		Hi 
		<% String user=((String)session.getAttribute("user"));
			if(user!=null)
			out.print(user);
			else 
			out.print("Guest!");
		%> 
	</h1>
	<div class="grid">
		<div class="grid-item0">
			jhvhgv
		</div>
		<div class="grid-item0">
			jhvhgv
		</div>
		<div class="grid-item0">
			jhvhgv
		</div>
		<div class="grid-item0">
			jhvhgv
		</div>
		<div class="grid-item0">
			jhvhgv
		</div>
		
	</div>


</body>
</html>