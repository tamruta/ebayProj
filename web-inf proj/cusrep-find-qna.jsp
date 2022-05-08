<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
  if (session.getAttribute("userID") == null) {
%>
    You are not logged in!
    <script type="text/javascript">
    setTimeout(()=> { window.location.href="Users.jsp"; }, 1000);  
    </script>
<%
  }else {
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
    Statement st2 = con.createStatement();    
    Statement st3 = con.createStatement();    
    
    
    ResultSet rs, rs2, rs3;
    String q_id = request.getParameter("q_id");   

    rs = st.executeQuery("Select * from qna");

    if (rs.next() == true) {
%>
      <table border="2" cellpadding="5">
        <tr>
          <td>Question Number</td>
          <td>Question</td>
          <td>Answer</td>
          <td>Posted by</td>
          <td>Answered by</td>
        </tr>
<%
      rs.previous();
      while(rs.next()){
           int user_id = rs.getInt("user_id");
           int cusrep_id = rs.getInt("cusrep_id");
           String username = "";
           String cusrep = "";

           rs2 = st2.executeQuery("Select * from users where account_id = "+user_id);
           rs3 = st3.executeQuery("Select * from users where account_id = "+cusrep_id);
           if(rs2.next())
             username = rs2.getString("username");
           if(rs3.next())
             cusrep = rs3.getString("username");
           else 
             cusrep = "";
%>
          <tr>
             <td><%=rs.getInt("q_id")%></td>
             <td><%=rs.getString("question")%></td>
             <td><%=rs.getString("answer")%></td>
             <td><%=username%></td>
             <td><%=cusrep%></td>
          </tr>
      <%}%>
      </table>

      <br><br>

      Reply To Question
      <form action = 'cusrep-qna.jsp', method="post">
        Question Number </td><td><input type="text" name="qid" required><br>
        Answer </td><td><input type="text" name="answer" required><br>
        <input type="submit" value="Reply">
      </form><br>


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