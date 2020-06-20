<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<t:wrapper>
  <jsp:attribute name="header">
    <title>Crop Price</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/price/price.css">
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
                      Last update: <span id="arrival-date">13/05/2020 </span>
                    </div>
                  </div>
                  <div class="district-wise-price">

                  </div>
                </div>

              </div>
            </div>
          </div>
          <script src="../../assets/js/price/price.js" charset="utf-8"></script>

  </jsp:body>
</t:wrapper>
