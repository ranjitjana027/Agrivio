<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<c:catch var="exception">
  <c:set var="dbUri"  value="<%=new java.net.URI(System.getenv(\"DATABASE_URL\")) %>"/>

  <sql:setDataSource
    var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />
  <sql:query dataSource="${connection}" var="result">
    select * from users where id=?
    <sql:param value="${Integer.parseInt(sessionScope.userid)}" />
  </sql:query>
</c:catch>
<c:if test="${not empty exception}">
  <c:set var="errormessage" value="Something went wrong"/>

</c:if>


<t:wrapper>
  <jsp:attribute name="header">
    <title>My Account</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/profile/profile.css">
  </jsp:attribute>
  <jsp:body>
    <div class="profile-header">
      User Profile
    </div>
    <c:if test="${result.rowCount>0}">
      <div class="row">
        <div class="col-4 col-sm-4 col-xs-12">
          <div class="profile-overview">
            <div class="profile-pic">
              <img src="${pageContext.request.contextPath}/assets/img/user.png" alt="Profile Pic">
            </div>
            <div class="username">
              ${result.rows[0].firstname} ${result.rows[0].lastname}
            </div>
            <div class="premium-sticker" style="">
              ${ result.rows[0].premium ?"Premium":"Basic" }
            </div>
          </div>
          <div class="account-action mobile-hidden">
            <div class="">
              <a href="#">Change Password</a>
            </div>
            <div class="">
              <a href="#">Change Mobile No</a>
            </div>
          </div>
        </div>
        <div class="col-8 col-sm-8 col-xs-12">
          <div class="profile-details">

            <div class="personal-info">
              <header>
                Account Details
              </header>
              <div class="row  profile-data">
                <div class="col-4 col-sm-4 col-xs-4">
                  Name
                </div>
                <div class="col-8 col-sm-8 col-xs-8">
                  ${result.rows[0].firstname} ${result.rows[0].lastname}
                </div>

              </div>
              <div class="row  profile-data">
                <div class="col-4 col-sm-4 col-xs-4">
                  Mobile
                </div>
                <div class="col-8 col-sm-8 col-xs-8">
                  ${result.rows[0].mobile}
                </div>
              </div>
              <div class="row profile-data">
                <div class="col-4 col-sm-4 col-xs-4">
                  Email
                </div>
                <div class="col-8 col-sm-8 col-xs-8">
                  ${result.rows[0].email}
                </div>
              </div>
              <div class="row  profile-data">
                <div class="col-4 col-sm-4 col-xs-4">
                  Password
                </div>
                <div class="col-8 col-sm-8 col-xs-8">
                  XXXXXXXX
                </div>

              </div>
              <div class="row profile-data">
                <div class="col-4 col-sm-4 col-xs-4">
                  Premium
                </div>
                <div class="col-8 col-sm-8 col-xs-8">
                  ${ result.rows[0].premium?"Subscribed":"Not Subscribed" }
                </div>
              </div>
            </div>
          </div>
          <div class="account-action desktop-hidden tablet-hidden">
            <div class="">
              <a href="#">Change Password</a>
            </div>
            <div class="">
              <a href="#">Change Mobile No</a>
            </div>
          </div>
        </div>
      </div>
    </c:if>
  </jsp:body>
</t:wrapper>
