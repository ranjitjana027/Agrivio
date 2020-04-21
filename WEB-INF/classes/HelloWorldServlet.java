import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class HelloWorldServlet extends HttpServlet 
{
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
	{
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<html><head><title>Hello World Servlet</title></head>");
		out.println("<html><head><title>Hello World Servlet</title></head>");
		out.println("<body>");
		out.println("<h1>Hello World!</h1>");

		String login=request.getParameter("login");
		String password=request.getParameter("password");
		out.println("<h2> login:" + login + "<br>password:" + password + "</h2>");
		out.println("</body></html>");
		out.close();
	}
}
