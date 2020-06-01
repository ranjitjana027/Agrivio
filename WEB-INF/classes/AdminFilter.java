/** Compile with javac -cp ../../../../lib/servlet-api.jar LoginFilter.java */
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebFilter;

@WebFilter(filterName="AdminFilter")
public class AdminFilter implements Filter {

  private FilterConfig config=null;

  public void init(FilterConfig config){
    this.config=config;
  }

  public void destroy(){
    config=null;
  }

  public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException , ServletException{
    HttpServletRequest request=(HttpServletRequest)req;
    HttpServletResponse response=(HttpServletResponse)res;
    HttpSession session=request.getSession(false);
    boolean isAdmin=((String)session.getAttribute("role")).equals("ADMIN");
    if(isAdmin){
      chain.doFilter(request,response);
    }
    else{
      response.sendRedirect(request.getContextPath() +"/index");
      System.out.println("permission denied");
    }

  }

}
