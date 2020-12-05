<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<html>
<head><title>Insert title here</title></head>
<body>
<%
	String memberid = request.getParameter("memberid");
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String email = request.getParameter("email");

	Connection myConn = null;  
	Statement stmt = null;  
	String mySQL = "";

	String dburl  = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
	String user="ST2015112135"; // 본인 아이디(ex.ST0000000000)
	String passwd="ST2015112135"; // 본인 패스워드(ex.ST0000000000)
	String dbdriver = "oracle.jdbc.driver.OracleDriver";    

	try {
		Class.forName(dbdriver);
		myConn =  DriverManager.getConnection (dburl, user, passwd);
		stmt = myConn.createStatement();	
	} catch(SQLException ex) {
		System.err.println("SQLException: " + ex.getMessage());
	}
    mySQL = "update fishy_member ";
	mySQL = mySQL + " set password ='" + password + "' , " ;
	mySQL = mySQL + " email ='" + email + "' where memberid='" + memberid + "' "; 

	try {		
		stmt.executeQuery(mySQL);  
%>

<script>
	alert("멤버 정보가 수정되었습니다.");       
	location.href="mypage.jsp";
</script>
<%    
	} catch(SQLException ex) {
		String sMessage;
		if (ex.getErrorCode() == 20002) sMessage="암호는 4자리 이상이어야 합니다";
		else if (ex.getErrorCode() == 20003) sMessage="암호에 공란은 입력되지 않습니다.";
		else sMessage=ex.getMessage();	
%>
<script>
	//alert("<%= sMessage %>");    
	console.log(sMessage);
	location.href = "mypage.jsp";
</script>
<%	
	} finally {
		if (stmt != null)   try { 	stmt.close();  myConn.close(); }
		catch(SQLException ex) { }
	}
%>
</body></html>
