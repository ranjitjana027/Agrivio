<html>
  <head>
    <title>Process Upload File</title>
  </head>
  <body>
    <%@page import="java.io.File"%>
    <%
      String fileUploadPath = application.getInitParameter("fileLocation");
      String fileName=  application.getInitParameter("fileName");
      for (Part part : request.getParts()) {
        part.write(fileUploadPath + File.separator + fileName);
      }
      request.setAttribute("message", fileName + " uploaded at "+ fileUploadPath + " successfully!");
      getServletContext().getRequestDispatcher("/response.jsp").forward(
      request, response);
    %>
  </body>
</html>
