<%@tag pageEncoding="UTF-8" %>
<%@ attribute name="var" required="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<sql:setDataSource var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}"/>
<c:set var="uv" value="${var}" />
<c:set var="con" value="${connection}" />
<% jspContext.setAttribute("${var}","${connection}"); %>
