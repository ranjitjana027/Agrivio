<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<c:catch var="exception">
  <c:set var="dbUri"  value="<%=new java.net.URI( System.getenv(\"DATABASE_URL\") ) %>"/>
  <sql:setDataSource
    var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />
  <sql:query dataSource="${connection}" var="result">
    select * from articles where lower(title) like ? or lower(keywords) like ?;
    <sql:param value="%${fn:toLowerCase(param.q)}%" />
    <sql:param value="%${fn:toLowerCase(param.q)}%" />
  </sql:query>
</c:catch>

<c:if test="${not empty exception}" >
  ${exception.message}
</c:if>
<c:set var="start" value="${ empty param.start ? 0:Integer.parseInt(param.start)}"/>
<t:wrapper>
  <jsp:attribute name="header">
    <title>Search Results - Agrivio</title>
    <style media="screen">
      .search-result{
        width: 95%;
        margin: auto;
        min-height:200px;
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
        padding: 0;
        margin: 0;
        display: -webkit-box;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 2;
        overflow: hidden;
        text-overflow: ellipsis;
        max-height: 2.3rem;
        line-height: 1.15rem;
      }
      .link{
        margin: 2px 0;
        font-size: 15px;
        font-weight:500;
        color: #024c45;
        overflow-wrap: anywhere;
      }
      .search-text{
        font-weight:normal;
      }
      .pages{
        margin:2%;
      }
      .pages a{
        text-decoration: none;
        display: inline-block;
        padding:5px 12px;
        text-align: center;
        color: black;
        font-size: 1.25rem;
        font-family:serif;
      }
      .pages a:hover{
        background-color: #cacaca;
      }
      .pages a.active {
        background-color: #1e9a5f;
        color: white;
      }
      @media(max-width:767px){
        .search-result-article{
          padding: 10px 10px;
          box-shadow: 1px 3px 8px -5px;
          margin: 15px 0;
        }
      }


    </style>
  </jsp:attribute>
  <jsp:body>
    <div class="row">
      <div class="col-8">
        <div class="search-result">
          <h2>Search Results <span class="search-text">( "${param.q}" )</span></h2>
          <c:forEach var="i" items="${result.rows}" begin="${start}" end="${start+9}">
            <div class="search-result-article">
              <h3>
                <a href="${pageContext.request.contextPath}/latest/article/${fn:toLowerCase(i.type)}s/${i.url_path}">${i.title}</a>
              </h3>
              <div class="link">
                ${header['host']}${pageContext.request.contextPath}/latest/article/${fn:toLowerCase(i.type)}s/${i.url_path}
              </div>
              <p>${i.snippet}</p>
            </div>
          </c:forEach>
        </div>
        <c:if test="${result.rowCount>10}">
          <div class="pages">
            <a href="${pageContext.request.contextPath}/search?q=${param.q}">&laquo;</a>
            <c:set var="totalPages" value="${(result.rowCount-(result.rowCount mod 10))/10}" />
            <c:forEach var="pn" begin="1" end="${result.rowCount < ( totalPages * 10 ) ? totalPages : ( totalPages + 1 ) }">
            <c:set var="qstring" value="&&start=${(pn-1)*10}" />
              <a href="${pageContext.request.contextPath}/search?q=${param.q}${pn>1?qstring:''}" class="${(pn-1)*10==start?'active':''}">${pn}</a>
            </c:forEach>
            <a href="${pageContext.request.contextPath}/search?q=${param.q}${qstring}">&raquo;</a>
          </div>
        </c:if>

      </div>
    </div>
  </jsp:body>
</t:wrapper>
