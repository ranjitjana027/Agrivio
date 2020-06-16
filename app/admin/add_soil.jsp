
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
          pageContext.setAttribute("message",message);
        }



        con.close();


    }
    catch(Exception e){
        e.printStackTrace();
        error_message="Error occured while adding the soil info";
        pageContext.setAttribute("errormessage",error_message);
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

<% } %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>
<c:set var="article_url_path" value="${pageContext.request.requestURI.substring(pageContext.request.requestURI.lastIndexOf('/')+1)}"/>
<c:catch var="exception">
  <c:set var="dbUri"  value="<%=new java.net.URI( System.getenv(\"DATABASE_URL\") ) %>"/>
  <sql:setDataSource
    var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />
  <sql:query dataSource="${connection}" var="cropSet">
    select name from crop_info;
  </sql:query>
  <sql:query dataSource="${connection}" var="soilSet">
    select name from india_soil_info;
  </sql:query>
</c:catch>

<c:if test="${not empty exception}" >
  ${exception.message}
</c:if>

<t:admin-wrapper>
  <jsp:attribute name="header">
    <title>Add Soil Info</title>
    <link rel="stylesheet" href='${pageContext.request.contextPath}/assets/css/admin/add_soil.css'>
  </jsp:attribute>
  <jsp:body>
  <div class="page-header">
    Add Soil Info
  </div>
  <form  method="post">
    <c:if test="${ not empty errormessage}">
      <div class="errormessage">
        <span style="background-color: white; box-shadow: 2px 2px 10px 2px #000000; padding: 5px 15px; "> ${errormessage}.
        <span style="background-color: white; cursor:pointer;" onclick="this.parentNode.hidden=true;"> &#10007; </span></span>
      </div>
    </c:if>
    <c:if test="${ not empty message}">
      <div class="errormessage" style="color:green;">
        <span style="background-color: white; box-shadow: 2px 2px 10px 2px #000000; padding: 5px 15px; ">  ${message}.
        <span style="background-color: white; cursor:pointer;" onclick="this.parentNode.hidden=true;"> &#10004; </span></span>
      </div>
    </c:if>
    <div class="form-input">
      <label for="usda_name">USDA Taxonomy</label>
      <input type="text" name="usda_name" id="usda_name" placeholder="eg. aquents" required>
    </div>
    <div class="form-input">
      <label for="indian_name">Indian Taxonomy</label>
      <input type="text" id="indian_name" multiple name="indian_name" placeholder="eg. laterite" list="ind_soil_list" required>
      <datalist id="ind_soil_list">
        <c:forEach items="${soilSet.rows}" var="i">
          <option>${i.name}</option>
        </c:forEach>
      </datalist>
    </div>
    <div class="form-input">
      <style media="screen">

      </style>
      <label for="crops[]">Favourable Crops</label>
      <select class="multiple-select" name="crops[]" id="crops[]" multiple >
      <c:forEach items="${cropSet.rows}" var="i">
        <option>${i.name}</option>
      </c:forEach>
      </select>
      <div class="values">

      </div>
    </div>
    <div class="form-button">
      <div class="btn-left">
        <button type="reset">Reset</button>
      </div>
      <div class="btn-right">
        <button type="submit">Save</button>
      </div>
    </div>
  </form>
  <script src="${pageContext.request.contextPath}/assets/js/lib/multiple-select.js" charset="utf-8"></script>
  <script src="${pageContext.request.contextPath}/assets/js/admin/add_soil.js" charset="utf-8"></script>
  </jsp:body>
</t:admin-wrapper>
