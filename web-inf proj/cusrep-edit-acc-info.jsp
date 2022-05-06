<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
    if ((session.getAttribute("userID") == null)) {
%>
You are not logged in<br/>
<a href="Users.jsp">Please Login</a>
<%} else {
%>
Welcome <%=session.getAttribute("userID")%> <br><br>

<style> .footer {
      position: fixed;
      left: 0;
      bottom: 0;
      width: 100%;
      font-size: 30;
      background-color: rgb(211, 208, 208);
      color: white;
      text-align: center;
    } </style>
    
    <div class="footer"> 
      <p><a href='welcome.jsp'>Home</a><br><a href='logout.jsp'>Log out</a></p>
    </div>
<%
    ApplicationDB db = new ApplicationDB();	
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyElectronics", "root", "Rootuser!1");	
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
        out.println("Invalid username <a href='cusrep-home.jsp'>try again</a>");
    }
    
    con.close();
%>
  
<%
}
%>