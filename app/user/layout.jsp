<%
if(session.getAttribute("userid")==null )
	response.sendRedirect("../index.jsp");
else{
%>
<!DOCTYPE html>
<html>

<head>
	<title><%= request.getParameter("title") %> | Dashboard</title>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<%
	if(session.getAttribute("role").equals("FARMER")){
	%>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/lib/spinner.css">
	<script src="${pageContext.request.contextPath}/assets/js/lib/spinner.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user/layout.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user/header.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user/footer.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css">
	<script src="${pageContext.request.contextPath}/assets/js/user/layout.js" charset="utf-8"></script>
	<script src="${pageContext.request.contextPath}/assets/js/app.js" charset="utf-8"></script>

	<% }
	%>

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
	<%
	if(session.getAttribute("role").equals("FARMER")){
	%>
	<div class="grid">
		<jsp:include page="header.jsp">
			<jsp:param name="userid" value="<%= session.getAttribute(\"userid\") %>" />
		</jsp:include>
		<!-- page content -->
		<div class="grid-section">
			<div class="grid-left">
				<div class="weather-window">
					<jsp:include page="../weather/weather.jsp" />
				</div>


					<!--change to other contents like statistics -->



			</div>

			<!-- include grid content here -->
			<div id="main-content">
				<jsp:include page="<%= request.getParameter(\"filename\")%>" />
			</div>



		</div>

		<jsp:include page="footer.html" />
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
