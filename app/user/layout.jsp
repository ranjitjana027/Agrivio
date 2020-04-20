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
	<%
	if(session.getAttribute("role").equals("FARMER")){
	%>
		<link rel="stylesheet" href="../../assets/css/user/dashboard.css">
		<link rel="stylesheet" href="../../assets/css/user/header.css">
		<link rel="stylesheet" href="../../assets/css/user/footer.css">
		<script src="../../assets/js/admin/layout.js" charset="utf-8"></script>
	<% }
	%>

</head>
<body>
	<%
	if(session.getAttribute("role").equals("FARMER")){
	%>
		<div class="grid">
			<jsp:include page="header.jsp" >
				<jsp:param name="userid" value="<%= session.getAttribute(\"userid\") %>" />
			</jsp:include >
			<!-- page content -->
			<div class="grid-section">
				<div class="grid-left">
					<div class="weather-window">
					<jsp:include page="../weather/weather.html"/>
					</div>
					<div>
					Trending Now
					</div>
				</div>
				<!-- include grid content here -->
				<jsp:include page="<%= request.getParameter(\"filename\")%>" />


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
