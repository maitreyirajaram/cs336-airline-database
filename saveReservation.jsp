<% 
com.cs336.pkg.ApplicationDB appdb = new com.cs336.pkg.ApplicationDB();
//use hidden values to get type of trip
String typeOfTrip = request.getParameter("typeOfTrip");
String flexible = request.getParameter("flexible");
int isOneWay = 0;
if (typeOfTrip.equals("One Way")){
	isOneWay = 1;
}
int isFlex = 0; 
if(flexible.equals("Flexible Dates")){
	isFlex = 1; 
}
int flightNum = Integer.parseInt(request.getParameter("flightNum"));
String classname = request.getParameter("class");
int cancelFee = 0; 
if (classname.equals("Business")){
	cancelFee = 100; 
}
float price = appdb.getFlightPrice(flightNum);
String userid = (String)session.getAttribute("userid");
int cid = appdb.getCid(userid); 

appdb.saveTicket(cid, flightNum, isOneWay,classname, isFlex, cancelFee, price);
%>


<title> Ticket Confirmation </title>

<p> Your Ticket Details: </p>
Flight Number: <%=flightNum %>
<br><%=classname %></br>
<p>Status: Booked</p> <%--change if waitlist --%> 