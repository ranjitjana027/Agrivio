<%@ page import="java.sql.*" %>
<%
  Connection con=null;
  PreparedStatement st=null, st1=null;
  ResultSet soilSet=null, articleSet=null;
    try {

			// Initialize the database

      new org.postgresql.Driver();
			java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

      String username = dbUri.getUserInfo().split(":")[0];
      String password = dbUri.getUserInfo().split(":")[1];
      String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

      con=DriverManager.getConnection(dbUrl, username, password);



      st = con.prepareStatement("SELECT name FROM usda_soil_info");
      soilSet=st.executeQuery();

%>
<div class="page-header">
  Add Crop Info
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
    <label for="crop_name">Crop</label>
    <input type="text" name="crop_name" id="crop_name" placeholder="eg. rice" required>
  </div>
  <div class="form-input">
    <label>Indian Soil Name</label>
    <select  name="indian_name" class="form-select"  >
      <option value="">Choose ...</option>
      <%
        st1=con.prepareStatement("select name from india_soil_info");
        articleSet=st1.executeQuery();
        while(articleSet.next()){
      %>
      <option><%= articleSet.getString("name") %></option>
      <% }
      articleSet.close();
      st1.close();
      %>
    </select>
  </div>

  <div class="form-input">

    <label for="soils[]">Favourable Soil</label>
    <select class="multiple-select" name="soils[]" id="soils[]" multiple >
    <%
    while(soilSet.next()){
    %>
      <option><%= soilSet.getString("name") %></option>
    <%
    }
    %>
    </select>
    <div class="values">

    </div>
  </div>
  <div class="form-input">
    <label for="">Article</label>
    <select class="form-select" name="article_id">
    <option value="">Choose ...</option>
    <%
    st1 = con.prepareStatement("select id, name, title from articles");
    articleSet=st1.executeQuery();
    while(articleSet.next()){
    %>
      <option value="<%= articleSet.getInt("id") %>"><%= articleSet.getString("name") %>: <%= articleSet.getString("title") %></option>
    <% } %>
    </select>
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

    if(soilSet!=null){
      try{ soilSet.close(); } catch(Exception e){;}
      soilSet=null;
    }
    if(articleSet!=null){
      try{ articleSet.close(); } catch(Exception e){;}
      articleSet=null;
    }

    if(st!=null){
      try{ st.close(); } catch(Exception e){;}
      st=null;
    }
    if(st1!=null){
      try{ st1.close(); } catch(Exception e){;}
      st1=null;
    }
    if(con!=null){
      try{ con.close(); } catch(Exception e){;}
      con=null;
    }
  }

%>
<script src="${pageContext.request.contextPath}/assets/js/lib/multiple-select.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/assets/js/admin/add_soil.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/assets/js/lib/custom-select.js" charset="utf-8"></script>
