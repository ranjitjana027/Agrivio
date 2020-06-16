<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<c:if test="${pageContext.request.method=='POST'}">

  <c:catch var="exception">
    <c:choose>
      <c:when test="${param.password1 != param.password2}">
        <c:set var="errormessage" >
          Passwords didn&apos;t match
        </c:set>
      </c:when>
      <c:when test="${fn:length(param.mobile) !=10}">
        <c:set var="errormessage" >
          Contact number should be of ten digits
        </c:set>
      </c:when>
      <c:otherwise>
        <c:set var="dbUri"  value="<%=new java.net.URI( System.getenv(\"DATABASE_URL\") ) %>"/>
        <sql:setDataSource
          var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />

        <c:choose>
          <c:when test="${param.role=='FARMER'}">
            <sql:update dataSource="${connection}" var="count">
              insert into users(firstname, lastname, mobile, email, password,premium) values(?,?,?,?,?,?);
              <sql:param value="${param.firstname}" />
              <sql:param value="${param.lastname}" />
              <sql:param value="${param.mobile}" />
              <sql:param value="${param.email}" />
              <sql:param value="${param.password2}" />
              <sql:param value="${param.premium}" />
            </sql:update>
          </c:when>
          <c:otherwise>
            <sql:update dataSource="${connection}" var="count">
              insert into users(firstname, lastname, mobile, email, password,role) values(?,?,?,?,?,?);
              <sql:param value="${param.firstname}" />
              <sql:param value="${param.lastname}" />
              <sql:param value="${param.mobile}" />
              <sql:param value="${param.email}" />
              <sql:param value="${param.password2}" />
              <sql:param value="${param.role}"/>
            </sql:update>
          </c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="${count>0}">
            <c:set var="message" >
              Successfully updated user details
            </c:set>
          </c:when>
          <c:otherwise>
            <c:set var="errormessage" >
              Encounter error while updating user details
            </c:set>
          </c:otherwise>
        </c:choose>
      </c:otherwise>
    </c:choose>
  </c:catch>

  <c:if test="${not empty exception}" >
    ${exception.message}
  </c:if>
</c:if>

<t:admin-wrapper>
  <jsp:attribute name="header">
    <title>Add an User</title>
    <link rel="stylesheet" href='${pageContext.request.contextPath}/assets/css/admin/add_user.css'>
    <script src="${pageContext.request.contextPath}/assets/js/lib/custom-select.js" charset="utf-8"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/lib/custom-select.css">
  </jsp:attribute>
  <jsp:body>

    <div class="page-header">Add a user </div>
    <form  method="post">
      <c:if test="${ not empty errormessage}">
        <div class="errormessage">
          <span style="background-color: white; box-shadow: 2px 2px 10px 2px #000000; padding: 5px 15px; "> ${errormessage}.
          <span style="background-color: white; cursor:pointer;" onclick="this.parentNode.hidden=true;"> &#10007; </span></span>
        </div>
      </c:if>
      <c:if test="${ not empty message}">
        <div class="errormessage" style="color:green;">
          <span style="background-color: white; box-shadow: 2px 2px 10px 2px #000000; padding: 5px 15px; ">  ${message}.
          <span style="background-color: white; cursor:pointer;" onclick="this.parentNode.hidden=true;"> &#10004; </span></span>
        </div>
      </c:if>


      <div class="">
        <div class="form-input">
          <label for="firstname">First Name</label>
          <input type="text" name="firstname" value="" required placeholder="First Name" id="firstname">
        </div>
        <div class="form-input">
          <label for="lastname">Last Name</label>
          <input type="text" name="lastname" required placeholder="Last Name" value="" id="lastname">
        </div>
      </div>
      <div class="">
        <div class="form-input">
          <label for="mobile">Mobile No</label>
          <input type="text" pattern="\d*" name="mobile"  placeholder="10 Digit Mobile No" id="mobile" minlength=10 maxlength="10" required value="">
        </div>
        <div class="form-input">
          <label for="email">Email (Optional)</label>
          <input type="email" name="email" value="" placeholder="abc@example.com" id="email">
        </div>

      </div>
      <div class="">
        <div class="form-input">
          <label for="password1">Password</label>
          <input type="password" name="password1" id="password1"  required minlength="8" maxlength="20" placeholder="Password" value="">
        </div>
        <div class="form-input">
          <label for="password2">Confirm Password</label>
          <input type="password" name="password2" id="password2" required minlength="8" maxlength="20" placeholder="Confirm Password" value="">
        </div>
      </div>
      <div class="">
        <div class="form-input">
          <label for="role">Role</label>
          <select class="form-select" name="role" id='role' required>
            <option value="" disabled>Choose an option</option>
            <option value="ADMIN">Admin</option>
            <option value="EXPERT">Expert</option>
            <option value="FARMER">Farmer</option>
          </select>
        </div>
        <div class="form-input">
          <label for="premium">Premium User</label>
          <select class="form-select" name="premium" id="premium">
            <option value="" disabled>Choose an option</option>
            <option value="true">Yes</option>
            <option value="No">No</option>
          </select>

        </div>
      </div>
        <div class="form-button">
          <div class="btn-left">
            <button type="reset" >Reset</button>
          </div>

            <div class="btn-right">
              <button type="submit">Save</button>
            </div>
        </div>


    </form>
    <script src="${pageContext.request.contextPath}/assets/js/admin/add_user.js" charset="utf-8"></script>

  </jsp:body>
</t:admin-wrapper>
