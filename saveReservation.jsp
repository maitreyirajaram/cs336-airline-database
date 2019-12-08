<%
com.cs336.pkg.ApplicationDB appdb = new com.cs336.pkg.ApplicationDB();
appdb.saveTicket(1, Integer.parseInt(request.getParameter("flightNum")));
out.println("ticket confirmed");

%>