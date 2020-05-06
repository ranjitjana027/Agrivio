
<%
if( session.getAttribute("userid")==null || !session.getAttribute("role").equals("ADMIN"))
  response.sendRedirect(request.getContextPath()+"/index");
else {
%>
<%@ page import="java.sql.*" %>
<%
String error_message="";
String message="";
if(request.getMethod().equals("POST"))
{
  Connection con=null;
  PreparedStatement ps=null;
    try{
        // Initialize the database
        new org.postgresql.Driver();
        java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

        String username = dbUri.getUserInfo().split(":")[0];
        String password = dbUri.getUserInfo().split(":")[1];
        String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

        con=DriverManager.getConnection(dbUrl, username, password);

        // prepared statement
        //PreparedStatement ps=con.prepareStatement("insert into weather_details(min_temp,max_temp,humidity,rainfall) values (?,?,?,?)");
        ps=con.prepareStatement("insert into articles( name , cpa , min_prod_time , profit ,"+
                                                " min_temp , max_temp , humidity , rainfall , soil , land , season ,"+
                                                " soil_prep , sowing , nurturing , production , coolingoff ,extra , conclusion, title) "+
                                                "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
        ps.setString(19,request.getParameter("title"));

        ps.executeUpdate();
        message="Article added successfully";
        ps.close();
        con.close();
    }
    catch(Exception e){
        e.printStackTrace();
        error_message="Error occured while adding the article.";
    }
    finally{
      if(ps!=null){
        try{ ps.close(); } catch(Exception e){;}
        ps=null;
      }
      if(con!=null){
        try{ con.close(); } catch(Exception e){;}
        con=null;
      }
    }


}
%>
<jsp:forward page="/app/admin/layout.jsp">
  <jsp:param name="filename" value="add_article" />
  <jsp:param name="title" value="Add an Article" />
  <jsp:param name="errormessage" value="<%= error_message %>" />
  <jsp:param name="message" value="<%= message %>" />
</jsp:forward>
<%
}
%>
