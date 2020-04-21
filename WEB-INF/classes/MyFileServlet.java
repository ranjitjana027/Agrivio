import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import javax.servlet.annotation.WebServlet;

public class  MyFileServlet extends HttpServlet{
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    String relativePath = getServletContext().getRealPath("");
    System.out.println("relativePath = " + relativePath);

    File downloadFile = new File(relativePath);
    FileInputStream inStream = new FileInputStream(downloadFile);


    // obtains ServletContext
    ServletContext context = getServletContext();

    String mimeType = context.getMimeType(relativePath);
    if (mimeType == null) {
        // set to binary type if MIME mapping not found
        mimeType = "application/octet-stream";
    }
    System.out.println("MIME type: " + mimeType);
    response.setContentType(mimeType);

    // obtains response's output stream
    OutputStream outStream = response.getOutputStream();

    byte[] buffer = new byte[4096];
    int bytesRead = -1;

    while ((bytesRead = inStream.read(buffer)) != -1) {
        outStream.write(buffer, 0, bytesRead);
    }

    inStream.close();
    outStream.close();
  }
}
