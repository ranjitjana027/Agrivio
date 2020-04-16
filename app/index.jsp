<!DOCTYPE html>
<html>

<head>
	<title>Landing Page </title>

	<link rel="stylesheet" href="../assets/css/index.css">
</head>

<body>
	<%
	if((String)session.getAttribute("userid")!=null)
		response.sendRedirect("user/dashboard.jsp");
	%>
	<div class="nav">
		<h1 class="wesite-name">Kishan Bandhu</h1>
	</div>
	<div class="container">
		<div class="content">
			<div class="details">
				<div class="detail-item">
					<img class="detail-logo" src="../assets/img/instruction-manual.png" alt="">
					<h2>Cultivation Of Each Crop</h2>
				</div>
				<div class="detail-item">
					<img class="detail-logo" src="../assets/img/expert.jpg" alt="">
					<h2>Crop Diseases And Treatments</h2>
				</div>
				<div class="detail-item">
					<img class="detail-logo" src="../assets/img/notification.png" alt="">
					<h2>fertilizing, harvesting ...</h2>
				</div>
				<div class="detail-item">
					<img class="detail-logo" src="../assets/img/statistic.png" alt="">
					<h2>loss and profit </h2>
				</div>
			</div>
			<hr>
			<div>
				<a href="auth/signup.jsp" class="signup">SIGN UP</a>
				<a href="auth/login.jsp" class="login">LOG IN</a>
			</div>
		</div>
		<div class="image">
			<img class="farmer" src="../assets/img/auth/vegetables.png" alt="farmer">
		</div>
	</div>
</body>

</html>