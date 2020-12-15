<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
	String groupid = request.getParameter("groupid");
    String memberid = request.getParameter("memberid");

	Connection myConn = null;
    CallableStatement cstmt = null;

	String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
	String user = "ST2015112135"; // 본인 아이디(ex.STxxxxxxxxxx)
	String passwd = "ST2015112135"; // 본인 패스워드(ex.STxxxxxxxxxx)
	String dbdriver = "oracle.jdbc.OracleDriver";
    String sMessage = "";

	try {
		Class.forName(dbdriver);
		myConn =  DriverManager.getConnection (dburl, user, passwd);
		cstmt = myConn.prepareCall("{call EXITGROUP(?, ?, ?)}");
        cstmt.setString(1, memberid);
        cstmt.setString(2, groupid);
        cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
        cstmt.execute();
        sMessage = cstmt.getString(3);
%>
    <script>
            alert("<%= sMessage%>");       
            location.href="mypage.jsp";
    </script>
<%        
	} catch(SQLException ex) {
		System.err.println("SQLException: " + ex.getMessage());	
	} finally {
		if (cstmt != null)   try { 	cstmt.close();  myConn.close(); }
		catch(SQLException ex) { }
	}
%>
