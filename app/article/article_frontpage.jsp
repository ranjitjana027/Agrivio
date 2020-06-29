<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<c:catch var="exception">
  <c:set var="dbUri"  value="<%=new java.net.URI( System.getenv(\"DATABASE_URL\") ) %>"/>
  <sql:setDataSource
    var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />
  <sql:query dataSource="${connection}" var="result1">
    select title,thumbnail,snippet,url_path from articles where type='GUIDE' order by published_on desc limit 5;
  </sql:query>

  <sql:query dataSource="${connection}" var="topics">
    select distinct type from articles order by type;
  </sql:query>
</c:catch>

<c:if test="${not empty exception}" >
  ${exception.message}
</c:if>

<t:wrapper>
  <jsp:attribute name="header">
    <title>Articles - All aspects of cultivation in easy words</title>
    <link rel="stylesheet" href='${pageContext.request.contextPath}/assets/css/article2.0/article_frontpage.css'>
    <link rel="stylesheet" href='${pageContext.request.contextPath}/assets/css/lib/lazy-loading.css'>
    <script src="${pageContext.request.contextPath}/assets/js/lib/lazy-loading.js"></script>
  </jsp:attribute>
  <jsp:body>
  <div class="front-page">
    <div class="recently-featured">
      <h2>Recently Featured </h2>
      <div class="row">
        <div class="col-12 col-sm-12 col-xs-12">

          <div class="main-article">
            <div>
              <a href='${pageContext.request.contextPath}/latest/article/guides/${result1.rows[0].url_path}'>
                <img src="${result1.rows[0].thumbnail}"  alt="Thumbnail">
              </a>
            </div>
            <div class="article-header">
              <div class="article-link">
                <a href='${pageContext.request.contextPath}/latest/article/guides/${result1.rows[0].url_path}'>
                  ${result1.rows[0].title}
                </a>
              </div>
              <div class="article-intro">
                ${result1.rows[0].snippet}
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
                <img data-src="${fn:replace(i.thumbnail,'https://agrivio-assets.s3.amazonaws.com/','https://o8zks6ll3b.execute-api.us-east-1.amazonaws.com/production/')}?width=250&height=150" class="lazy" alt="Thumbnail">
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

      <c:catch var="exception">
        <c:forEach var="topic" items="${topics.rows}">
          <sql:query dataSource="${connection}" var="result">
            select title,thumbnail,url_path from articles where type=? order by published_on limit 4;
            <sql:param value="${topic.type}" />
          </sql:query>
          <hr class="mobile-hidden">
          <div class="subheader">
            <h2>${fn:toLowerCase(topic.type)} articles</h2>
            <div class="mobile-hidden"><a href="${pageContext.request.contextPath}/latest/article/${fn:toLowerCase(topic.type)}s/all">More &gt;&gt;</a></div>
          </div>
          <div class="row">
            <c:forEach var="i" items="${result.rows}" >
              <div class="col-3 col-sm-3 col-xs-12">
                <div class="other-article">
                  <div class="article-image">
                  <a href='${pageContext.request.contextPath}/latest/article/${fn:toLowerCase(topic.type)}s/${i.url_path}'>
                    <img data-src="${fn:replace(i.thumbnail,'https://agrivio-assets.s3.amazonaws.com/','https://o8zks6ll3b.execute-api.us-east-1.amazonaws.com/production/')}?width=250&height=150" alt="Thumbnail" class="lazy">
                  </a>
                  </div>
                  <div class="article-link">
                    <a href='${pageContext.request.contextPath}/latest/article/${fn:toLowerCase(topic.type)}s/${i.url_path}'>
                      ${i.title}
                    </a>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
          <div class="view-all-guides desktop-hidden tablet-hidden">
            <button onclick="location.href='${pageContext.request.contextPath}/latest/article/${fn:toLowerCase(topic.type)}s/all'">More</button>
          </div>
        </c:forEach>
      </c:catch>

      <c:if test="${not empty exception}" >
        ${exception.message}
      </c:if>
    </div>


  </div>
  </jsp:body>
</t:wrapper>
