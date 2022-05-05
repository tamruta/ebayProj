<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.Date.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
ApplicationDB db = new ApplicationDB();
//Class.forName("com.mysql.jdbc.Driver");
Connection con = db.getConnection();
Statement st = con.createStatement();


String tempmodel_number = request.getParameter("model_number");
int model_number = Integer.parseInt(tempmodel_number);

String item_type = request.getParameter("itemType");
item_type = item_type.toLowerCase();

String temps_price = request.getParameter("startingPrice");
float starting_price = Float.parseFloat(temps_price);

String tempm_price = request.getParameter("minPrice");
float min_price = Float.parseFloat(tempm_price);

String tempmax_price = request.getParameter("maxPrice");
float max_price = Float.parseFloat(tempmax_price);

String item_desc = request.getParameter("description");

String year = request.getParameter("year");

String temp_BidIncre = request.getParameter("bidIncrement");
float bid_increment = Float.parseFloat(temp_BidIncre);

String closing_date = request.getParameter("closing_date");

//java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//java.util.Date endDateTime = format.parse(strEndDateTime);

ResultSet rs = st.executeQuery("SELECT MAX(id_number) as ID from electronic_item");
rs.next();

int id_number = rs.getInt("ID") + 1;
String create_item = "INSERT INTO electronic_item(id_number, Model_Number, item_type, year, Dimensions, Memory, Specifications)" + 
"VALUES (?,?,?,?,null,null,null )";
PreparedStatement item_ps = con.prepareStatement(create_item);

item_ps.setInt(1, id_number);
item_ps.setInt(2, model_number);
item_ps.setString(3, item_type);
item_ps.setString(4, year);

item_ps.executeUpdate();

if(item_type.equalsIgnoreCase("Monitor")){
    String update = "UPDATE electronic_item SET Dimensions = ? WHERE id_number = ?";
    PreparedStatement item_ps_update1 = con.prepareStatement(update);
    item_ps_update1.setString(1, item_desc);
    item_ps_update1.setInt(2, id_number);
    item_ps_update1.executeUpdate();
}else if(item_type.equalsIgnoreCase("Laptop")){
    String update = "UPDATE electronic_item SET Memory = ? WHERE id_number = ?";
    PreparedStatement item_ps_update2 = con.prepareStatement(update);
    item_ps_update2.setString(1, item_desc);
    item_ps_update2.setInt(2, id_number);
    item_ps_update2.executeUpdate();
}else{
	String update = "UPDATE electronic_item SET Specifications = ? WHERE id_number = ?";
	PreparedStatement item_ps_update3 = con.prepareStatement(update);
	item_ps_update3.setString(1, item_desc);
    item_ps_update3.setInt(2, id_number);
    item_ps_update3.executeUpdate();
}
ResultSet rs2 = st.executeQuery("SELECT MAX(Auction_ID) as ID from auction");
rs2.next();
int auction_id = rs2.getInt("ID") + 1;
String create_auction = "INSERT INTO auction(Auction_ID, closing_date, current_bid, starting_price, min_price, increment, max_bid, buyer_id, seller_id, item_ID)" + 
"VALUES (?,?,null,?,?,?,?,null,?,?)";
PreparedStatement auction_ps = con.prepareStatement(create_auction);

auction_ps.setInt(1, auction_id);
auction_ps.setString(2, closing_date);
auction_ps.setFloat(3, starting_price);
auction_ps.setFloat(4, min_price);
auction_ps.setFloat(5, bid_increment);
auction_ps.setFloat(6, max_price);
auction_ps.setString(7, (String)session.getAttribute("userID"));
auction_ps.setInt(8, id_number);

auction_ps.executeUpdate();


%>
Succesfully added item for sale, 
<%=session.getAttribute("userID")%>
<a href='success.jsp'>Go Back</a>

<%
con.close();
%>
<style> .footer {
    position: fixed;
    left: 0;
    bottom: 0;
    width: 100%;
    font-size: 30;
    background-color: rgb(212, 166, 166);
    color: white;
    text-align: center;
  } </style>
  
  <div class="footer"> 
    <p><a href='welcome.jsp'>Home</a><a href='logout.jsp'>Log out</a></p>
  </div>