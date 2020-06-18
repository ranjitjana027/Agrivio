<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<c:if test="${pageContext.request.method=='POST' and not empty param.firstname and not empty param.lastname and not empty param.message }">
  <c:catch var="exception">
    <c:set var="dbUri"  value="<%=new java.net.URI(System.getenv(\"DATABASE_URL\")) %>"/>

    <sql:setDataSource
      var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />

      <sql:update dataSource="${connection}" var="count">
        insert into messages(name,email,message) values (?,?,?);
        <sql:param value="${param.firstname} ${param.lastname}"/>
        <sql:param value="${param.email}" />
        <sql:param value="${param.message}" />
      </sql:update>

  </c:catch>
  <c:if test="${not empty exception}">
    <c:set var="errorMessage" value="Something went wrong"/>
    ${exception.message}
  </c:if>
</c:if>
<t:wrapper>
  <jsp:attribute name="header">
    <title>Contact Us</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/lib/grid.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/lib/form-label-animation.css">
    <script src="${pageContext.request.contextPath}/assets/js/lib/form-label-animation.js" charset="utf-8"></script>
    <style media="screen">
      .contact-us h1{
        text-align: center;
      }
      .contact-us textarea{
        width: 100%;
        padding: 5px;
        border-radius: 5px;
        outline: none;
        border: solid 1px;
        font-family: inherit;
        font-size: inherit;
      }
      .contact-us textarea:focus{
        box-shadow: 0 0 15px -10px;
      }
      .contact-us button{
        background: rgba(50,150,100,1);
        color: white;
        border: none;
        outline: none;
        padding: 10px 20px;
        font-size: 1em;
        border-radius: 5px;
        cursor: pointer;
      }
      .contact-us button:hover{
        background-color: #0c904e;
      }
      .contact-us .row{
        margin: 0 !important;
      }
      #map{
        min-height:300px;
        margin: 5vw 5px;
      }
    </style>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <script src="https://api.mapbox.com/mapbox-gl-js/v1.11.0/mapbox-gl.js"></script>
    <link href="https://api.mapbox.com/mapbox-gl-js/v1.11.0/mapbox-gl.css" rel="stylesheet" />
    <script type="text/javascript">
      function validateForm(form){
        form.reportValidity();
      }
      function onSubmit(token) {

        if(document.querySelector("#contact-form").checkValidity())
            document.getElementById("contact-form").submit();

       }
    </script>
  </jsp:attribute>
  <jsp:body>
    <div class="contact-us">
      <div class="row">
        <div class="col-7">
          <h1>Leave A Message For Us</h1>
          <form id="contact-form" method="post" onsubmit="validateForm(this)">
            <div class="row">
              <div class="col-6 col-sm-6">
                <div class="form-input">
                  <label for="firstname">First Name *</label>
                  <input type="text" name="firstname" id="firstname" required>
                </div>
              </div>
              <div class="col-6 col-sm-6">
                <div class="form-input">
                  <label for="lastname">Last Name *</label>
                  <input type="text" name="lastname" id="lastname" required>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-12 col-sm-12">
                <div class="form-input">
                  <label for="email">Email</label>
                  <input type="text" name="email" id="email">
                </div>
              </div>
            </div>
            <div class="row">
              <div class="form-input">
                <textarea name="message" rows="8" placeholder="Your message" minlength="100" required></textarea>
              </div>
            </div>
            <div class="form-input">
              <button class="g-recaptcha" data-sitekey="6LdyXKYZAAAAAPJYCiBivcT_yJM2kup-ZoGy1CWq" data-callback='onSubmit' type="submit">Send Message</button>
            </div>
          </form>
        </div>
        <div class="col-5">
          <div id="map">

          </div>
          <script>
            	mapboxgl.accessToken = 'pk.eyJ1IjoicmFuaml0amFuYTAyNyIsImEiOiJjazlkMmV1OXQwN2wzM2xrMm5rdzNoNHd4In0._yq6R2svhu-71s0WerS7dA';
             var map = new mapboxgl.Map({
             container: 'map',
             style: 'mapbox://styles/mapbox/streets-v11',
             center: [88.412359,22.5605212],
             zoom: 8
             });

              var marker = new mapboxgl.Marker().setLngLat([88.4131,22.5610212]).addTo(map);
          </script>
        </div>
      </div>
    </div>
  </jsp:body>
</t:wrapper>
