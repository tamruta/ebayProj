<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>	
	<%

	ApplicationDB db = new ApplicationDB();	
    //Class.forName("com.mysql.jdbc.Driver");
    Connection con = db.getConnection();	
    Statement st = con.createStatement(,);
    
    String userid = request.getParameter("userID");   
    String pwd = request.getParameter("password");
    
    
    ResultSet rs;
    rs = st.executeQuery("select * from users where userID='" + userid + "' and password='" + pwd + "'");
    if (rs.next()) {
        session.setAttribute("userID", userid); // the username will be stored in the session
        String isAdmin = rs.getBoolean("isAdmin");
        String isCusRes = rs.getBoolean("isCusRes");
        out.println("welcome " + userid);
        out.println("<a href='logout.jsp'>Log out</a>");
        if(!isAdmin && !isCusRes) response.sendRedirect("welcome.jsp");
        else if(isAdmin) response.sendRedirect("admin.jsp");
        else response.sendRedirect("custrep.jsp");
    } else {
        out.println("Invalid password <a href='Users.jsp'>try again</a>");
    }
    
    con.close();
%>
	
