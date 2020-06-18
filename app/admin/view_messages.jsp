<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<c:set var="article_url_path" value="${pageContext.request.requestURI.substring(pageContext.request.requestURI.lastIndexOf('/')+1)}"/>
<c:catch var="exception">
  <c:set var="dbUri"  value="<%=new java.net.URI( System.getenv(\"DATABASE_URL\") ) %>"/>
  <sql:setDataSource
    var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />
  <sql:query dataSource="${connection}" var="messages">
    select * from messages order by m_time desc;
  </sql:query>
</c:catch>

<c:if test="${not empty exception}" >
  ${exception.message}
</c:if>

<t:admin-wrapper>
  <jsp:attribute name="header">
    <title>View Messages</title>
    <style media="screen">

    .message-card{
      margin: 2%;
      padding: 0.1px 10px;
      color: black;
      background-color:#fafafa;
      box-shadow: 0 2px 10px -3px white;
    }
    .mesages-text{
      padding: 2%;
    }
    .message-card .sender{
      text-align: right;
    }
    .sender .name{
      font-family: cursive,sans-serif;
    }
    </style>
  </jsp:attribute>
  <jsp:body>
  <h2 style="margin-left:2vw;">View All Messages</h2>
  <div class="messages">
    <!--<div class="message-card">
      <p class="message-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. </p>
      <p class="sender"><span class="name">Ranjit Jana </span><br>
        <small>ranjitjana@web.com</small> <br>
        120201-454-55 PM
      </p>
    </div>
    <div class="message-card">
      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. </p>
      <p class="sender"><span class="name">Ranjit Jana </span> <br>
        <small>ranjitjana@web.com</small> <br>
        120201-454-55 PM
      </p>
    </div>
    <div class="message-card">
      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. </p>
      <p class="sender"><span class="name">Ranjit Jana </span> <br>
        <small>ranjitjana@web.com</small> <br>
        120201-454-55 PM
      </p>
    </div>-->
    <c:forEach items="${messages.rows}" var="i">
      <div class="message-card">
        <p>${i.message}</p>
        <p class="sender"><span class="name">${i.name} </span> <br>
          <c:if test="${not empty i.email}">
            <small>${i.email}</small> <br>
          </c:if>
          <small><fmt:formatDate value="${i.m_time}"
            pattern="dd-MMM -''yy hh:mm a z" /></small>

        </p>
      </div>
    </c:forEach>
  </div>


  </jsp:body>
</t:admin-wrapper>
