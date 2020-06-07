<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<c:catch var="exception">
  <c:set var="dbUri"  value="<%=new java.net.URI( System.getenv(\"DATABASE_URL\") ) %>"/>
  <sql:setDataSource
    var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />
  <sql:query dataSource="${connection}" var="result">
    select * from articles where type='GUIDE' and id=?
    <sql:param value="${Integer.parseInt(param.id)}" />
  </sql:query>
</c:catch>

<c:if test="${not empty exception}" >
  ${exception.message}
</c:if>
<div style="margin:2% 0;">
<div class="row" >
  <div class="col-8 col-xs-12" >
    <c:choose>
      <c:when test="${result.rowCount>0}">
        <div class="article" >
          <div class="article-header">
            ${result.rows[0].title}
          </div>
          <div class="article-metadata">
            Published on : <span> ${result.rows[0].published_on}</span>, Written by <span>${result.rows[0].author}</span>
          </div>
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
    select id, title,thumbnail from articles where type='GUIDE' and  id<> ? order by published_on desc limit 6
    <sql:param value="${Integer.parseInt(param.id)}" />
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
                <a href='${pageContext.request.contextPath}/latest/article/guides?id=${i.id}'>
                  <img src='${i.thumbnail}' alt="">
                </a>
              </div>
              <div class="suggestion-article-header">
                <a href='${pageContext.request.contextPath}/latest/article/guides?id=${i.id}'>
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
