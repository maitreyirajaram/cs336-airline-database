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
			Connection con = DriverManager.getConnection("jdbc:mysql://rakshaadb.ccd5ejynxyym.us-east-1.rds.amazonaws.com:3306/rakshaadb","rravi", "sairam23");
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			int entity = Integer.parseInt(request.getParameter("price"));
			String str = null;
			if (entity == 300){
				str = "SELECT f.flightNum, f.destinationdate, f.departuredate, f.price FROM  flight f WHERE f.price <= 300 ORDER by f.price";
			} else if (entity == 500)  {
				str = "SELECT f.flightNum, f.destinationdate, f.departuredate, f.price FROM  flight f WHERE f.price <= 500 ORDER by f.price";
			} else {
				str = "SELECT f.flightNum, f.destinationdate, f.departuredate, f.price FROM  flight f WHERE f.price >= 501 ORDER by f.price";
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
			out.print("Flight Number");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Destination Date");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Departure Date");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Price");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");

				out.print(result.getString("flightNum"));
				out.print("</td>");
				out.print("<td>");

				out.print(result.getString("destinationdate"));
				out.print("</td>");
				out.print("<td>");

				out.print(result.getString("departuredate"));
				out.print("</td>");
				out.print("<td>");

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