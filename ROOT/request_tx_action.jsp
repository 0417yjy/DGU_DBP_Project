<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<html>
<head><title>Insert title here</title></head>
<body>
<%
    String session_id = (String)session.getAttribute("user");
	String groupid = request.getParameter("groups");
	String memberid = request.getParameter("members");
	String currencyid = request.getParameter("currencies");
	String amount = request.getParameter("amount");

    String startdate = request.getParameter("startdate");
    // String is_duedate_inserted = request.getParameter("is_duedate_inserted");
    String duedate = request.getParameter("duedate");

    // String is_desc_inserted = request.getParameter("is_desc_inserted");
    String desc = request.getParameter("desc");

	Connection myConn = null;  
	CallableStatement cstmt = null;  

	String dburl  = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
	String user="ST2015112135"; // 본인 아이디(ex.ST0000000000)
	String passwd="ST2015112135"; // 본인 패스워드(ex.ST0000000000)
	String dbdriver = "oracle.jdbc.driver.OracleDriver";    
    String sMessage = "";

	try {
		Class.forName(dbdriver);
		myConn =  DriverManager.getConnection (dburl, user, passwd);
		cstmt = myConn.prepareCall("{call INSERTTRANSACTION(?, ?, ?, ?, ?, ?, ?, ?, ?)}");
        cstmt.setString(1, session_id);
        cstmt.setString(2, memberid);
        cstmt.setString(3, startdate);
        cstmt.setString(4, duedate);
        cstmt.setString(5, desc);
        cstmt.setString(6, amount);
        cstmt.setString(7, currencyid);
        cstmt.setString(8, groupid);
        cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
        cstmt.execute();
        sMessage = cstmt.getString(9);
%>
        <script>
            alert("<%= sMessage%>");       
            location.href="request_tx.jsp";
        </script>
<%        
	} catch(SQLException ex) {
		System.err.println("SQLException: " + ex.getMessage());	
	} finally {
		if (cstmt != null)   try { 	cstmt.close();  myConn.close(); }
		catch(SQLException ex) { }
	}
%>
</body></html>
