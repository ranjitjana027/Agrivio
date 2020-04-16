
    <!--link rel="stylesheet" href="../../assets/css/admin/add_user.css"-->
      <div class="page-header">Add an Article </div>
        <form action="add_article.jsp" method="post">
          <% if(!request.getParameter("errormessage").equals("")){ %>
          <div class="errormessage">
            <span style="background-color: white; box-shadow: 2px 2px 10px 2px #000000; padding: 5px 15px; "> <%= request.getParameter("errormessage") %>.
            <span style="background-color: white; cursor:pointer;" onclick="this.parentNode.hidden=true;"> &#10007; </span></span>
          </div>
          <% } %>


            <div class="name">
                <div class="form-input">
                    <label for="name">Name of Crop</label>
                    <input type="text" placeholder="Crop" name="name" id="name" required>
                </div>
            </div>
            <!-- step1 -->
            <div class="overview">
                <header class="form-header">Overview</header>
                <div class="form-input">
                    <label for="cpa">Avg. Cost Per Acre ( Rs )</label>
                    <input type="number" placeholder="Avg. Cost" name="cpa" id="cpa" required>
                </div>
                <div class="form-input">
                    <label for="min_prod_time">Minimum Time for production ( weeks )</label>
                    <input type="number" name="min_prod_time" id="min_prod_time" placeholder="Minimum Time for Production" required>
                </div>
                <div class="form-input">
                    <label for="profit">How much Profitable</label>
                    <input type="text" name="profit" id="profit" placeholder="Profitability" required>
                </div>
                <!--div class="form-button">
                    <button type="button" id="btn-fwd-1">Next</button>
                </div-->
            </div>
            <!-- step2 -->
            <div class="requirements">
                <header class="form-header">Requirements</header>
                <div class="weather">

                    <div class="form-input">
                        <label for="min_temp">Minimum Temparature ( &deg;c )</label>
                        <input type="number" step="0.1" placeholder="Minimum Temparature" name="min_temp" id="min_temp" required>
                    </div>
                    <div class="form-input">
                        <label for="max_temp">Maximum Temparature ( &deg;c )</label>
                        <input type="number" step="0.1" name="max_temp" id="max_temp" placeholder="Maximum Temparature" required>
                    </div>
                    <div class="form-input">
                        <label for="humidity">Humidity ( &#37; )</label>
                        <input type="number"  step="0.1" name="humidity" id="humidity" placeholder="Humidity" required>
                    </div>
                    <div class="form-input">
                        <label for="rainfall">Rain Fall ( cms )</label>
                        <input type="number" step="0.1" name="rainfall" id="rainfall" placeholder="Rainfall" required>
                    </div>
                </div>
                <div class="form-input" >
                    <label for="soil">Soil</label>
                    <input type="text" name="soil" id="soil" placeholder="Type of Soil" required>
                </div>
                <div class="form-input">
                    <label for="land">Type of Land</label>
                    <input type="text" name="land" id="land" placeholder="Type of Land" required>
                </div>
                <div class="form-input">
                    <label for="season">Season</label>
                    <input type="text" name="season" id="season" placeholder="Season" required>
                </div>
                <!--div class="form-input">
                    <button type="button" id="btn-prev-2">Back</button>
                    <button type="button" id="btn-fwd-2">Next</button>
                </div-->
            </div>
            <!-- step3 -->
            <div class="content">
                <header class="form-header">Content</header>
                <div class="form-input">
                    <label for="soil_prep">Soil Preparation</label><br>
                    <textarea name="soil_prep" id="soil_prep" placeholder="How to prepare soil for cultivation"  rows="2" required></textarea>
                </div>
                <div class="form-input">
                    <label for="sowing">Sowing</label><br>
                    <textarea name="sowing" id="sowing" placeholder="How to sow seeds" rows="2" required></textarea>
                </div>
                <div class="form-input">
                    <label for="nurturing">Nurturing</label><br>
                    <textarea name="nurturing" id="nurturing" placeholder="How to nurture"  rows="2" required></textarea>
                </div>
                <div class="form-input">
                    <label for="production">Production/Harvesting</label><br>
                    <textarea name="production" id="production" placeholder="How to harvest"  rows="2" required></textarea>
                </div>
                <div class="form-input">
                    <label for="coolingoff">Cooling off</label><br>
                    <textarea name="coolingoff" id="coolingoff" placeholder="How to procees residuals"  rows="2" required></textarea>
                </div>
                <div class="form-input">
                    <label for="extra">Extra</label><br>
                    <textarea name="extra" id="extra" placeholder="Anything extra..." rows="2" ></textarea>
                </div>
                <!--div class="form-input">
                    <button type="button" id="btn-prev-3">Back</button>
                    <button type="button" id="btn-fwd-3">Next</button>
                </div-->
            </div>
            <!-- step4 -->
            <div class="conclusion">
                <label for="conclusion" class="form-header">Conclusion</label>
                <div class="form-input">
                    <input type="text" name="conclusion" placeholder="Conclusion" id="conclusion">
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
