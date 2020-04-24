<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Login Page</title>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/auth/login.css">
</head>

<body>

    <%! String errorMessage; %>
    <%
        if(session.getAttribute("userid")!=null){
            out.print("<script>alert(\"You're already logged in\"); location.href=\""+request.getContextPath()+"/dashboard \"</script>");
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
                PreparedStatement st = con.prepareStatement("SELECT * FROM users where mobile=?  and password=?",
                  ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                st.setString(1, request.getParameter("mobile"));
                st.setString(2, request.getParameter("password"));
                ResultSet rs=st.executeQuery();


                if(rs.next())
                {
                    out.println(rs.getString("id"));
                    session.setAttribute("userid",rs.getString("id") );
                    session.setAttribute("user",rs.getString("firstname")+" "+rs.getString("lastname"));
                    session.setAttribute("mobile",rs.getString("mobile"));
                    session.setAttribute("role",rs.getString("role"));
                    rs.updateTimestamp("last_login",new java.sql.Timestamp(new java.util.Date().getTime()));
                    rs.updateRow();
                }
                rs.close();
                con.close();
                if((String)session.getAttribute("userid")!=null)
                    {
                      response.sendRedirect(request.getContextPath()+"/dashboard");
                    }
                else
                    errorMessage="Invalid Username/Password.";
            }
            catch (Exception e) {
				errorMessage="sckjhjkh";
                e.printStackTrace();
            }
        }
        %>

    <div class="nav">
        <h1 class="wesite-name">Kishan Bandhu</h1>
    </div>
    <div class="container">
        <div class="image">
            <img class="farmer" src="${pageContext.request.contextPath}/assets/img/auth/farmer.png" alt="farmer">
        </div>


		<form method="post"  class="wrap">
            <div class="form-item">
                <b>Mobile:</b>
                <br>
                <input class="input-field" type="text" name="mobile" placeholder="Mobile" id="fi1" required>

            </div>

            <div class="form-item">
                <b>Password:</b>
                <br>
                <input class="input-field" type="password" name="password" placeholder="Password" id="fi2" required>
            </div>

            <div>
                <input class="login" type="submit" value="Login" id="fi3">
            </div>
			<% if(errorMessage!=null) { %>
            <div class="form-item error-box">
                <p>
                    <span>!</span>
                    <%= errorMessage %>
                    <% errorMessage=null; %>
                </p>
            </div>
			<% } %>

            <div>
                <p>By continuing, you are agree to our
                    <a href="${pageContext.request.contextPath}/app/auth/terms&condition.html">Conditions of Use</a>
                    and <a href="${pageContext.request.contextPath}/app/auth/terms&condition.html">Privacy Notice</a>.</p>
                <p>Need help?</p>
            </div>
            </form>

    </div>
</body>

</html>
