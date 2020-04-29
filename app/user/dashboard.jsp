<%
if(session.getAttribute("userid")==null){
  response.sendRedirect(request.getContextPath()+"/login?redirect=/dashboard");
}
else if( session.getAttribute("role").equals("FARMER")){
%>


<jsp:include page="/app/user/layout.jsp">
  <jsp:param name="filename" value="../user/dashboard_view.jsp" />
  <jsp:param name="title" value="Welcome" />
</jsp:include>


<%
}
else if(session.getAttribute("role").equals("ADMIN") || session.getAttribute("role").equals("EXPERT")){
  response.sendRedirect(request.getContextPath()+"/admin/dashboard");
} else {
  out.println("Page doesn't exist");
}
%>
