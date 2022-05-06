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

	int item_id = Integer.parseInt(request.getParameter("id"));   

    ResultSet rs; 
    
    rs = st.executeQuery("Select * from auction where item_id = '" + item_id + "'");
	if (rs.next()) {
    	
    	String sql = "delete from auction where item_id = ?";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, item_id);
        ps.executeUpdate();
        
        
    }else {
        out.println("This item does not exist! <a href='cusrep-home.jsp'>Go Back</a>");
    }
    
    
    rs = st.executeQuery("Select * from electronic_item where item_id= '" + item_id + "'");
    if (rs.next()) {
    	
    	String sql = "delete from electronic_item where item_id = ?";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, item_id);
        ps.executeUpdate();
        
        out.println("Success! <a href='cusrep-home.jsp'>Go Back</a>");
        
    }else {
        out.println("This item does not exist! <a href='cusrep-home.jsp'>Go Back</a>");
    }

      
    
    con.close();
%>
  
<%
}
%>
 				