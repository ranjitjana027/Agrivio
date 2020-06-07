/** Compile with javac -cp ../../../../lib/servlet-api.jar LoginFilter.java */
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebFilter;

@WebFilter(filterName="LoginFilter")
public class LoginFilter implements Filter {

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
    boolean loginRequest = request.getRequestURI().equals( request.getContextPath() + "/login");
    boolean loggedIn= session!=null && session.getAttribute("userid")!=null;
    if(loggedIn || loginRequest){
      chain.doFilter(request,response);
    }
    else{
      String url=request.getContextPath() + "/login?redirect="+request.getServletPath();
      url=(request.getQueryString()==null)?url:(url+"?"+request.getQueryString());
      response.sendRedirect(url);
    }
    System.out.println("Login Filtered");

  }

}
