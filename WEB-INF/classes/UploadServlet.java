import java.io.*;
import java.nio.file.*;
import javax.servlet.*;
import javax.servlet.http.*;

import javax.servlet.annotation.*;

@WebServlet("/upload")
@MultipartConfig
public class UploadServlet extends HttpServlet {
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String description = request.getParameter("description"); // Retrieves <input type="text" name="description">
    Part filePart = request.getPart("file"); // Retrieves <input type="file" name="file">
    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.

    // ... (do your job here)
    File uploads = new File(System.getenv("TOMCAT_IMG_UPLOAD_LOCATION")+"/articles");
    //File file = new File(uploads, "somefilename.ext");
    File file = File.createTempFile("somefilename-", ".ext", uploads);
    try (InputStream fileContent = filePart.getInputStream()) {
        Files.copy(fileContent, file.toPath(),StandardCopyOption.REPLACE_EXISTING);
    }
    catch(Exception e){e.printStackTrace();}
    response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		out.println(file.getName());
  }
}
