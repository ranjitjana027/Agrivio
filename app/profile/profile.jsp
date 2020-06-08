<%
/*if(session.getAttribute("userid")==null){
  response.sendRedirect(request.getContextPath()+"/login?redirect=/calendar");
}
else if( session.getAttribute("role").equals("FARMER")){*/
%>


<jsp:include page="/app/template/layout.jsp">
  <jsp:param name="filename" value="<%=\"../profile/profile_view.jsp?id=\"+request.getParameter(\"id\") %>" />
  <jsp:param name="cssfile" value="/assets/css/profile/profile.css" />
  <jsp:param name="title" value="My Account" />
</jsp:include>


<%
/*}
else if(session.getAttribute("role").equals("ADMIN") || session.getAttribute("role").equals("EXPERT")){
  out.println("Coming Soon");
} else {
  out.println("Page doesn't exist");
}*/
%>
