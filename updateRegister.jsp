<%@ page import ="java.sql.*" %>
<%
    String firstname = request.getParameter("first_name");
    String lastname = request.getParameter("last_name");
    String userid = request.getParameter("username");
    String pwd = request.getParameter("password");

        
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbname","root", "dbpass");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeUpdate("update users set firstname='" + firstname + "',lastname='" + lastname + ",username='" + userid + "',password='" + pwd + "'");
    session.setAttribute("user", userid); // the username will be stored in the session
    out.println("welcome " + userid);
    out.println("<a href='logout.jsp'>Log out</a>");
    esponse.sendRedirect("success.jsp");
%>