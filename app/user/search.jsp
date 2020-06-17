<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<c:catch var="exception">
  <c:set var="dbUri"  value="<%=new java.net.URI( System.getenv(\"DATABASE_URL\") ) %>"/>
  <sql:setDataSource
    var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />
  <sql:query dataSource="${connection}" var="result">
    select * from articles where lower(title) like ? or lower(keywords) like ?;
    <sql:param value="%${param.q}%" />
    <sql:param value="%${param.q}%" />
  </sql:query>
</c:catch>

<c:if test="${not empty exception}" >
  ${exception.message}
</c:if>

<t:wrapper>
  <jsp:attribute name="header">
    <title>Search Results - Agrivio</title>
    <style media="screen">
      .search-result{
        width: 95%;
        margin: auto;
      }
      .search-result-article{
        padding: 10px 0;

      }
      .search-result-article h3{
        margin:2px 0;
        text-align: justify;
        /*padding: 5px 0;*/
      }
      .search-result-article > h3 > a{
        text-decoration: none;
        color: #045638;
      }
      .search-result-article p{
        padding:0;
        margin: 0;
      }
      .link{
        margin: 2px 0;
        font-size: 18px;
        color: #024c45;
      }

    </style>
  </jsp:attribute>
  <jsp:body>
    <div class="">
      <div class="search-result">
        <h2>Search Results</h2>
        <c:forEach var="i" items="${result.rows}">
        <div class="search-result-article">
          <h3>
            <a href="${pageContext.request.contextPath}/latest/article/guides/${i.url_path}">${i.title}</a>
          </h3>
          <div class="link">
            ${header['host']}${pageContext.request.contextPath}/latest/article/guides/${i.url_path}
          </div>
          <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus et consectetur lorem. Fusce elit lacus, pellentesque eu facilisis in, consectetur ut enim.</p>
        </div>
        </c:forEach>
      </div>
    </div>
  </jsp:body>
</t:wrapper>
