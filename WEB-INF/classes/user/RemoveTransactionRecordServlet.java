/* Run this file with: javac -cp ../../../../lib/servlet-api.jar;../lib/postgresql-42.2.12.jre6.jar; user\RemoveTransactionRecordServlet.java*/

package user;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import javax.servlet.annotation.WebServlet;
import java.sql.*;

@WebServlet("/balance-sheet/remove")
public class RemoveTransactionRecordServlet extends HttpServlet{
  public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException{
    HttpSession session=request.getSession();
    PrintWriter out=response.getWriter();
    String errorMessage=null, message=null;
    if(session.getAttribute("userid")==null){
            errorMessage="You are not logged in";
    }

    else if( request.getParameter("id")!=null && !request.getParameter("id").equals("")){
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
            st = con.prepareStatement("update balance_sheet set removed=true where id=? and user_id=?");
            st.setInt(1, Integer.parseInt(request.getParameter("id")));
            st.setInt(2, Integer.parseInt((String)session.getAttribute("userid")));
            st.executeUpdate();
            message="Event is removed";
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
    
    
    response.sendRedirect("/latest/balance-sheet");
    out.close();
  }
}