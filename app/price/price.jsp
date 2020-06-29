<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<t:wrapper>
  <jsp:attribute name="header">
    <title>Crop Price - Real time price at different mandis</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/price/price.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/ads/ads.css">
  </jsp:attribute>
  <jsp:body>

          <div class="price-content">
            <div class="row">
              <div class="col-8">
                <div class="price-content-column">
                  <div class="price-header">
                    Crop Price at different kishan mandi
                  </div>
                  <div class="row">
                    <div class="col-6 col-sm-6 col-xs-12 select-location" >
                        <select id="state">
                            <option value="">Select State</option>
                        </select>
                    </div>
                    <div class="col-6 col-sm-6 col-xs-12 select-location" id="choose-district" hidden>
                      <select name="district" id="district">
                          <option value="">All Districts</option>

                      </select>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-6 col-sm-6 col-xs-12" style="padding:10px 0;">
                      <input type="search" name="filterby-crop" class="search" placeholder="Filter by Crop Name, Variety and Price">
                    </div>
                    <div class="col-6 col-sm-6 col-xs-12 arrival-date">
                      Last update: <span id="arrival-date">  </span>
                    </div>
                  </div>
                  <div class="district-wise-price">

                  </div>
                </div>

              </div>
              <div class="col-4">
                <div class="ad-section">
                  <p>Ads</p>
                  <div class="ads">
                    <c:catch var="exception">
                        <c:set var="dbUri"  value="<%=new java.net.URI( System.getenv(\"DATABASE_URL\") ) %>"/>
                        <sql:setDataSource
                          var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />

                        <sql:query dataSource="${connection}" var="result">
                          select * from ads where lower(target) like '%cropprice%' order by id limit 10;
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
          <script src="../../assets/js/price/price.js" charset="utf-8"></script>

  </jsp:body>
</t:wrapper>
