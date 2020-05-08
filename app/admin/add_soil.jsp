
<%
if( session.getAttribute("userid")==null || session.getAttribute("role")==null || !session.getAttribute("role").equals("ADMIN"))
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
    ResultSet rs=null;
    try{
        // Initialize the database
        new org.postgresql.Driver();
        java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

        String username = dbUri.getUserInfo().split(":")[0];
        String password = dbUri.getUserInfo().split(":")[1];
        String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

        con=DriverManager.getConnection(dbUrl, username, password);
        ps=con.prepareStatement("select * from usda_soil_info where lower(name)=?");
        ps.setString(1,request.getParameter("usda_name").toLowerCase());
        rs=ps.executeQuery();
        if(rs.next()){
          error_message="Item already exists";
          rs.close();
          ps.close();
        }
        else{
          rs.close();
          ps.close();
          ps=con.prepareStatement("select * from india_soil_info where lower(name)=?",
                                  ResultSet.TYPE_SCROLL_SENSITIVE,
                                  ResultSet.CONCUR_UPDATABLE);
          ps.setString(1,request.getParameter("indian_name").toLowerCase());
          rs=ps.executeQuery();
          int indian_name_id=-1;
          if(rs.next()){
            indian_name_id=rs.getInt("id");
            rs.close();
          }
          else{
            rs.moveToInsertRow();
            rs.updateString("name",request.getParameter("indian_name").toLowerCase());
            rs.insertRow();
            rs.close();
            ps.close();
            ps=con.prepareStatement("select * from india_soil_info where lower(name)=?");
            ps.setString(1,request.getParameter("indian_name").toLowerCase());
            rs=ps.executeQuery();
            if(rs.next()){
              indian_name_id=rs.getInt("id");
              rs.close();
            }
          }
          ps.close();
          String crops[]=request.getParameterValues("crops[]");
          java.util.List<Integer> crops_id=new java.util.ArrayList<>();
          if(crops!=null)
          for(String s: crops){
            ps=con.prepareStatement("select * from crop_info where lower(name)=?",
                                    ResultSet.TYPE_SCROLL_SENSITIVE,
                                    ResultSet.CONCUR_UPDATABLE);
                                    ps.setString(1, s.toLowerCase());
            rs=ps.executeQuery();
            if(rs.next()){
              crops_id.add(rs.getInt("id"));
              rs.close();
            }
            else{
              rs.moveToInsertRow();
              rs.updateString("name",s.toLowerCase());
              rs.insertRow();
              rs.close();
              ps.close();
              ps=con.prepareStatement("select * from crop_info where lower(name)=?");
              ps.setString(1, s.toLowerCase());
              rs=ps.executeQuery();
              if(rs.next()){
                crops_id.add(rs.getInt("id"));
                rs.close();
              }
            }
            ps.close();
          }
          ps=con.prepareStatement("insert into usda_soil_info(name,indian_name) values(?,?)");
          ps.setString(1,request.getParameter("usda_name").toLowerCase());
          ps.setInt(2,indian_name_id);
          ps.executeUpdate();
          ps.close();

          ps=con.prepareStatement("select * from usda_soil_info where lower(name)=?");
          ps.setString(1,request.getParameter("usda_name").toLowerCase());
          rs=ps.executeQuery();
          int soil_id=-1;
          if(rs.next()){
            soil_id=rs.getInt("id");
          }
          rs.close();
          ps.close();
          for(int i : crops_id){
            ps=con.prepareStatement("insert into soil_crop_mapping values(?,?)");
            ps.setInt(1,soil_id);
            ps.setInt(2,i);
            ps.executeUpdate();
            ps.close();
          }
          message="Successfully added soil info";
        }



        con.close();


    }
    catch(Exception e){
        e.printStackTrace();
        error_message="Error occured while adding the soil info";
    }
    finally{
      if(rs!=null){
        try{ rs.close(); } catch(Exception e){;}
        rs=null;
      }
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
  <jsp:param name="filename" value="add_soil" />
  <jsp:param name="errormessage" value="<%= error_message %>" />
  <jsp:param name="message" value="<%= message %>" />
  <jsp:param name="title" value="Add Soil Info" />
</jsp:forward>
<% } %>
