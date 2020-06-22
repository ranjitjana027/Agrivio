<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<c:choose>
  <c:when test="${pageContext.request.method=='POST' and not empty param.lastId and not empty sessionScope.userid}">
    <c:catch var="exception">
      <c:set var="dbUri"  value="<%=new java.net.URI(System.getenv(\"DATABASE_URL\")) %>"/>

      <sql:setDataSource
        var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />
      <sql:update dataSource="${connection}" var="count">
        update notifications set read=true where  user_id= ? and n_time<= ( select n_time from notifications where id=?)
        <sql:param value="${Integer.parseInt(sessionScope.userid)}" />
        <sql:param value="${Integer.parseInt(param.lastId)}" />
      </sql:update>
      <c:if test="${count>0}">
        { "success": true }
      </c:if>
    </c:catch>
    <c:if test="${not empty exception}">
        { "success": false, "message":"update failed." }
    </c:if>
  </c:when>
  <c:otherwise>
    { "success": false, "message":"update failed." }
  </c:otherwise>
</c:choose>
