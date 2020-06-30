/* Run this file with: javac -cp ../../../../lib/servlet-api.jar;../lib/postgresql-42.2.12.jre6.jar; profile\AddDPServlet.java*/

package profile;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import javax.servlet.annotation.WebServlet;
import java.sql.*;

@WebServlet("/profile/add-dp")
public class AddDPServlet extends HttpServlet{
  public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException{
    HttpSession session=request.getSession();
    PrintWriter out=response.getWriter();
    String errorMessage=null, message=null;
    if(session.getAttribute("userid")==null){
            errorMessage="You are not logged in";
    }

    else if( request.getParameter("dp")!=null && !request.getParameter("dp").equals("")){
      Connection con = null;
      PreparedStatement st = null; 
        try {
            // Initializea the database
            new org.postgresql.Driver();
            java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));
            String username = dbUri.getUserInfo().split(":")[0];
            String password = dbUri.getUserInfo().split(":")[1];
            String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";
            con=DriverManager.getConnection(dbUrl, username, password);
            //Statement stmt = con.createStatement();
            st = con.prepareStatement("update users set dp=? where id=? ");
            st.setString(1, request.getParameter("dp"));
            st.setInt(2, Integer.parseInt((String)session.getAttribute("userid")));
            st.executeUpdate();
            message="Added DP successfully";
        }
        catch (Exception e) {
			errorMessage="Something went wrong";
            e.printStackTrace();
        }
        finally {
          if (st != null) {
            try { st.close(); } catch (SQLException e) { ; }
            st = null;
          }
          if (con != null) {
            try { con.close(); } catch (SQLException e) { ; }
            con = null;
          }
        }
    }
    
    
    response.sendRedirect("/latest/profile");
    out.close();
  }
}