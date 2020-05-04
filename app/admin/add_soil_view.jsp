<%@ page import="java.sql.*" %>
<%
  Connection con=null;
  PreparedStatement st1=null, st2=null;
  ResultSet cropSet=null, soilSet=null;
    try {

			// Initialize the database

      new org.postgresql.Driver();
			java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

      String username = dbUri.getUserInfo().split(":")[0];
      String password = dbUri.getUserInfo().split(":")[1];
      String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

      con=DriverManager.getConnection(dbUrl, username, password);


			st1 = con.prepareStatement("SELECT name FROM crop_info");
			cropSet=st1.executeQuery();
      st2 = con.prepareStatement("SELECT name FROM india_soil_info");
      soilSet=st2.executeQuery();



%>
<div class="page-header">
  Add Soil Info
</div>
<form  method="post">

  <% if(!request.getParameter("errormessage").equals("")){ %>
  <div class="errormessage">
    <span style="background-color: white; box-shadow: 2px 2px 10px 2px #000000; padding: 5px 15px; "> <%= request.getParameter("errormessage") %>.
    <span style="background-color: white; cursor:pointer;" onclick="this.parentNode.hidden=true;"> &#10007; </span></span>
  </div>
  <% } %>
  <% if(!request.getParameter("message").equals("")){ %>
  <div class="errormessage" style="color:green;">
    <span style="background-color: white; box-shadow: 2px 2px 10px 2px #000000; padding: 5px 15px; "> <%= request.getParameter("message") %>.
    <span style="background-color: white; cursor:pointer;" onclick="this.parentNode.hidden=true;"> &#10004; </span></span>
  </div>
  <% } %>
  <div class="form-input">
    <label for="usda_name">USDA Taxonomy</label>
    <input type="text" name="usda_name" id="usda_name" placeholder="eg. aquents" required>
  </div>
  <div class="form-input">
    <label for="indian_name">Indian Taxonomy</label>
    <input type="text" id="indian_name" multiple name="indian_name" placeholder="eg. laterite" list="ind_soil_list" required>
    <datalist id="ind_soil_list">
    <%
    while(soilSet.next()){
    %>
      <option><%= soilSet.getString("name") %></option>
    <%
    }
    %>
    </datalist>
  </div>
  <div class="form-input">
    <style media="screen">

    </style>
    <label for="crops[]">Favourable Crops</label>
    <select class="multiple-select" name="crops[]" id="crops[]" multiple >
    <%
    while(cropSet.next()){
    %>
      <option><%= cropSet.getString("name") %></option>
    <%
    }
    %>
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
<%

      }
  catch (Exception e) {
    e.printStackTrace();
  }
  finally{
    if(cropSet!=null){
      try{ cropSet.close(); } catch(Exception e){;}
      cropSet=null;
    }
    if(soilSet!=null){
      try{ soilSet.close(); } catch(Exception e){;}
      soilSet=null;
    }
    if(st1!=null){
      try{ st1.close(); } catch(Exception e){;}
      st1=null;
    }
    if(st2!=null){
      try{ st2.close(); } catch(Exception e){;}
      st2=null;
    }
    if(con!=null){
      try{ con.close(); } catch(Exception e){;}
      con=null;
    }
  }

%>
<script src="${pageContext.request.contextPath}/assets/js/lib/multiple-select.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/assets/js/admin/add_soil.js" charset="utf-8"></script>
