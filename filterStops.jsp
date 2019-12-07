<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			String entity = request.getParameter("stops");
			if (entity != "2+"){
				String str = "SELECT s.scheduleid, s.destinationdate, s.departuredate,f.price FROM schedule s JOIN flight f ON f.flightNum WHERE f.stops == " + entity;
			} else {
				String str = "SELECT s.scheduleid, s.destinationdate, s.departuredate,f.price  FROM schedule s JOIN flight f ON f.flightNum WHERE f.stops >= 2";
			}
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("scheduleid");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("destinationdate");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("departuredate");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("price");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current schedyle id:
				out.print(result.getString("scheduleid"));
				out.print("</td>");
				out.print("<td>");
				//Print out current destination date:
				out.print(result.getString("destinationdate"));
				out.print("</td>");
				out.print("<td>");
				//Print out current departure date
				out.print(result.getString("departuredate"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(result.getString("price"));
				out.print("</td>");
				out.print("</tr>");

			}
			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>

</body>
</html>