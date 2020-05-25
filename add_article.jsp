<% if (session.getAttribute("userid")==null || !session.getAttribute("role").equals("ADMIN") ){
  response.sendRedirect(request.getContextPath()+"/login?redirect=/add_article.jsp");
}
%>
<%@page import="java.io.*,java.nio.file.*,java.sql.*" %>
<%
if(request.getMethod().equals("POST")){
  String error_message=null, message=null;
  boolean status=false;
  String author=request.getParameter("author");
  String content=request.getParameter("content");
  String  title=request.getParameter("title");
  String  keywords=request.getParameter("keywords");
  Part filePart = request.getPart("file"); // Retrieves <input type="file" name="file">
  String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
  InputStream fileContent = filePart.getInputStream();
  // ... (do your job here)
  /*File uploads = new File(System.getenv("TOMCAT_IMG_UPLOAD_LOCATION")+"/articles");
  //File file = new File(uploads, "somefilename.ext");
  File file = File.createTempFile("somefilename-", ".ext", uploads);
  try (InputStream fileContent = filePart.getInputStream()) {
      Files.copy(fileContent, file.toPath(),StandardCopyOption.REPLACE_EXISTING);
  }
  catch(Exception e){
    e.printStackTrace();
  }


  out.println(file.getName());*/

  Connection con = null;
  PreparedStatement st = null;
  ResultSet rs=null;
    try {

        // Initialize the database
        new org.postgresql.Driver();
        java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

        String username = dbUri.getUserInfo().split(":")[0];
        String password = dbUri.getUserInfo().split(":")[1];
        String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

        con=DriverManager.getConnection(dbUrl, username, password);

        st=con.prepareStatement("insert into article(title,content,keywords,author,thumbnail) values(?,?,?,?,?)");
        st.setString(1,title);
        st.setString(2,content);
        st.setString(3,keywords);
        st.setString(4,author);
        st.setBinaryStream(5,fileContent);
        st.executeUpdate();
        status=true;
        message="Article added successfully.";
    }
    catch (Exception e) {
      error_message="Error Occured while adding the article.";
      e.printStackTrace();
    }
    finally {
      if (rs != null) {
        try { rs.close(); } catch (SQLException e) { ; }
        rs = null;
      }
      if (st != null) {
        try { st.close(); } catch (SQLException e) { ; }
        st = null;
      }
      if (con != null) {
        try { con.close(); } catch (SQLException e) { ; }
        con = null;
      }
    }
    response.setContentType("application/json");
    out.println("{\"success\": "+status+", \"message\":\""+message+"\", \"error_message\":\""+error_message+"\"}");

  }

