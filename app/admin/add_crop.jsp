
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
      pageContext.setAttribute("message",message);

  }
  catch(Exception e){
      e.printStackTrace();
      error_message="Error occured while adding crop info";
      pageContext.setAttribute("errormessage",error_message);
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
<% } %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>
<c:set var="article_url_path" value="${pageContext.request.requestURI.substring(pageContext.request.requestURI.lastIndexOf('/')+1)}"/>
<c:catch var="exception">
  <c:set var="dbUri"  value="<%=new java.net.URI( System.getenv(\"DATABASE_URL\") ) %>"/>
  <sql:setDataSource
    var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />
  <sql:query dataSource="${connection}" var="soilSet">
    select name from usda_soil_info;
  </sql:query>
  <sql:query dataSource="${connection}" var="indiaSoilSet">
    select name from india_soil_info;
  </sql:query>
</c:catch>

<c:if test="${not empty exception}" >
  ${exception.message}
</c:if>

<t:admin-wrapper>
  <jsp:attribute name="header">
    <title>Add Crop Info</title>
    <link rel="stylesheet" href='${pageContext.request.contextPath}/assets/css/admin/add_crop.css'>
  </jsp:attribute>
  <jsp:body>
  <div class="page-header">
    Add Crop Info
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
      <label for="crop_name">Crop</label>
      <input type="text" name="crop_name" id="crop_name" placeholder="eg. rice" required>
    </div>
    <div class="form-input">
      <label>Indian Soil Name</label>
      <select  name="indian_name" class="form-select"  >
        <option value="">Choose ...</option>
          <c:forEach items="${indiaSoilSet.rows}" var="i">
            <option>${i.name}</option>
          </c:forEach>
      </select>
    </div>

    <div class="form-input">

      <label for="soils[]">Favourable Soil</label>
      <select class="multiple-select" name="soils[]" id="soils[]" multiple >
        <c:forEach items="${soilSet.rows}" var="i">
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
  <script src="${pageContext.request.contextPath}/assets/js/lib/custom-select.js" charset="utf-8"></script>

  </jsp:body>
</t:admin-wrapper>
