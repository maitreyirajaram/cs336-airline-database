<%@ page import ="java.sql.*" %>
<%
    String new_fn = request.getParameter("firstname");  
    String lastn = request.getParameter("lastname");  
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://rakshaadb.ccd5ejynxyym.us-east-1.rds.amazonaws.com:3306/rakshaadb","rravi", "sairam23");
    String query = "update employee set firstname=? where lastname=?";

    // create the mysql insert preparedstatement
    PreparedStatement preparedStmt = con.prepareStatement(query);
    preparedStmt.setString(1, new_fn);
	preparedStmt.setString(2, lastn);
    // execute the Preparedstatement
    preparedStmt.executeUpdate();
    response.sendRedirect("successadmin.jsp");
%>