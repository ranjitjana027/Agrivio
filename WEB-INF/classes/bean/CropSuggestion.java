package bean;
import java.sql.*;
import org.json.simple.JSONArray;
import org.json.simple.JSONValue;
import org.json.simple.JSONObject;
/** compile with
  javac -cp WEB-INF\lib\json-simple-1.1.1.jar;WEB-INF\lib\postgresql-42.2.12.jre6.jar
  WEB-INF\classes\bean\CropSuggestion.java */
public class CropSuggestion implements java.io.Serializable {
    String soil_taxonomy;
    String soil_type;

    public void setSoil_taxonomy(String s)
    {
      this.soil_taxonomy=s;
    }
    public void setSoil_type(String s){
      this.soil_type=s;
    }
    public JSONArray getSuggestion(){
      Connection con = null;
      PreparedStatement st = null;
      ResultSet rs = null;
      JSONArray list=null;
        try {

            // Initialize the database
            new org.postgresql.Driver();
            java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

            String username = dbUri.getUserInfo().split(":")[0];
            String password = dbUri.getUserInfo().split(":")[1];
            String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

            con=DriverManager.getConnection(dbUrl, username, password);
            st=con.prepareStatement("select * from crop_info where id in ("+
              " select crop_id from soil_crop_mapping where soil_id in ("+
              " select id from usda_soil_info where lower(name) = ? ) ); ");
            st.setString(1,this.soil_taxonomy.toLowerCase() );
            rs=st.executeQuery();
            list=new JSONArray();
            while(rs.next()){
              JSONObject obj1=new JSONObject();
              obj1.put("id",rs.getInt("article_id"));
              obj1.put("name",rs.getString("name"));
              list.add(obj1);
            }
          }
        catch (Exception e){
          e.printStackTrace();
        }
        finally{
          if (rs != null) {
            try { rs.close(); } catch (SQLException e) { ; }
            rs = null;
          }
          if (st != null) {
            try { st.close(); } catch (SQLException e) { ; }
            st = null;
          }
          if (con != null) {
            try { con.close(); } catch (SQLException e) { ; }
            con = null;
          }
          return list;
        }

      //return new String[]{"rice","wheat","maize"};
    }
}
