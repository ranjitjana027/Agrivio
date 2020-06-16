<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<c:set var="article_url_path" value="${pageContext.request.requestURI.substring(pageContext.request.requestURI.lastIndexOf('/')+1)}"/>
<c:catch var="exception">
  <c:set var="dbUri"  value="<%=new java.net.URI( System.getenv(\"DATABASE_URL\") ) %>"/>
  <sql:setDataSource
    var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />
  <sql:query dataSource="${connection}" var="farmerSet">
    select * from farmers;
  </sql:query>
  <sql:query dataSource="${connection}" var="expertSet">
    select * from experts;
  </sql:query>
</c:catch>

<c:if test="${not empty exception}" >
  ${exception.message}
</c:if>

<t:admin-wrapper>
  <jsp:attribute name="header">
    <title>View All Users</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/view_users.css">
  </jsp:attribute>
  <jsp:body>
  <div class="page-header">
    View All Users
  </div>
  <div class="row">
    <div class="column">
      <div class="table-header">
        Farmers
      </div>
      <div class="table">
        <table id="farmers">
          <thead>
            <th>Name</th>
            <th>Mobile</th>
            <th>Email</th>
            <th>Premium</th>
          </thead>
          <tbody>
            <c:forEach items="${farmerSet.rows}" var="i">
              <tr>
                <td>${i.fullname}</td>
                <td>${i.mobile}</td>
                <td>${i.email}</td>
                <td>${ i.premium ?"&#9989;":"&#10060;" }</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>

    </div>
    <div class="column">
      <div class="table-header">
        Experts
      </div>
      <div class="table">
        <table>
          <thead>
            <th>Name</th>
            <th>Mobile</th>
            <th>Email</th>
          </thead>
          <tbody>
          <c:forEach items="${expertSet.rows}" var="i">
            <tr>
              <td>${i.fullname}</td>
              <td>${i.mobile}</td>
              <td>${i.email}</td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </div>

  </div>
  </jsp:body>
</t:admin-wrapper>
