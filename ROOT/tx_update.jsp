<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
	String action = request.getParameter("action");
	String txid = request.getParameter("txid");
    String url = request.getHeader("referer");

	Connection myConn = null;
	Statement stmt = null;
	String mySQL = null;

	String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
	String user = "ST2015112135"; // 본인 아이디(ex.STxxxxxxxxxx)
	String passwd = "ST2015112135"; // 본인 패스워드(ex.STxxxxxxxxxx)
	String dbdriver = "oracle.jdbc.OracleDriver";

	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl, user, passwd);
	stmt = myConn.createStatement();

	mySQL = "update fishy_transaction set status='" + action + "' where transactionid=" + txid;

	int affectedRows = stmt.executeUpdate(mySQL);

	if (affectedRows != 0) {
		response.sendRedirect(url);
	} else {
%>

<script>
	alert("Failed to update transaction.");
	location.href = <%= url %>;
</script>
<%
	}
	stmt.close();
	myConn.close();
%>
