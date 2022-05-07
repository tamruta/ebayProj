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

<br><br>

<a href="#" onclick="history.go(-1)">Go Back onclick</a>


<%
    ApplicationDB db = new ApplicationDB();	
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyElectronics", "root", "Rootuser!1");	
    Statement st = con.createStatement();   
    
    int q_id = Integer.parseInt(request.getParameter("qid"));  
    String answer = request.getParameter("answer");
    
    ResultSet rs, rs2;
    
    rs = st.executeQuery("Select * from qna where q_id= '" + q_id + "'");
    if (rs.next()) {
    	rs.previous();
    	String sql = "update qna set answer = ?, cusrep_id = ? where q_id = ?";

        PreparedStatement ps = con.prepareStatement(sql);
        
        String username = session.getAttribute("userID").toString();
        int cusrep_id = 0;
        rs2 = st.executeQuery("Select * from users where username = '"+username+"'");

        if(rs2.next())
          cusrep_id = rs2.getInt("account_id");

        ps.setString(1, answer);
 		    ps.setInt(2, cusrep_id);
        ps.setInt(3, q_id);
        ps.executeUpdate();

        out.println("Success!<a href='cusrep-home.jsp'>Go Back</a>");
            
    }else{
          out.println("This question does not exist! <a href='cusrep-home.jsp'>Go Back</a>");
      }   
    con.close();
    
     




}
%>