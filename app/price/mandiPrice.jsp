<link rel="stylesheet" href="../../assets/css/price/mandiPrice.css">
  <script src="../../assets/js/price/mandiPrice.js" charset="utf-8"></script>
      <div class="grid-content">
        <div style="display:inline-block; width: 250px;color:#93e4c1;">
            <label for="state">State: </label>
            <select id="state">
                <option value="">Select State</option>
            </select>
        </div>
        <div id="choose-district" hidden style="display:inline-block; color:#93e4c1;">
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
