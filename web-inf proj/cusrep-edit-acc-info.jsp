<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%

	ApplicationDB db = new ApplicationDB();	
    //Class.forName("com.mysql.jdbc.Driver");
    Connection con = db.getConnection();	
    Statement st = con.createStatement();
    
    String userid = request.getParameter("username");   
    String pwd = request.getParameter("password1");
    
    
    ResultSet rs;
    rs = st.executeQuery("select * from account where userName='" + userid + "'");
    if (rs.next()) {	
    	session.setAttribute("user", userid); // the username will be stored in the session
        out.println("<a href='logout.jsp'>Log out</a>");

        String sql = "UPDATE account SET password = ? WHERE userName= ?";

        PreparedStatement ps = con.prepareStatement(sql);
        
        ps.setString(1, pwd);
		ps.setString(2, userid);
        ps.executeUpdate();
        response.sendRedirect("cusrep.jsp");
        
    } else {
        out.println("Invalid password <a href='HelloWorld.jsp'>try again</a>");
    }
    
    con.close();
%>