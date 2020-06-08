
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
      ps=con.prepareStatement("select * from crop_info where lower(name)=?",
      ResultSet.TYPE_SCROLL_SENSITIVE,
      ResultSet.CONCUR_UPDATABLE);
      ps.setString(1,request.getParameter("crop_name").toLowerCase());
      rs=ps.executeQuery();
      int crop_id=-1;
      if(rs.next()){
        crop_id=rs.getInt("id");
        if(!request.getParameter("article_id").equals("")){
          rs.updateInt("article_id",Integer.valueOf(request.getParameter("article_id")));
        }
        rs.updateRow();
      }
      else{
        rs.moveToInsertRow();
        rs.updateString("name",request.getParameter("crop_name").toLowerCase());
        if(!request.getParameter("article_id").equals("")){
          rs.updateInt("article_id",Integer.valueOf(request.getParameter("article_id")));
        }
        rs.insertRow();
        rs.close();
        ps.close();
        ps=con.prepareStatement("select * from crop_info where lower(name)=?");
        ps.setString(1,request.getParameter("crop_name").toLowerCase());
        rs=ps.executeQuery();
        if(rs.next()){
          System.out.println("name: "+rs.getString("name")+" article_id: "+rs.getInt("article_id"));
          crop_id=rs.getInt("id");
        }
      }
      rs.close();
      ps.close();
      System.out.println("running1");
      String[] soils=request.getParameterValues("soils[]");
      java.util.List<Integer> soil_ids=new java.util.ArrayList<>();
      if(!((String)request.getParameter("indian_name")).equals("")){
        ps=con.prepareStatement(" select id from soil_info where indian_name=?");
        ps.setString(1,request.getParameter("indian_name"));
        rs=ps.executeQuery();
        while(rs.next()){
          soil_ids.add(rs.getInt("id"));
        }
        rs.close();
        ps.close();
      }
      if(soils!=null){
        for(String s : soils){
          ps=con.prepareStatement("select * from usda_soil_info where lower(name)=?",
          ResultSet.TYPE_SCROLL_SENSITIVE,
          ResultSet.CONCUR_UPDATABLE);
          ps.setString(1,s.toLowerCase());
          rs=ps.executeQuery();
          if(rs.next()){
            soil_ids.add(rs.getInt("id"));
          }
          else{
            rs.moveToInsertRow();
            rs.updateString("name",s.toLowerCase());
            rs.insertRow();
            rs.close();
            ps.close();
            ps=con.prepareStatement("select * from usda_soil_info where lower(name)=?");
            ps.setString(1,s.toLowerCase());
            rs=ps.executeQuery();
            if(rs.next()){
              soil_ids.add(rs.getInt("id"));
            }
          }
          rs.close();
          ps.close();
        }
      }
      System.out.println("running2");
      for(Integer i : soil_ids){
        ps=con.prepareStatement("insert into soil_crop_mapping(soil_id,crop_id) values (?,?)");
        ps.setInt(1,i);
        ps.setInt(2,crop_id);
        ps.executeUpdate();
        ps.close();
      }

      message="Successfully added crop info";

  }
  catch(Exception e){
      e.printStackTrace();
      error_message="Error occured while adding crop info";
  }
  finally{
    if (rs!=null) {
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
  <jsp:param name="filename" value="add_crop" />
  <jsp:param name="errormessage" value="<%= error_message %>" />
  <jsp:param name="message" value="<%= message %>" />
  <jsp:param name="title" value="Add Crop Info" />
</jsp:forward>
<% } %>
