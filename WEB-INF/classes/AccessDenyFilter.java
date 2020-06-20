/** Compile with javac -cp ../../../../lib/servlet-api.jar AccessDenyFilter.java */
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebFilter;

@WebFilter(filterName="AccessDenyFilter")
public class AccessDenyFilter implements Filter {

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
    String url=request.getContextPath() + "/error/access-denied";
    
    response.sendRedirect(url);

  }

}
