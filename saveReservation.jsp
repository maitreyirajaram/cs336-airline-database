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
appdb.saveTicket(1, flightNum, isOneWay,classname, isFlex, cancelFee, price);
%>

<head>
<title> Ticket Confirmation </title>
</head>

<% 
out.println("Your ticket details:");
out.println("Flight Number:" + flightNum);
out.println(classname);
out.println("Status: Booked"); //change if waitlist
%>
