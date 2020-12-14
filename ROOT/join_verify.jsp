<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
	String groupid = request.getParameter("groupid");
	String session_id = (String)session.getAttribute("user");
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

	mySQL = "insert into fishy_membergroup values (" + session_id + "," + groupid + ", NULL, SYSDATE, 0)";

	try {
		int affectedRows = stmt.executeUpdate(mySQL);
%>
    <script>
        alert("참여 요청을 보냈습니다.");
    </script>
<%        
		response.sendRedirect(url);
	} catch (SQLException ex) {
		System.err.println("SQLException: " + ex.getMessage());
%>
    <script>
        alert("이미 참여 중인 그룹입니다.");
        location.href('join.jsp');
    </script>
<%
	}
	stmt.close();
	myConn.close();
%>
