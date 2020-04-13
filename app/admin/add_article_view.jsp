<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin | AgronomyCult</title>
</head>

<body>
        <div class="error-message">
        <%=request.getParameter("errormessage") %>
        </div>
        <form action="add_article.jsp" method="post">
            <div class="name">
                <div>
                    <label for="">Name</label>
                    <input type="text" name="name" id="" required>
                </div>
            </div>
            <!-- step1 -->
            <div class="overview">
                <h4>Overview</h4>
                <div>
                    <label for="">Cost Per Are</label>
                    <input type="number" name="cpa" id="" required>
                </div>
                <div>
                    <label for="">Minimum time for production</label>
                    <input type="number" name="min_prod_time" id="" required>
                </div>
                <div>
                    <label for="">How much Profitable</label>
                    <input type="number" name="profit" id="" required>
                </div>
                <div>
                    <button>Next</button>
                </div>
            </div>
            <!-- step2 -->
            <div class="requirements">
                <h4>Requirements</h4>
                <div class="weather">
                    
                    <div>
                        <label for="">Minimum Temparature</label>
                        <input type="number" name="min_temp" id="" required>
                    </div>
                    <div>
                        <label for="">Maximum Temparature</label>
                        <input type="number" name="max_temp" id="" required>
                    </div>
                    <div>
                        <label for="">Humidity</label>
                        <input type="number" name="humidity" id="" required>
                    </div>
                    <div>
                        <label for="">Rain Fall</label>
                        <input type="number" name="rainfall" id="" required>
                    </div>
                </div>
                <div>
                    <label for="">Soil</label>
                    <input type="text" name="soil" id="" required>
                </div>
                <div>
                    <label for="">Type of Land</label>
                    <input type="text" name="land" id="" required>
                </div>
                <div>
                    <label for="">Season</label>
                    <input type="text" name="season" id="" required>
                </div>
                <div>
                    <button>Next</button>
                </div>
            </div>
            <!-- step3 -->
            <div class="content">
                <h4>Content</h4>
                <div>
                    <label for="">Soil Preparation</label><br>
                    <textarea name="soil_prep" id="" cols="30" rows="2" required></textarea>
                </div>
                <div>
                    <label for="">Sowing</label><br>
                    <textarea name="sowing" id="" cols="30" rows="2" required></textarea>
                </div>
                <div>
                    <label for="">Nurturing</label><br>
                    <textarea name="nurturing" id="" cols="30" rows="2" required></textarea>
                </div>
                <div>
                    <label for="">Production/Harvesting</label><br>
                    <textarea name="production" id="" cols="30" rows="2" required></textarea>
                </div>
                <div>
                    <label for="">Cooling off</label><br>
                    <textarea name="coolingoff" id="" cols="30" rows="2" required></textarea>
                </div>
                <div>
                    <label for="">Extra</label><br>
                    <textarea name="extra" id="" cols="30" rows="2" ></textarea>
                </div>
                <div>
                    <button>Next</button>
                </div>
            </div>
            <!-- step4 -->
            <div >
                <h4>Conclusion</h4>
                <div>
                    <input type="text" name="conclusion" id="">
                </div>
                <div>
                    <input type="submit" value="Save">
                </div>
            </div>
            
        </form>
        </body>
        
        </html>