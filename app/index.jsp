<!DOCTYPE html>
<html>
<head>
	<title>Landing Page </title>
</head>
<body>
<%
	if((String)session.getAttribute("userid")!=null)
		response.sendRedirect("user/homepage.jsp");
%>
<h1>Welcome</h1>
Please do log in to proceed futher.<br>
<button><a href="auth/login.jsp">LogIn</a></button>
</body>
</html>