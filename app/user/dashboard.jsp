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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user/dashboard.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user/header.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user/footer.css">
		<script src="${pageContext.request.contextPath}/assets/js/admin/layout.js" charset="utf-8"></script>
	<% }
	%>

</head>
<body>
	<%
	if(session.getAttribute("role").equals("FARMER")){
	%>
		<div class="grid">
			<jsp:include page="/app/user/header.jsp" >
				<jsp:param name="userid" value="<%= session.getAttribute(\"userid\") %>" />
			</jsp:include >
			<!-- page content -->
			<div class="grid-section">
				<div class="grid-left">
					<div class="weather-window">
					<jsp:include page="/app/weather/weather.jsp"/>
					</div>
					<div class="ad-window">
					<jsp:include page="/app/ad/ad.jsp" />
					</div>
				</div>
				<div class="grid-content">
					<div class="grid-item5">
						<div>
							Welcome to our site!<br>
							<h2>Stay Home, Be Safe.</h2>

							<jsp:include page="/app/article/article.html" />
						</div>
					</div>
					<div class="grid-item6">
						<h3>Trending Topics</h3>

					</div>
				</div>


			</div>

			<jsp:include page="/app/user/footer.html" />
		</div>
	<% }else if(session.getAttribute("role").equals("ADMIN")){
	%>

	<%
	response.sendRedirect("/app/admin/dashboard.jsp");
	}
	%>

	</body>
</html>
<%
}
%>
