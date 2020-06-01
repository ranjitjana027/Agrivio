<%@ page import="java.sql.*" %>
<%
  Connection con=null;
  Statement st=null;
  ResultSet rs=null;

  try{
    new org.postgresql.Driver();
    java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

    String username = dbUri.getUserInfo().split(":")[0];
    String password = dbUri.getUserInfo().split(":")[1];
    String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

    con=DriverManager.getConnection(dbUrl, username, password);
    st=con.createStatement();
    rs=st.executeQuery("select * from article where type='GUIDE' order by title");
%>

<div class="guide-frontpage">

  <div>
    <div class="filter-item">
      <input type="text" name="filter-guide" placeholder="Filter by Article Title">
    </div>
  </div>
  <div class="no-result hidden">
    <header>
      No Result Found
      <span>Try searching with other keywords.</span>
    </header>
  </div>
  <div class="search-result">
    <header>
      Cultivation Guides
      <span>Click on a article to get detailed article on how to specific topic.</span>
    </header>
    <div class="parent">
    <% while(rs.next()){ %>
      <div class="custom-class">
        <div class="guide-article-card">
          <div class="article-image">
            <a href='${pageContext.request.contextPath}/latest/article/guides?id=<%= rs.getString("id") %>'>
              <img src='data:image/jpeg;base64,<%=new String(java.util.Base64.getEncoder().encode(rs.getBytes("thumbnail")),"UTF-8")%>' alt="">
            </a>
          </div>
          <div class="guide-name">
            <a href='${pageContext.request.contextPath}/latest/article/guides?id=<%= rs.getString("id") %>'>
              <%= rs.getString("title") %>
            </a>
          </div>
        </div>
      </div>
      <% } %>
      <!--<div class="custom-class">
        <div class="guide-article-card">
          <div class="article-image">
            <a href="#"><img src="../../assets/img/COPB1.jpg" alt=""></a>
          </div>
          <div class="guide-name">
            <a href="#">Aliquam volutpat ligula</a>
          </div>
        </div>
      </div>
      <div class="custom-class">
        <div class="guide-article-card">
          <div class="article-image">
            <a href="#"><img src="../../assets/img/COPB1.jpg" alt=""></a>
          </div>
          <div class="guide-name">
            <a href="#">Praesent venenatis ligula</a>
          </div>
        </div>
      </div>
      <div class="custom-class">
        <div class="guide-article-card">
          <div class="article-image">
            <a href="#"><img src="../../assets/img/COPB1.jpg" alt=""></a>
          </div>
          <div class="guide-name">
            <a href="#">Fusce facilisis</a>
          </div>
        </div>
      </div>
      <div class="custom-class">
        <div class="guide-article-card">
          <div class="article-image">
            <a href="#"><img src="../../assets/img/COPB1.jpg" alt=""></a>
          </div>
          <div class="guide-name">
            <a href="#">Aenean vulputate</a>
          </div>
        </div>
      </div>
      <div class="custom-class">
        <div class="guide-article-card">
          <div class="article-image">
            <a href="#"><img src="../../assets/img/COPB1.jpg" alt=""></a>
          </div>
          <div class="guide-name">
            <a href="#">Phasellus ultricies</a>
          </div>
        </div>
      </div>
      <div class="custom-class">
        <div class="guide-article-card">
          <div class="article-image">
            <a href="#"><img src="../../assets/img/COPB1.jpg" alt=""></a>
          </div>
          <div class="guide-name">
            <a href="#">hendrerit pellentesque </a>
          </div>
        </div>
      </div>
      <div class="custom-class">
        <div class="guide-article-card">
          <div class="article-image">
            <a href="#"><img src="../../assets/img/COPB1.jpg" alt=""></a>
          </div>
          <div class="guide-name">
            <a href="#">Aenean vel tristique</a>
          </div>
        </div>
      </div>
      <div class="custom-class">
        <div class="guide-article-card">
          <div class="article-image">
            <a href="#"><img src="../../assets/img/COPB1.jpg" alt=""></a>
          </div>
          <div class="guide-name">
            <a href="#">nulla eros ultrices</a>
          </div>
        </div>
      </div>
      <div class="custom-class">
        <div class="guide-article-card">
          <div class="article-image">
            <a href="#"><img src="../../assets/img/COPB1.jpg" alt=""></a>
          </div>
          <div class="guide-name">
            <a href="#">Aliquam sed</a>
          </div>
        </div>
      </div>-->


    </div>
  </div>
  <script type="text/javascript">
    var v=document.querySelector('.guide-frontpage > .search-result > .parent').children;
    document.querySelector("input[name='filter-guide']").onkeyup=evt=>{
      var flag=false;
      for (var i of v) {
        i.classList.remove("hidden");
        if(evt.target.value.trim()!="" && !i.innerText.toLowerCase().includes(evt.target.value.trim().toLowerCase())){
          i.classList.add("hidden");
        }
        else {
          flag=true;
        }
      }
      if(!flag){
        document.querySelector(".search-result").classList.add("hidden");
        document.querySelector(".no-result").classList.remove("hidden");
      }
      else{
        document.querySelector(".search-result").classList.remove("hidden");
        document.querySelector(".no-result").classList.add("hidden");
      }
    }
  </script>
</div>
<%

  }
  catch (Exception e) {
    e.printStackTrace();
  }
  finally{
    if(con!=null){
      try{ con.close(); } catch(Exception e){;}
      con=null;
    }
    if(st!=null){
      try{ st.close(); } catch(Exception e){;}
      st=null;
    }
    if(rs!=null){
      try{ rs.close(); } catch(Exception e){;}
      rs=null;
    }
  }
%>
