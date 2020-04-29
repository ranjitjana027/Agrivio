package bean;
import java.sql.*;
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
    public String[] getSuggestion(){
      return new String[]{this.soil_taxonomy,"NULL"};
    }
}
