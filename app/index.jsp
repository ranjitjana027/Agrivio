<!DOCTYPE html>
<html>
<head>
	<title>Welcome</title>
</head>
<body>
<%
	if((String)session.getAttribute("userid")!=null)
		response.sendRedirect("user/homepage.jsp");
%>
Please do log in to proceed futher.<br>
<button><a href="auth/login.jsp">LogIn</a></button>
</body>
</html>