<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Login Page</title>

    <link rel="stylesheet" href="../../assets/css/auth/login.css">
</head>
<body>
    
    <%! String errorMessage; %>
    <% 
        if(session.getAttribute("userid")!=null){
            out.print("<script>alert(\"You're already logged in\"); location.href=\"../user/homepage.jsp \"</script>");
        }
        if(!request.getMethod().equals("GET")){
            try { 
                
                // Initialize the database 
                new org.postgresql.Driver();
                java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

                String username = dbUri.getUserInfo().split(":")[0];
                String password = dbUri.getUserInfo().split(":")[1];
                String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

                Connection con=DriverManager.getConnection(dbUrl, username, password);
                
                //Statement stmt = con.createStatement();
                PreparedStatement st = con.prepareStatement("SELECT * FROM users where mobile=?  and password=?");
                st.setString(1, request.getParameter("mobile")); 
                st.setString(2, request.getParameter("password"));
                ResultSet rs=st.executeQuery();
                
                
                if(rs.next())
                {
                    out.println(rs.getString("id"));
                    session.setAttribute("userid",rs.getString("id") );
                    session.setAttribute("user",rs.getString("firstname")+" "+rs.getString("lastname"));
                    session.setAttribute("mobile",rs.getString("mobile"));
                }
                if((String)session.getAttribute("userid")!=null)
                    response.sendRedirect("../user/homepage.jsp");
                else
                    errorMessage="Invalid Username/Password.";
            } 
            catch (Exception e) { 
                e.printStackTrace(); 
            } 
        }
        %>
    <div id="div1">
        <h1>KisanBandhu.in</h4>
    </div>
    <form method="POST">
        <h2>Login</h2>
        <span></span>
        <div class="form-input">
            <b>Mobile:</b>
            <br>
            <input type="text" name="mobile" placeholder="Mobile" id="fi1" required>
            
        </div>
        
        <div class="form-input">
            <b>Password:</b>
            <br>
            <input type="password" name="password" placeholder="Password" id="fi2" required>
        </div>
        
        <div class="form-input">
            <input type="submit" value="Continue" id="fi3">
        </div>
        
        <div style=" font-size:15px; color:red;" >
            <%= (errorMessage!=null)?errorMessage:"" %>
            <% errorMessage=null; %>
        </div>
        <p>By continuing, you agree to ShopOnline's
            <a href="terms&condition.html">Conditions of Use</a> 
            and <a href="terms&condition.html">Privacy Notice</a>.</p>
        <p>Need help?</p>     
    </form>
    <hr>
    <div id="div2">
        <p>© 2020-onwards, ShopOnline.com, Inc. or its affiliates</p>
    </div>
</body>
</html>