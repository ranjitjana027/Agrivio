<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<c:set var="dbUri"  value="<%=new java.net.URI(System.getenv(\"DATABASE_URL\")) %>"/>
<sql:setDataSource var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}"/>

<sql:query dataSource="${connection}" var="result">
  select * from chat_messages where room='${param.room}';
</sql:query>
{
  "messages":[
  <c:forEach var="i" items="${result.rows}" end="0" >
    {
      "sender": ${i.sender}, "sender_name": "${i.sender_name}", "content": "${i.content}", "status":false, "date":"${i["c_time"]}"
    }
  </c:forEach>
  <c:forEach var="i" items="${result.rows}" begin="1" >
    ,{
      "sender": ${i.sender}, "sender_name": "${i.sender_name}", "content": "${i.content}", "status":false, "date":"${i["c_time"]}"
    }
  </c:forEach>

]}
