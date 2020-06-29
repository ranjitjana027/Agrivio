<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<t:wrapper>
  <jsp:attribute name="header">
    <title>Ask Experts - All your queries in one place</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/chat2.0/chat.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/ads/ads.css">
  </jsp:attribute>
  <jsp:body>
    <div class="chat-content">

      <div class="row">
          <div class="col-8 col-sm-12 col-xs-12">
            <div class="chat-header">
              Ask Your Queries
            </div>
            <div class="chat">
                <div class="chat-room">

                </div>
                <div class="input-message">
                    <div class="row">
                      <div class="col-1 col-sm-1 col-xs-1">
    										<svg viewBox="0 0 40 40" class="pulse">
    											<circle id="outerCircle" cx="20" cy="25" />
    											<circle id="innerCircle" cx="20" cy="25" r="8" />
    										</svg>
                      </div>
                      <div class="col-9 col-sm-8 col-xs-7" style="padding:5px;">
                        <input type="number" id="userid" value="${sessionScope.userid}" readonly hidden />
                        <input type="number" id="room" value="${sessionScope.userid}"  readonly hidden />
                        <input type="text" class="chat-input" placeholder="Type here .." />
                      </div>
                      <div class="col-2 col-sm-3 col-xs-4">
                        <input type="submit" value="Send" class="submit" />
                      </div>
                    </div>
                </div>
            </div>
          </div>
          <div class="col-4 col-sm-12 col-xs-12">
            <!--<div class="chat-header">
              <hr class="desktop-hidden tablet-hidden">
              Frequenty Asked
            </div>
            <div class="faq">

                <div class="article">

                        <header>This is a question?</header>

                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the
                        industry's standard dummy text ever since the 1500s.</p>
                </div>
                <div class="article">

                        <header>This is an another question?</header>

                    <p>Lorem Ipsum is simply dummy text of the printing. It has survived not only five centuries, but also the leap
                        into electronic typesetting, remaining essentially unchanged.</p>
                </div>


            </div>-->
            <div class="ad-section">
              <p>Ads</p>
              <div class="ads">
                <c:catch var="exception">
                    <c:set var="dbUri"  value="<%=new java.net.URI( System.getenv(\"DATABASE_URL\") ) %>"/>
                    <sql:setDataSource
                      var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />

                    <sql:query dataSource="${connection}" var="result">
                      select * from ads where lower(target) like '%cropprice%' order by id limit 4;
                    </sql:query>
                </c:catch>
                <c:if test="${result.rowCount>0}">
                  <c:forEach items="${result.rows}" var="i">
                    ${i.code}
                  </c:forEach>
                </c:if>
              </div>
            </div>
          </div>
      </div>

    </div>
    <script src="${pageContext.request.contextPath}/assets/js/chat/chat.js" charset="utf-8"></script>

  </jsp:body>
</t:wrapper>