else{
  /*Connection con = null;
  PreparedStatement st = null;
  ResultSet rs=null;
    try {

        // Initialize the database
        new org.postgresql.Driver();
        java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL1"));

        String username = dbUri.getUserInfo().split(":")[0];
        String password = dbUri.getUserInfo().split(":")[1];
        String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath();// + "?sslmode=require";

        con=DriverManager.getConnection(dbUrl, username, password);

        st=con.prepareStatement("Select * from article");
        rs=st.executeQuery();
        while(rs.next()){
          out.println("<img src='data:image/jpeg;base64,"+new String(java.util.Base64.getEncoder().encode(rs.getBytes("thumbnail")),"UTF-8")+"' />");
          out.println(rs.getString("content"));
        }
    }
    catch (Exception e) {
        e.printStackTrace();
    }
    finally {
      if (rs != null) {
        try { rs.close(); } catch (SQLException e) { ; }
        rs = null;
      }
      if (st != null) {
        try { st.close(); } catch (SQLException e) { ; }
        st = null;
      }
      if (con != null) {
        try { con.close(); } catch (SQLException e) { ; }
        con = null;
      }
    }
*/
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <style media="screen">
    *,*::after, *::before{
      box-sizing: border-box;
    }
      body{
        margin: 0;
        padding: 0;
        font-family: Microsoft JhengHei, sans-serif;
        letter-spacing: 0.01rem;
      }
      .container{
        display: grid;
        max-width: 1020px;
        margin: auto;
        grid-gap: 5px;
        grid-template-columns: repeat(auto-fill, minmax(min(100%,500px),1fr));
      }
      #article-preview, #article-editor{
        width: 100%;
      }
      input{
        width: 500px;
        max-width: 95%;
      }
      textarea{
        width: 500px;
        max-width: 95%;
      }
      .errormessage{
        color: red;
        padding:15px;
        text-align: center;
        font-family: system-ui;
        font-size: 14px;

      }
      .hidden{
        display: none;
      }
    </style>
    <title></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/article2.0/article.css">
  </head>
  <body>
    <div class="container">
      <div id="article-preview" class="article">
        <h2>Article Preview</h2>
        <div id="article-title" class="article-header"></div>
        <div class="article-metadata">Published on: <span id="today"></span>, Written by <span id="article-author"></span> </div>
        <figure >
          <img src="" class="article-image" id="article-thumbnail">
        </figure>
        <div class="article-content">

        </div>
        <hr>
      </div>
      <div id="article-editor">
        <div class="errormessage hidden">
          <span style="background-color: white; box-shadow: 2px 2px 10px 2px #000000; padding: 5px 15px; " >
            <span id="error_message"></span>
          <span style="background-color: white; cursor:pointer;" onclick="this.parentNode.parentNode.classList.add('hidden')"> &#10007; </span>
        </div>
        <div class="errormessage hidden" style="color:green;">
          <span style="background-color: white; box-shadow: 2px 2px 10px 2px #000000; padding: 5px 15px; ">
            <span  id="message"></span>
          <span style="background-color: white; cursor:pointer;" onclick="this.parentNode.parentNode.classList.add('hidden');"> &#10004; </span></span>
        </div>
        <div class="add-author">
          <label for="">Author</label><br>
          <input type="text" name="author" onkeyup="document.querySelector('#article-author').innerText=this.value;" value="">
        </div>
        <div class="add-article-title">
          <label for="">Article Title</label><br>
          <input type="text" name="title" onkeyup="document.querySelector('#article-title').innerText=this.value;" value="">
        </div>
        <div class="add-keywords">
          <label for="">Keywords</label><br>
          <input type="text" id="article-keywords" name="keywords" value="">
        </div>
        <script type="text/javascript">
          function showImg(input){
            if(input.files && input.files[0]){
              var reader=new FileReader();
              reader.onload=evt=>{
                document.querySelector("#article-thumbnail").src=evt.target.result;
              }
              reader.readAsDataURL(input.files[0])
            }
          }
        </script>
        <div class="add-thumbnail">
          <label for="">Thumbnail</label><br>
          <input type="file" id="imgfile" accept="image/jpeg, image/png" onchange="showImg(this);">
        </div>
        <div class="add-subheader">
          <label for="">Sub Header</label><br>
          <textarea id="subheader" rows="4" cols="80"></textarea>
          <button type="button" id="add-subheader-btn" >Add</button>
        </div>
        <div class="add-para">
          <label for="">Paragraph</label><br>
          <textarea id="paragraph" rows="8" cols="80"></textarea>
          <button type="button" id="add-paragraph-btn" >Add</button>
        </div>
        <div class="">
          <button type="button" onclick="reset();">Reset</button>
        </div>
        <div class="">
          <button type="button" id="add-article-btn">Add Article</button>
        </div>
      </div>
    </div>
    <script type="text/javascript">
    function clearFileInput(input) {
      var newInput=document.createElement("input");
      newInput.type="file";
      newInput.name=input.name;
      newInput.id=input.id;
      newInput.accept=input.accept;
      newInput.onchange=input.onchange;
      input.parentNode.replaceChild(newInput,input)
    }

    function reset() {
      document.querySelector("input[name='author']").value="";
      document.querySelector("input[name='title']").value="";
      document.querySelector("input[name='keywords']").value="";
      document.querySelector(".article-content").innerHTML="";
      document.querySelector("#article-title").innerText="";
      document.querySelector("#article-author").innerText="";
      document.querySelector("#article-keywords").value="";
      document.querySelector("#article-thumbnail").src="";
      clearFileInput(document.querySelector('#imgfile'));
    }


    var d=new Date();
    var date=d.getDate();
    var mon=d.getMonth()+1;
    var yyyy=d.getFullYear();
    document.querySelector("#today").innerText=date+"-"+ ((mon>9)?mon:("0"+mon))+"-"+ yyyy;

      document.querySelector("#add-subheader-btn").onclick=function(){
        document.querySelector('.article-content').innerHTML+="<div class='article-subheader'>"+document.querySelector("#subheader").value+"</div>";
        document.querySelector("#subheader").value="";
      }

      document.querySelector("#add-paragraph-btn").onclick=function(){
        document.querySelector('.article-content').innerHTML+="<p>"+document.querySelector("#paragraph").value+"</p>";
        document.querySelector("#paragraph").value="";
      }

      document.querySelector("#add-article-btn").onclick=function() {
        var content=(document.querySelector(".article-content").innerHTML);
        var title=(document.querySelector("#article-title").innerText);
        var author=(document.querySelector("#article-author").innerText);
        var keywords=(document.querySelector("#article-keywords").value);
        var request=new XMLHttpRequest();
        request.open("POST",location.protocol+"//"+location.host+"/webProject/add_article.jsp")
        var f=new FormData();
        f.append("content",content);
        f.append("title",title);
        f.append("author",author);
        f.append("file",document.querySelector('#imgfile').files[0]);
        f.append("keywords",keywords);
        request.onload=()=>{
          if(request.status==200){
            var data=JSON.parse(request.responseText);
            if(data.success){
              reset();
              document.querySelector("#message").innerHTML=data.message;
              document.querySelector("#message").parentNode.parentNode.classList.remove("hidden");
            }
            else{
              document.querySelector("#error_message").innerHTML=data["error_message"];
              document.querySelector("#error_message").parentNode.parentNode.classList.remove("hidden");
            }
          }
        }
        request.send(f);
      }
    </script>
  </body>
</html>
<%
  }
%>
