
<%@ page import="java.sql.*" %>
<%
String error_message="";
if(request.getMethod().equals("POST"))
{
    try{
        // Initialize the database
        new org.postgresql.Driver();
        java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

        String username = dbUri.getUserInfo().split(":")[0];
        String password = dbUri.getUserInfo().split(":")[1];
        String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

        Connection con=DriverManager.getConnection(dbUrl, username, password);

        // prepared statement
        //PreparedStatement ps=con.prepareStatement("insert into weather_details(min_temp,max_temp,humidity,rainfall) values (?,?,?,?)");
        PreparedStatement ps=con.prepareStatement("insert into articles( name , cpa , min_prod_time , profit ,"+
                                                " min_temp , max_temp , humidity , rainfall , soil , land , season ,"+
                                                " soil_prep , sowing , nurturing , production , coolingoff ,extra , conclusion) "+
                                                "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
        ps.setString(1,request.getParameter("name"));
        ps.setDouble(2,Double.valueOf(request.getParameter("cpa")));
        ps.setDouble(3,Double.valueOf(request.getParameter("min_prod_time")));
        ps.setString(4,request.getParameter("profit"));
        ps.setDouble(5,Double.valueOf(request.getParameter("min_temp")));
        ps.setDouble(6,Double.valueOf(request.getParameter("max_temp")));
        ps.setDouble(7,Double.valueOf(request.getParameter("humidity")));
        ps.setDouble(8,Double.valueOf(request.getParameter("rainfall")));
        ps.setString(9,request.getParameter("soil"));
        ps.setString(10,request.getParameter("land"));
        ps.setString(11,request.getParameter("season"));
        ps.setString(12,request.getParameter("soil_prep"));
        ps.setString(13,request.getParameter("sowing"));
        ps.setString(14,request.getParameter("nurturing"));
        ps.setString(15,request.getParameter("production"));
        ps.setString(16,request.getParameter("coolingoff"));
        ps.setString(17,request.getParameter("extra"));
        ps.setString(18,request.getParameter("conclusion"));

        ps.executeUpdate();
    }
    catch(Exception e){
        e.printStackTrace();
        error_message="Error occured while adding the article.";
    }


}
%>
<jsp:forward page="layout.jsp">
  <jsp:param name="filename" value="add_user" />
  <jsp:param name="errormessage" value="<%= error_message %>" />
</jsp:forward>
