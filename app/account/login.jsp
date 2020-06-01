<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<c:choose>
  <c:when test="${sessionScope.userid!=null}">
    <c:choose >
        <c:when test="${ not empty param.redirect}">
          <c:redirect url="${param.redirect}" />
        </c:when>
        <c:otherwise>
          <c:redirect url="/dashboard" />
        </c:otherwise>
    </c:choose>
  </c:when>
  <c:otherwise>
    <c:catch var="exception" >
      <c:if test="${pageContext.request.method=='POST'}">
        <c:set var="dbUri"  value="<%=new java.net.URI(System.getenv(\"DATABASE_URL\")) %>"/>

        <sql:setDataSource var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />
        <sql:query dataSource="${connection}" var="result">
          SELECT * FROM users where mobile=?  and password=?;
          <sql:param value="${param.mobile}" />
          <sql:param value="${param.password}"/>
        </sql:query>

        <c:choose>
          <c:when test="${result.rowCount>0}">
            <c:set var="userid" scope="session">${result.rows[0].id}</c:set>
            <c:set var="user" value="${result.rows[0].firstname} ${result.rows[0].lastname}" scope="session" />
            <c:set var="mobile" value="${result.rows[0].mobile}" scope="session" />
            <c:set var="role" value="${result.rows[0].role}" scope="session" />
            <sql:update dataSource="${connection}" >
              update users set last_login=? where id=?;
              <sql:param value="<%=new java.sql.Timestamp(new java.util.Date().getTime())%>" />
              <sql:param value="${result.rows[0].id}" />
            </sql:update>
            <c:choose >
                <c:when test="${ not empty param.redirect}">
                  <c:redirect url="${param.redirect}" />
                </c:when>
                <c:otherwise>
                  <c:redirect url="/dashboard" />
                </c:otherwise>
            </c:choose>
          </c:when>
          <c:otherwise>
            <c:set var="errorMessage" >
              Invalid Username/Password
            </c:set>
          </c:otherwise>
        </c:choose>
      </c:if>
    </c:catch>
    <c:if test="${not empty exception}">
      <c:set var="errorMessage" value="Something went wrong"/>
    </c:if>
  </c:otherwise>
</c:choose>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Login Page</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.svg">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/lib/form-label-animation.css">
    <script src="${pageContext.request.contextPath}/assets/js/lib/form-label-animation.js" ></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/account/login.css">
</head>
<body>
    <div class="row">
      <div class="col-6 ">
        <div class="wrap">
          <div class="header">
            <img class="logo" src="${pageContext.request.contextPath}/assets/img/logo-sm.png" alt="AgriCulture Logo">
            <img class="website-name" src="${pageContext.request.contextPath}/assets/img/agrivio-1.png"  alt="AgriCulture" >

          </div>
          <form method="post"  class="form">

            <div class="form-input">
                <label for="fi1">Mobile</label>
                <input type="text" name="mobile" placeholder="Mobile" id="fi1" required>
            </div>
            <div class="form-input">
                <label for="fi2">Password</label>
                <input type="password" name="password" placeholder="Password" id="fi2" required>
            </div>
            <div class="form-btn">
                <input class="login-btn" type="submit" value="Login" id="fi3">
            </div>
            <c:if test="${not empty errorMessage}" >
                  <div class="form-item error-box">
                      <span>
                          <span>&#9888;</span>
                          ${errorMessage}
                          <c:remove var="errorMessage" />
                      </span>
                  </div>
            </c:if>
            <div>
                <span>By continuing, you are agree to our
                    <a href="${pageContext.request.contextPath}/app/auth/terms&condition.html">Conditions of Use</a>
                    and <a href="${pageContext.request.contextPath}/app/auth/terms&condition.html">Privacy Notice</a>.</span>

            </div>
            <div class="signup-redirect">
              <p>
                Don&apos;t Have any account? <a href="${pageContext.request.contextPath}/signup"> Create one.</a>
              </p>
            </div>
          </form>

        </div>

      </div>
      <div class="col-6 mobile-hidden tablet-hidden">
        <div class="image">
            <img class="farmer" src="${pageContext.request.contextPath}/assets/img/auth/farmer.png" alt="farmer">
        </div>
      </div>
    </div>

</body>

</html>
