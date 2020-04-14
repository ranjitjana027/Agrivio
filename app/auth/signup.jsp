<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Sign Up</title>
		<link rel="stylesheet" type="text/css" href="../../assets/css/auth/signup.css">
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
		<header></header>
		
		<div class="wrap">
			<h1 class="wrap-header">Create an Account</h1>
			
			<form class="form" action="" method="post" >
				<div class="form-item">
					<div class="form-row-item">
						<label class="form-input-label" for="">First Name</label>
						<div class="form-input-item">
							<input  type="text" id="firstname" name="firstname" placeholder="First Name" required style="width: 158px;">
						</div>
						
					</div>
					<div class="form-row-item">
						<label class="form-input-label"  for="">Last Name</label>
						<div class="form-input-item" >
							<input type="text" id="lastname" name="lastname" placeholder="Last Name" required style="width: 170px;">
						</div>
					</div>
				</div>
				<div class="form-item">
					<label class="form-input-label"  for="">Mobile</label>
					<div class="form-input-item">
						<input type="number" name="mobile" id="mobile" placeholder="Contact Number">
					</div>
				</div>
				<div class="form-item">
					<label class="form-input-label"  for="">Email (Optional)</label>
					<div class="form-input-item">
						<input type="email" id="email" name="email" placeholder="Email" optional>
					</div>
				</div>


				<div class="form-item">
					<label class="form-input-label"  for="">Password</label>
					<div class="form-input-item">
						<input type="password" id="password" name="password" placeholder="Password" minlength="8"
							pattern=^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$ required>
					</div>
					
				</div>
				<div class="form-item">
					<label class="form-input-label"  for="">Confirm Password</label>
					<div class="form-input-item">
						<input type="password" id='re_password' name="re_password" placeholder="Confirm Password"
							minlength="8" pattern=^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$ required>
					
					<small id="password_message" ></small>
					<small class="text-muted">
						Password must be 8-20 characters long, contain letters, numbers and special characters, and must not contain
						spaces or emoji.
					</small>
					</div>
				</div>

				<div class="form-item">
					<input type="checkbox"  required style="width:auto;">I accept the terms & conditions.
				</div>
				
				<div class="form-item">
					<button type="submit" class="button-submit" style="width: 100%;" >Sign Up</button>
				</div>

				<div class="errormessage form-item">
				<%= (errorMessage!=null)?errorMessage:"" %>
				
				</div>
			</form>

			<footer class="wrap-footer">
				<span>Already Registered? <a href="login.jsp" >Login Now! </a></span>
			</footer>
		</div>
		
	</body>
</html>
