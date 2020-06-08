<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<c:set var="article_url_path" value="${pageContext.request.requestURI.substring(pageContext.request.requestURI.lastIndexOf('/')+1)}"/>
<c:catch var="exception">
  <c:set var="dbUri"  value="<%=new java.net.URI( System.getenv(\"DATABASE_URL\") ) %>"/>
  <sql:setDataSource
    var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />
  <sql:query dataSource="${connection}" var="result">
    select * from articles where type='PLANT' and url_path=?
    <sql:param value="${article_url_path}" />
  </sql:query>
</c:catch>

<c:if test="${not empty exception}" >
  ${exception.message}
</c:if>

<t:wrapper>
  <jsp:attribute name="header">
    <title>${not empty result.rows[0].title? result.rows[0].title :'404 - Not Found'} - Agrivio</title>
    <link rel="stylesheet" href='${pageContext.request.contextPath}/assets/css/article2.0/article.css'>
  </jsp:attribute>
  <jsp:body>
    <div style="margin:2% 0;">
    <div class="row" >
      <div class="col-8 col-xs-12" >
        <c:choose>
          <c:when test="${result.rowCount>0}">
            <div class="article" >
              <div class="article-header">
                ${result.rows[0].title}
              </div>
              <!--
              <div class="article-metadata">
                Published on : <span> ${result.rows[0].published_on}</span>, Written by <span>${result.rows[0].author}</span>
              </div>
              -->
              <div  class='article-image'>
                <img src="${result.rows[0].thumbnail}" alter="thumbnail">
              </div>
              <div class="article-content">
                ${result.rows[0].content}
              </div>
            </div>
          </c:when>
          <c:otherwise>
            <div>
            <h2> Not Found </h2>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
      <sql:query dataSource="${connection}" var="result">
        select id, title,thumbnail,url_path from articles where type='GUIDE' and  url_path<> ? order by published_on desc limit 6
        <sql:param value="${article_url_path}" />
      </sql:query>
      <div class="col-4 col-sm-12 col-xs-12"  >
        <div class="suggestion">
          <div class="suggestion-header">
            Latest Articles
          </div>
          <div class="parent">
            <c:forEach var="i" items="${result.rows}">
              <div class="custom-class">
                <div class="suggestion-article">
                  <div class="article-image">
                    <a href='${pageContext.request.contextPath}/latest/article/guides/${i.url_path}'>
                      <img src='${i.thumbnail}' alt="">
                    </a>
                  </div>
                  <div class="suggestion-article-header">
                    <a href='${pageContext.request.contextPath}/latest/article/guides/${i.url_path}'>
                      ${i.title}
                    </a>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </div>
      </div>
    </div>
    </div>
  </jsp:body>

</t:wrapper>
