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
    

    int history_id = Integer.parseInt(request.getParameter("bidid"));   
    int seller_id = Integer.parseInt(request.getParameter("sellerid"));

    ResultSet rs;
    
    rs = st.executeQuery("Select * from viewHistory where history_id= '" + history_id + "' and seller_id ='" + seller_id + "'");
    if (rs.next()) {
    	rs.previous();
    	String sql = "delete from auction where auction_id = ? and seller_id = ?";

        PreparedStatement ps = con.prepareStatement(sql);
         
        ps.setInt(1, auction_id);
 		ps.setFloat(2, seller_id);
        ps.executeUpdate();
        out.println("Successful! <a href='cusrep-home.jsp'>Customer Rep Home</a>");
    }else {
        out.println("This bid does not exist! <a href='cusrep-home.jsp'>Go Back</a>");
    } 
    
    con.close();
%>			
  
<%
}
%>