<!DOCTYPE html>
<html>
<head>
	<title>Welcome</title>
</head>
<body>
<%
	if((String)session.getAttribute("userid")!=null)
		response.sendRedirect("homepage.jsp");
%>
Please do log in to proceed futher.<br>
<button><a href="login.jsp">LogIn</a></button>
</body>
</html>