<%@page import="java.io.*,java.nio.file.*" %>
<%
if(request.getMethod().equals("POST")){
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


  out.println(file.getName());
}
%>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>File Upload Example using Servlet 3.0 API  </title>
  </head>
  <body>
    <form method="post"
        enctype="multipart/form-data">
        Select File to Upload:<input type="file" name="file"><br>
        <input type="submit" value="Upload">
    </form>
  </body>
</html>
