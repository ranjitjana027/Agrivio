<%
/*if(session.getAttribute("userid")==null){
  response.sendRedirect(request.getContextPath()+"/login?redirect=/calendar");
}
else if( session.getAttribute("role").equals("FARMER")){*/
%>


<jsp:include page="/app/template/layout.jsp">
  <jsp:param name="filename" value="../chat/chat_view.jsp"/>
  <jsp:param name="cssfile" value="/assets/css/chat2.0/chat.css" />
  <jsp:param name="title" value="Ask Expert" />
</jsp:include>


<%
/*}
else if(session.getAttribute("role").equals("ADMIN") || session.getAttribute("role").equals("EXPERT")){
  out.println("Coming Soon");
} else {
  out.println("Page doesn't exist");
}*/
%>
