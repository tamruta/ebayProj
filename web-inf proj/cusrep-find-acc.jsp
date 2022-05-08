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
String item = request.getParameter("auctionid");   
    
ResultSet rs;
rs = st.executeQuery("Select * from users");
if (rs.next() == true) {
    session.setAttribute("itemName", item); //delete?
    //response.sendRedirect("HelloWorld.jsp");
   // rs.first();
    %>
     <table border="2" cellpadding="5">
         <tr>
             <td>User ID</td>
            <td>Username</td>
             <td>Is Admin</td>
             <td>Is Customer Rep</td>
             
         </tr>
         <%
         rs.previous();
         while(rs.next()){%>
             <tr>
                 <td><%=rs.getInt("account_id")%></td>
                <td><%=rs.getString("username")%></td>
                 <td><%=rs.getBoolean("isAdmin")%></td>
                 <td><%=rs.getBoolean("isCusRes")%></td>			
             </tr>
         <%}%>
    </table>
    

    <br><br>

    
    <form action="cusrep-edit-acc-info.jsp" method="post">
        Username <input type="text" name="un"><br>
        Password <input type="text" name="pw"><br>
        New Username <input type="text" name="newun"><br>
        New Password <input type="text" name="newpw"><br>
        <label for="do-this">Action to perform</label>
        <select name="perform">
        <option value="del-acc">Delete Account</option>
        <option value="chn-pw">Change Password</option>
        <option value="chn-usn">Change Username</option>
        </select>
        <input type="submit">
    </form>

    
 <%
}else {
    out.println("Invalid Search <a href='cusrep-home.jsp'>Go Back</a>");
}
con.close();
%>
<a href="#" onclick="history.go(-1)">Go Back onclick</a>
<%
}
%>