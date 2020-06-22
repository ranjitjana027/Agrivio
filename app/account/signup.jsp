<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<c:choose>
  <c:when test="${sessionScope.userid!=null}">
    <c:redirect url="/latest/article" />
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
		        <sql:setDataSource
              var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />
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
                <sql:update dataSource="${connection}">
                  insert into notifications(content,user_id) values ( ?,?), ( ?,?);
                  <sql:param value="<b>Hello!</b> A warm welcome from our side. For any issues kindly contact us." />
                  <sql:param value="${Integer.parseInt(sessionScope.userid)}" />

                  <sql:param value="Thanks for choosing us." />
                  <sql:param value="${Integer.parseInt(sessionScope.userid)}" />

                </sql:update>
								<c:redirect url="/latest/article" />
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
    </c:if>
  </c:otherwise>
</c:choose>
<!DOCTYPE html>
<html>

<head>
 	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Create an Account | Agrivio</title>
  <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.svg">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/lib/form-label-animation.css">
  <script src="${pageContext.request.contextPath}/assets/js/lib/form-label-animation.js" ></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/account/signup.css">
</head>

<body>
  <div class="row">
    <div class="col-6">
      <div class="wrap">
        <div class="header">
          <!--img class="logo" src="${pageContext.request.contextPath}/assets/img/logo-sm.png" alt="agrivio Logo"-->
          <a href="${pageContext.request.contextPath}/index">
            <img class="website-name" src="${pageContext.request.contextPath}/assets/img/agrivio-1.png"  alt="agrivio" >
          </a>
          <div class="message">
            Create an account
          </div>
        </div>
        <form class="form" method="post">
          <div class="row form-item">
            <div class="col-6 col-sm-6 col-xs-6">
              <div class="form-input">
                <label for="firstname">First Name</label>
      					<input type="text" id="firstname" name="firstname" placeholder="First Name"
      						required>
      				</div>
            </div>
            <div class="col-6 col-sm-6 col-xs-6">
              <div class="form-input">
                <label for="lastname">Last Name</label>
                <input type="text" id="lastname" name="lastname" placeholder="Last Name" required>
              </div>
            </div>
          </div>
    			<div class="form-item">
            <div class="form-input">
              <label for="mobile">Ten digit Mobile No</label>
              <input class="input-field " type="text" name="mobile" id="mobile" placeholder="10 digit mobile number" pattern="^[6-9]\d{9}$" minlength="10" maxlength="10">
            </div>
          </div>
          <div class="form-item">
            <div class="form-input">
              <label for="email">Email(Optional)</label>
              <input class="input-field " type="email" id="email" name="email" placeholder="Email" optional>
            </div>
          </div>
        <div class="form-item">
          <div class="form-input">
            <label for="password">Password</label>
            <input class="input-field" type="password" id="password" name="password" placeholder="Password"   minlength="8" maxlength="20" required >
            <small>Password must be 6-20 character in length.</small>
          </div>
        </div>
  				<div class="form-item">
            <div class="form-input">
              <label for="re_password">Confirm Password</label>
  						<input class="input-field" type="password" id='re_password' name="re_password" placeholder="Confirm Password" minlength="8" maxlength="20"  required>
            </div>
  					<small id="password_message" class="alert"></small>
  				</div>

  				<div class="form-item">
            <input type="checkbox" id="tnc" required ><label for="tnc"> I accept the terms & conditions.</label>
  				</div>
  				<div class="form-item">
            <div class="form-btn">
              <button type="submit" class="signup-btn" style="width: 100%;" onclick="return checkPassword();">Sign Up</button>
            </div>
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
          <div class="form-item login-redirect">
            <span>
              Already have an account? <a href="${pageContext.request.contextPath}/login"> Login here.</a>
            </span>
          </div>
  			</form>
      </div>
    </div>
    <div class="col-6 mobile-hidden tablet-hidden">
      <div class="image">
          <img class="farmer" src="${pageContext.request.contextPath}/assets/img/account/farmer.png" alt="farmer">
      </div>
    </div>
  </div>
  <script>
    document.querySelector("#password").addEventListener("keyup",chkPwd);
    document.querySelector("#re_password").addEventListener("keyup",chkPwd);

    function checkPassword()
  			{
  				let p1=document.querySelector("#password").value;
  				let p2=document.querySelector("#re_password").value;

  				if(p1!=p2)
  				{
  					document.querySelector('#password_message').innerHTML="Passwords did not match.";
  					return false;
  				}
  		 }

   function chkPwd()
		 {
			 let p1=document.querySelector("#password").value;
			 let p2=document.querySelector("#re_password").value;

			 if(p1!=="" && p2!="" && p1!=p2)
			 {
				 document.querySelector('#password_message').innerText="Passwords did not match.";


			 }
			 else
			 document.querySelector('#password_message').innerText="";
		}
  </script>
</body>

</html>
