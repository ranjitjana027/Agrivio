<%
session.setAttribute("userid",null);
session.setAttribute("user",null);
session.setAttribute("mobile",null);
session.setAttribute("role",null);
session.setAttribute("dp",null);
response.sendRedirect(request.getContextPath()+"/index");
%>
