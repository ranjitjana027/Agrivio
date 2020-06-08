<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<c:catch var="exception">
  <c:set var="dbUri"  value="<%=new java.net.URI( System.getenv(\"DATABASE_URL\") ) %>"/>
  <sql:setDataSource
    var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />
  <sql:query dataSource="${connection}" var="result1">
    select title,thumbnail,content,url_path from articles where type='GUIDE' order by published_on desc limit 5;
  </sql:query>
  <sql:query dataSource="${connection}" var="result2">
    select title,thumbnail,content,url_path from articles where type='GUIDE' order by published_on limit 5;
  </sql:query>
</c:catch>

<c:if test="${not empty exception}" >
  ${exception.message}
</c:if>

<t:wrapper>
  <jsp:attribute name="header">
    <title>Guides - Agrivio</title>
    <link rel="stylesheet" href='${pageContext.request.contextPath}/assets/css/article2.0/article_frontpage.css'>
  </jsp:attribute>
  <jsp:body>
  <div class="front-page">
    <div class="recently-featured">
      <header>Recently Featured</header>
      <div class="row">
        <div class="col-12">

          <div class="main-article">
            <div>
              <a href='${pageContext.request.contextPath}/latest/article/guides/${result1.rows[0].url_path}'>
                <img src='${result1.rows[0].thumbnail}' alt="Thumbnail">
              </a>
            </div>
            <div class="article-header">
              <div class="article-link">
                <a href='${pageContext.request.contextPath}/latest/article/guides/${result1.rows[0].url_path}'>
                  ${result1.rows[0].title}
                </a>
              </div>
              <div class="article-intro">
                ${result1.rows[0].content}
              </div>
            </div>
          </div>

        </div>
      </div>
      <div class="row">
        <c:forEach var="i" items="${result1.rows}" begin="1">
        <div class="col-3 col-sm-3 col-xs-12">
          <div class="other-article">
            <div class="article-image">
            <a href='${pageContext.request.contextPath}/latest/article/guides/${i.url_path}'>
              <img src='${i.thumbnail}' alt="Thumbnail">
            </a>
            </div>
            <div class="article-link">
              <a href='${pageContext.request.contextPath}/latest/article/guides/${i.url_path}'>
                ${i.title}
              </a>
            </div>
          </div>
        </div>
        </c:forEach>
      </div>
    </div>

    <div class="recommendation">
      <header>Recommended for You</header>
      <div class="row">
        <div class="col-12">

          <div class="main-article">
            <div>
              <a href='${pageContext.request.contextPath}/latest/article/guides/${result2.rows[0].url_path}'>
                <img src='${result2.rows[0].thumbnail}' alt="Thumbnail">
              </a>
            </div>
            <div class="article-header">
              <div class="article-link">
                <a href='${pageContext.request.contextPath}/latest/article/guides/${result2.rows[0].url_path}'>
                  ${result2.rows[0].title}
                </a>
              </div>
              <div class="article-intro">
                ${result2.rows[0].content}
              </div>
            </div>
          </div>

        </div>
      </div>
      <div class="row">
      <c:forEach var="i" items="${result2.rows}" begin="1">
      <div class="col-3 col-sm-3 col-xs-12">
        <div class="other-article">
          <div class="article-image">
          <a href='${pageContext.request.contextPath}/latest/article/guides/${i.url_path}'>
            <img src='${i.thumbnail}' alt="Thumbnail">
          </a>
          </div>
          <div class="article-link">
            <a href='${pageContext.request.contextPath}/latest/article/guides/${i.url_path}'>
              ${i.title}
            </a>
          </div>
        </div>
      </div>
      </c:forEach>
      </div>
    </div>
    <div id="view-all-guides">
      <button onclick="location.href='${pageContext.request.contextPath}/latest/article/guides/all'">View All</button>
    </div>
  </div>
  </jsp:body>
</t:wrapper>
