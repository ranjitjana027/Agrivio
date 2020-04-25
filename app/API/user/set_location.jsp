<%@ page import="java.sql.*" %>
<%
if(session.getAttribute("userid")!=null){
  try{
    new org.postgresql.Driver();
    java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

    String username = dbUri.getUserInfo().split(":")[0];
    String password = dbUri.getUserInfo().split(":")[1];
    String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

    Connection con=DriverManager.getConnection(dbUrl, username, password);
    String loc_arr[]=new String[2];
    loc_arr[0]=request.getParameter("lat");
    loc_arr[1]=request.getParameter("lon");
    String ip=request.getHeader("X-Forwarded-For");
    if(ip==null)
    ip=request.getRemoteAddr();
    PreparedStatement ps=con.prepareStatement("INSERT INTO location_info(user_id,last_location,last_ip) values (?,?,?::INET)");
    ps.setInt(1,Integer.parseInt((String)session.getAttribute("userid")));
    ps.setArray(2,con.createArrayOf("float4",loc_arr));
    ps.setString(3,ip);
    ps.executeUpdate();
    ps.close();
    con.close();
  }
  catch(Exception e)
  {
    e.printStackTrace();
  }
}
%>
