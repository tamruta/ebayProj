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
Welcome <%=session.getAttribute("userID")%> 

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
    
    String s_bidPrice = request.getParameter("bidPrice");
    String s_id = request.getParameter("id");   
    String s_date = request.getParameter("date");
    
    int id = Integer.parseInt(s_id);
    float bidPrice = Float.parseFloat(s_bidPrice);
    

    ResultSet rs;
    
    rs = st.executeQuery("Select * from bidHistory where item_ID= '" + id + "' and bidPrice ='" + bidPrice + "' and datePosted ='" + s_date + "'");
    if (rs.next()) {
    	rs.previous();
    	String sql = "delete from bidhistory where item_ID = ? and bidPrice = ? and datePosted = ?";

        PreparedStatement ps = con.prepareStatement(sql);
         
        ps.setInt(1, id);
 		ps.setFloat(2, bidPrice);
 		ps.setString(3, s_date);
        ps.executeUpdate();
        
         
        
    }else {
        out.println("This bid does not exist! <a href='cusrep.jsp'>Go Back</a>");
    }
    
    rs = st.executeQuery("Select max(bidPrice) from bidhistory where item_id = '" + id + "'");
    if(rs.next()){
    	float newPrice = rs.getFloat("max(bidPrice)");
    	String sql = "UPDATE item SET current_price = ? WHERE item_ID = ?";
    	
    	PreparedStatement ps = con.prepareStatement(sql);
    	ps.setFloat(1, newPrice);
    	ps.setInt(2, id);
    	ps.executeUpdate();  
    	
    }else{
		String sql = "UPDATE item SET current_price = 0 WHERE item_ID = ?";
    	PreparedStatement ps = con.prepareStatement(sql);
    	ps.setInt(1, id);
    	ps.executeUpdate();  
    }
    
    response.sendRedirect("cusrep.jsp");
      
    
    con.close();
%>			
  
<%
}
%>