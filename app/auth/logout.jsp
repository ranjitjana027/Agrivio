<%
session.setAttribute("userid",null);
session.setAttribute("user",null);
session.setAttribute("mobile",null);
session.setAttribute("role",null);
response.sendRedirect(request.getContextPath()+"/index");
%>
