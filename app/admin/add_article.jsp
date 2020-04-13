
<%@ page import="java.sql.*" %>
<%
String error_message="";
if(request.getMethod().equals("POST"))
{
    try{
        // Initialize the database 
        new org.postgresql.Driver();
        java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

        String username = dbUri.getUserInfo().split(":")[0];
        String password = dbUri.getUserInfo().split(":")[1];
        String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

        Connection con=DriverManager.getConnection(dbUrl, username, password);

        // prepared statement
        //PreparedStatement ps=con.prepareStatement("insert into weather_details(min_temp,max_temp,humidity,rainfall) values (?,?,?,?)");
        PreparedStatement ps=con.prepareStatement("insert into articles( name , cpa , min_prod_time , profit ,"+
                                                " min_temp , max_temp , humidity , rainfall , soil , land , season ,"+
                                                " soil_prep , sowing , nurturing , production , coolingoff ,extra , conclusion) "+
                                                "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
        ps.setString(1,request.getParameter("name"));
        ps.setDouble(2,Double.valueOf(request.getParameter("cpa")));
        ps.setDouble(3,Double.valueOf(request.getParameter("min_prod_time")));
        ps.setString(4,request.getParameter("profit"));
        ps.setDouble(5,Double.valueOf(request.getParameter("min_temp")));
        ps.setDouble(6,Double.valueOf(request.getParameter("max_temp")));
        ps.setDouble(7,Double.valueOf(request.getParameter("humidity")));
        ps.setDouble(8,Double.valueOf(request.getParameter("rainfall")));
        ps.setString(9,request.getParameter("soil"));
        ps.setString(10,request.getParameter("land"));
        ps.setString(11,request.getParameter("season"));
        ps.setString(12,request.getParameter("soil_prep"));
        ps.setString(13,request.getParameter("sowing"));
        ps.setString(14,request.getParameter("nurturing"));
        ps.setString(15,request.getParameter("production"));
        ps.setString(16,request.getParameter("coolingoff"));
        ps.setString(17,request.getParameter("extra"));
        ps.setString(18,request.getParameter("conclusion"));

        ps.executeUpdate();
    }
    catch(Exception e){
        e.printStackTrace();
        error_message="Error occured while adding the article.";
    }

    
}
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin | AgronomyCult</title>
</head>

<body>
        <div class="error-message">
        <%= error_message %>
        </div>
        <form method="post">
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