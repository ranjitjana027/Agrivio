<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<c:choose>
  <c:when test="${sessionScope.userid!=null}">
    <c:redirect url="/dashboard" />
  </c:when>
  <c:otherwise>
    <c:catch var="exception" >
      <c:if test="${pageContext.request.method=='POST'}">
				<c:choose>
					<c:when test="${param.password != param.re_password}">
						<c:set var="errorMessage" >
							Passwords didn&apos;t match.
						</c:set>
					</c:when>
					<c:when test="${fn:length(param.mobile) !=10}">
						<c:set var="errorMessage" >
							Contact number should be of ten digits.
						</c:set>
					</c:when>
					<c:otherwise>
						<c:set var="dbUri"  value="<%=new java.net.URI(System.getenv(\"DATABASE_URL\")) %>"/>
		        <sql:setDataSource var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />
		        <sql:update dataSource="${connection}" var="count">
		          insert into users(firstname, lastname, mobile, email, password) values(?,?,?,?,?);
		          <sql:param value="${param.firstname}" />
		          <sql:param value="${param.lastname}" />
							<sql:param value="${param.mobile}" />
							<sql:param value="${param.email}" />
							<sql:param value="${param.password}" />
		        </sql:update>
		        <c:choose>
		          <c:when test="${count>0}">
								<sql:query dataSource="${connection}" var="result">
									SELECT * FROM users where mobile=?  and password=?;
									<sql:param value="${param.mobile}" />
									<sql:param value="${param.password}"/>
								</sql:query>
		            <c:set var="userid" scope="session">${result.rows[0].id}</c:set>
		            <c:set var="user" value="${result.rows[0].firstname} ${result.rows[0].lastname}" scope="session" />
		            <c:set var="mobile" value="${result.rows[0].mobile}" scope="session" />
		            <c:set var="role" value="${result.rows[0].role}" scope="session" />
		            <sql:update dataSource="${connection}" >
		              update users set last_login=? where id=?;
		              <sql:param value="<%=new java.sql.Timestamp(new java.util.Date().getTime())%>" />
		              <sql:param value="${result.rows[0].id}" />
		            </sql:update>
								<c:redirect url="/dashboard" />
		          </c:when>
		          <c:otherwise>
		            <c:set var="errorMessage" >
		              Unable create your account. Make sure you don't have any account with this mobile no.
		            </c:set>
		          </c:otherwise>
		        </c:choose>
					</c:otherwise>
				</c:choose>
      </c:if>
    </c:catch>
    <c:if test="${not empty exception}">
      <c:set var="errorMessage" value="Something went wrong"/>
			${exception.message}
    </c:if>
  </c:otherwise>
</c:choose>

<!DOCTYPE html>
<html>

<head>
 	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Sign Up</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/auth/signup.css">
	<style>


	</style>
</head>

<body>
	<header>
		<div class="nav">
			<h1 class="wesite-name">Kishan Bandhu</h1>
		</div>
	</header>

	<div class="container">
		<div class="image">
			<img class="farmer" src="${pageContext.request.contextPath}/assets/img/auth/farmer.png" alt="farmer">
		</div>
		<div class="wrap">
			<h1 class="wrap-header">Create an Account</h1>

			<form class="form" action="" method="post">

				<div class="form-item">
					<input class="input-field" type="text" id="firstname" name="firstname" placeholder="First Name"
						required>
					<input class="input-field" type="text" id="lastname" name="lastname" placeholder="Last Name"
						required>
				</div>
				<div class="form-item">
					<input class="input-field " type="text" name="mobile" id="mobile" placeholder="10 digit mobile number" pattern="^[6-9]\d{9}$">
					<input class="input-field " type="email" id="email" name="email" placeholder="Email" optional>
				</div>
				<div>
					<div class="form-item">
						<input class="input-field" type="password" id="password" name="password" placeholder="Password"
							minlength="8" pattern=^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$
							required>


						<input class="input-field" type="password" id='re_password' name="re_password"
							placeholder="Confirm Password" minlength="8"
							pattern=^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$ required>
					</div>
					<small id="password_message"></small>
					<div class="password-rule">
						<small>
							Password must be 8-20 characters long, contain letters, numbers and special characters, and
							must not contain spaces or emoji.
						</small>
					</div>
				</div>

				<div>
					<h4><input type="checkbox" required style="width:auto;">I accept the terms & conditions.</h4>
				</div>
				<button type="submit" class="signup" style="width: 100%;">Sign Up</button>

				<c:if test="${not empty errorMessage}" >
							<div class="form-item error-box">
									<span>
											<span>&#9888;</span>
											${errorMessage}
											<c:remove var="errorMessage" />
									</span>
							</div>
				</c:if>
			</form>

			<footer class="wrap-footer">
				<span>Already Registered? <a href="${pageContext.request.contextPath}/login">Login Now! </a></span>
			</footer>
		</div>
	</div>
</body>

</html>
