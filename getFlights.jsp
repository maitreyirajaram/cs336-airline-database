<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Make Flight Reservations</title>
</head>
<body>
<h1> Make Flight Reservations - Pick Flight</h1>
<%

ApplicationDB appdb = new com.cs336.pkg.ApplicationDB();
String originAirport = request.getParameter("origin");
String destAirport = request.getParameter("dest");
String startDate = request.getParameter("startDate");
String destDate = request.getParameter("destDate"); 
String typeOfTrip = request.getParameter("typeOfTrip");
String isFlexible = request.getParameter("flexible");

Map<Integer, Float> airports = appdb.getFlights(originAirport, destAirport, startDate);

%>
<form action="saveReservation.jsp" method="POST">

<p>Select Departure Flight from <%=originAirport%> to <%=destAirport %>:</p>
<select name="flightNum">
 <% 
	
 for (Map.Entry mapElement : airports.entrySet()) {
%>
  <option value="<%=mapElement.getKey()%>">Flight Number: <%=mapElement.getKey()%></option>
<% } %>
</select>

<select name = "class">
<option value = "economy">Economy</option>
<option value = "business">Business</option>
<option value = "first">First Class</option>
</select>



<action="saveReservation.jsp" method="GET">


<%--hidden value one way/round trip passed from first page --%>
<input type="hidden" id=typeOfTrip name="typeOfTrip" value="typeOfTrip">
<%--hidden value flex tix passed from first page --%>
<input type="hidden" id=flexible name="flexible" value="flexible">



<p>
<input type="submit" value="Submit"/>
</p>

</form>
  

</body>
</html>