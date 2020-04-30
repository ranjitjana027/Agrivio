
      <div class="price-content">
        <div class="select-location">
            <label for="state">State: </label>
            <select id="state">
                <option value="">Select State</option>
            </select>
        </div>
        <div class="select-location" id="choose-district" hidden>
            <label for="district">District:</label>
            <select name="district" id="district">
                <option value="">Select District</option>

            </select>
        </div>

        <table id="price-list" hidden>
            <tr>
              <th>District</th>
              <th>Market</th>
              <th>Commodity</th>
              <th>Variety</th>
              <th>Arrival Date</th>
              <th>Max Price</th>
              <th>Min Price</th>
              <th>Modal Price</th>
            </tr>
        </table>
      </div>

    <script src="${pageContext.request.contextPath}/assets/js/price/mandiPrice.js" charset="utf-8"></script>
