
<%!int n = 1;%>
<%
for (int i = 0; i < 5; i++) {
out.println("Next integer: " + n++ + "<br>");
Thread.sleep(500);
}
%>