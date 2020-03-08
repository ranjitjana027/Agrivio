<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Sign Up</title>
	</head>
	<body>
			<%@ page import="java.sql.*" %>
			<%! String errorMessage; %>
			
			<% 

				if(session.getAttribute("userid")==null){
					errorMessage=null;
				
			        if(!request.getMethod().equals("GET")){
			            try { 
			
			                // Initialize the database 
			                String dbURL =  "jdbc:oracle:thin:dummy/passsword@localhost:1521:XE"; 		
			                Connection con = DriverManager.getConnection(dbURL );
			
			                Statement stmt = con.createStatement();
			                String insert=("insert into farmers values( seq_person.nextval, '"+request.getParameter("firstname")+"', '"+request.getParameter("lastname")+"','"+request.getParameter("mobile")+"', '"+request.getParameter("email")+"', '" +request.getParameter("password")+ "', NULL)");
			                //st.setString(1, request.getParameter("mobile")); 
			                //st.setString(2, request.getParameter("password"));
			                //ResultSet rs=st.executeQuery();
			                stmt.executeUpdate(insert);
			                
			                stmt.close();
			                con.close();
			            } 
			            catch (Exception e) { 
			                e.printStackTrace(); 
			            } 
				    }
			    }
			    else{
					out.print("<script>alert(\"You're already logged in\"); location.href=\"../user/homepage.jsp \"</script>");
			        //response.sendRedirect("../user/homepage.jsp");
				}
				%>
		<header>
			<h1>Create an Account</h1>
		</header>
		
		<div class=''>
      		<form class="" method="post" >
      		
	      		<div><h1></h1></div>
	        
	        	<div class="" >
	          		<lebel>First Name</lebel>
	          		<input class="form-control" 
	          				type="text" 
	          				id="firstname" 
	          				name="firstname" 
	          				placeholder=""  
	          				required >
	        	</div>
	        	<div>
	        		<lebel>Last Name</lebel>
	          		<input class="" 
	          				type="text" 
	          				id="lastname" 
	          				name="lastname" 
	          				placeholder=""  
	          				required >
	        	</div>
	        	<div>
	        		<label>Mobile</label>
	        		<input class=""
	        				type="number" 
	        				name="mobile"
	        				id="mobile"
	        				>
	        	</div>
			
				<div class="">
					<label for="email">Email</label>
					<input class="" 
							type="email" 
							id="email" 
							name="email" 
							placeholder="abc@example.com" 
							optional>
				</div>


	        	<div class="">
	          		<lebel>Password</lebel>
	          		<input class="" 
	          				type="password" 
	          				id="password" 
	          				name="password" 
	          				placeholder="Password" 
	          				minlength="8"  
	          				pattern =^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$ 
	          				required>
	        		<small class="text-muted" >
	        			Your password must be 8-20 characters long, contain letters, numbers and special characters, and must not contain spaces or emoji.
	        		</small>
	        	</div>
	        
	        	<div class="">
	          		<lebel>Re-enter Password</lebel>
	          		<input class="" 
	          				type="password" 
	          				id='re_password' 
	          				name="re_password" 
	          				placeholder="Re-enter Password" 
	          				minlength="8"  
	          				pattern =^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$ 
	          				required>
					<small id="password_message" class="errormessage"></small>
	        	</div>
	        	
	        	<div class="form-group">
	          		<button type="submit" class="btn btn-primary"  >Sign Up</button>
	        	</div>

	        	<div class="errormessage">
					<%= (errorMessage!=null)?errorMessage:"" %>
				</div>

	        	<footer>
	      			Already Registered? Log In 
	      			<a href="login.jsp" >here.</a>
	      		</footer>
      		</form>

    	</div>
  	</body>
</html>
