<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<c:catch var="exception">
  <c:set var="dbUri"  value="<%=new java.net.URI( System.getenv(\"DATABASE_URL\") ) %>"/>
  <sql:setDataSource
    var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />
  <sql:query dataSource="${connection}" var="result">
    select title,thumbnail,url_path from articles where type='PEST' order by title;
  </sql:query>
</c:catch>

<c:if test="${not empty exception}" >
  ${exception.message}
</c:if>

<t:wrapper>
  <jsp:attribute name="header">
    <title>Article | Pests - Agrivio</title>
    <link rel="stylesheet" href='${pageContext.request.contextPath}/assets/css/article2.0/pest_article_frontpage.css'>
  </jsp:attribute>
  <jsp:body>
    <div class="pest-frontpage">
      <div>
        <div class="filter-item">
          <input type="text" name="filter-pest" placeholder="Filter by Pest Name">
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
          Pest Prevention Guides
          <span>Click on a pest to get detailed article on how to identify and prevent it.</span>
        </header>
        <div class="parent">
          <c:forEach var="i" items="${result.rows}">
            <div class="custom-class">
              <div class="pest-article-card">
                <div class="article-image">
                  <a href='${pageContext.request.contextPath}/latest/article/pests/${i.url_path}'>
                    <img src="${fn:replace(i.thumbnail,'https://agrivio-assets.s3.amazonaws.com/','https://o8zks6ll3b.execute-api.us-east-1.amazonaws.com/production/')}?width=250&height=200" alt="Thumbnail">
                  </a>
                </div>
                <div class="pest-name">
                  <a href='${pageContext.request.contextPath}/latest/article/pests/${i.url_path}'>
                    ${i.title}
                  </a>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>
      </div>
      <script type="text/javascript">
        var v=document.querySelector('.pest-frontpage > .search-result > .parent').children;
        document.querySelector("input[name='filter-pest']").onkeyup=evt=>{
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
  </jsp:body>
</t:wrapper>
