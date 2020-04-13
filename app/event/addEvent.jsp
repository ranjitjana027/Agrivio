	<%@ page import="java.sql.*" %>  
	<%! String errorMessage; %>
	<% 
	if(session.getAttribute("userid")!=null){
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
                String insert=("insert into events(day,crop,eventtype,remark,user_id) values( TO_DATE('"+
                                request.getParameter("date")+"', 'YYYY-MM-DD'), '"+
                                request.getParameter("crop")+"','"+request.getParameter("eventtype")+
                                "', '"+request.getParameter("remark")+"', "+ (String)session.getAttribute("userid") +")");
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
    else
        errorMessage="You are not logged in.";
	%>
    <form method="POST">
        <input type="date" name="date" required><br>
        <select name="crop" >
            <option value="Paddy">Paddy</option>
            <option value="Wheat">Wheat</option>
            <option value="Dal">Dal</option>
            <option value="Vegetable1">Vegetable1</option>
            <option value="Vegetable2">Vegetable2</option>
            <option value="Vegetable3">Vegetable3</option>
            <option value="Vegetable4">Vegetable4</option>
        </select><br>
        <select name="eventtype">
            <option value="sowing">Sowing</option>
            <option value="harvesting">Harvesting</option>
        </select>
        <input type="text" name="remark" placeholder="Remark"><br>
        <input type="submit" value="Add">
    </form>
    <div>
		<%= (errorMessage!=null)?errorMessage:"" %>
	</div>
