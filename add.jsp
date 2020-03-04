<%

int a=0, b=0;
try{
	a=Integer.parseInt(request.getParameter("a"));
b=Integer.parseInt(request.getParameter("b"));
out.println(a+b);
}
catch(Exception e)
{
	out.println("Error: "+e);
}
out.println(session);



%>