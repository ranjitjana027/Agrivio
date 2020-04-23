<!DOCTYPE html>
<html>

<head>
	<title>Landing Page </title>

	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/index.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/lib/spinner.css">
	<script src="${pageContext.request.contextPath}/assets/js/lib/spinner.js" ></script>
</head>

<body>
	<div class="spinner"  style="">
    <div class="spinner-container" style="">
      <svg height="300" >
        <ellipse id="circle1" cx="150" cy="150" r="0" stroke="snow" fill="none" />
        <ellipse id="circle2" cx="150" cy="150" r="0" stroke="snow" fill="none" />
        <ellipse id="circle3" cx="150" cy="150" r="0" stroke="snow" fill="none" />
        <ellipse id="circle4" cx="150" cy="150" r="0" stroke="snow" fill="none" />
      </svg>
    </div>

  </div>
	<%
	if((String)session.getAttribute("userid")!=null)
		response.sendRedirect(request.getContextPath()+"/dashboard");
	%>
	<div class="nav">
		<h1 class="wesite-name">Kishan Bandhu</h1>
	</div>
	<div class="container">
		<div class="content">
			<div class="details">
				<div class="detail-item">
					<img class="detail-logo" src="${pageContext.request.contextPath}/assets/img/instruction-manual.png" alt="">
					<h2>Cultivation Of Each Crop</h2>
				</div>
				<div class="detail-item">
					<img class="detail-logo" src="${pageContext.request.contextPath}/assets/img/expert.jpg" alt="">
					<h2>Crop Diseases And Treatments</h2>
				</div>
				<div class="detail-item">
					<img class="detail-logo" src="${pageContext.request.contextPath}/assets/img/notification.png" alt="">
					<h2>fertilizing, harvesting ...</h2>
				</div>
				<div class="detail-item">
					<img class="detail-logo" src="${pageContext.request.contextPath}/assets/img/statistic.png" alt="">
					<h2>loss and profit </h2>
				</div>
			</div>
			<hr>
			<div>
				<a href="${pageContext.request.contextPath}/signup" class="signup">SIGN UP</a>
				<a href="${pageContext.request.contextPath}/login" class="login">LOG IN</a>
			</div>
		</div>
		<div class="image">
			<img class="farmer" src="${pageContext.request.contextPath}/assets/img/auth/vegetables.png" alt="farmer">
		</div>
	</div>
</body>

</html>
