<%@ page import ="java.sql.*" %>
<%
    String userid = request.getParameter("admin_username");   
    String pwd = request.getParameter("admin_password");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://rakshaadb.ccd5ejynxyym.us-east-1.rds.amazonaws.com:3306/rakshaadb","rravi", "sairam23");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from admin where admin_username='" + userid + "' and admin_password='" + pwd + "'");
    if (rs.next()) {
        session.setAttribute("user", userid); // the username will be stored in the session
        out.println("welcome " + userid);
        out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("successadmin.jsp");
    } else {
        out.println("Invalid password <a href='index.jsp'>try again</a>");
    }
%>