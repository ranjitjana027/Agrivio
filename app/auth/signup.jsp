<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Sign Up</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/auth/signup.css">
	<style>


	</style>
</head>

<body>
	<!-- jsp code start -->
	<%! String errorMessage; %>

	<%

		if(session.getAttribute("userid")==null){
			errorMessage=null;

			if(!request.getMethod().equals("GET")){
				try {

					// Initialize the database
					new org.postgresql.Driver();
					java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

					String username = dbUri.getUserInfo().split(":")[0];
					String password = dbUri.getUserInfo().split(":")[1];
					String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

					Connection con=DriverManager.getConnection(dbUrl, username, password);

					Statement stmt = con.createStatement();
					String insert=("insert into users(firstname, lastname, mobile, email, password) values(  '"
					+ request.getParameter("firstname")+"', '"+request.getParameter("lastname")+"','"+request.getParameter("mobile")
					+"', '"+request.getParameter("email")+"', '" +request.getParameter("password")+ "')");

					stmt.executeUpdate(insert);

					stmt.close();
					con.close();
					response.sendRedirect("../index.jsp");
				}
				catch (Exception e) {
					e.printStackTrace();
					errorMessage="Error occured while signing up.";
				}
			}
		}
		else{
			out.print("<script>alert(\"You're already logged in\"); location.href=\"../user/dashboard.jsp \"</script>");
			//response.sendRedirect("../user/dashboard.jsp");
		}
	%>


	<!-- jsp code end -->
	<header>
		<div class="nav">
			<h1 class="wesite-name">Kishan Bandhu</h1>
		</div>
	</header>

	<div class="container">
		<div class="image">
			<img class="farmer" src="${pageContext.request.contextPath}/assets/img/auth/farmer.png" alt="farmer">
		</div>
		<div class="wrap">
			<h1 class="wrap-header">Create an Account</h1>

			<form class="form" action="" method="post">

				<div class="form-item">
					<input class="input-field" type="text" id="firstname" name="firstname" placeholder="First Name"
						required>
					<input class="input-field" type="text" id="lastname" name="lastname" placeholder="Last Name"
						required>
				</div>
				<div class="form-item">
					<input class="input-field " type="number" name="mobile" id="mobile" placeholder="Contact Number">
					<input class="input-field " type="email" id="email" name="email" placeholder="Email" optional>
				</div>
				<div>
					<div class="form-item">
						<input class="input-field" type="password" id="password" name="password" placeholder="Password"
							minlength="8" pattern=^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$
							required>


						<input class="input-field" type="password" id='re_password' name="re_password"
							placeholder="Confirm Password" minlength="8"
							pattern=^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$ required>
					</div>
					<small id="password_message"></small>
					<div class="password-rule">
						<small>
							Password must be 8-20 characters long, contain letters, numbers and special characters, and
							must not contain spaces or emoji.
						</small>
					</div>
				</div>

				<div>
					<h4><input type="checkbox" required style="width:auto;">I accept the terms & conditions.</h4>
				</div>
				<button type="submit" class="signup" style="width: 100%;">Sign Up</button>

				<% if(errorMessage!=null) { %>
				<div class="form-item error-box">
					<p>
						<span>!</span>
						<%= errorMessage %>
						<% errorMessage=null; %>
					</p>
				</div>
				<% } %>
			</form>

			<footer class="wrap-footer">
				<span>Already Registered? <a href="${pageContext.request.contextPath}/login">Login Now! </a></span>
			</footer>
		</div>
	</div>
</body>

</html>
