<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
    String session_id = (String)session.getAttribute("user");
	String groupid = request.getParameter("groupid");
    String memberid = request.getParameter("memberid");
    String action = request.getParameter("action");

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

    if(action.equals("accept")) {
	    mySQL = "update fishy_membergroup set permissionlevel=1 where groupid=" + groupid + "and memberid=" + memberid; // 일반 회원으로 승격
    } else if(action.equals("reject")) {
        mySQL = "delete from fishy_membergroup where groupid=" + groupid + "and memberid=" + memberid; // 참여 요청 삭제
    }

	int affectedRows = stmt.executeUpdate(mySQL);
    if(affectedRows > 0) {
%>
    <script>
        alert("참여 신청을 결정하였습니다..");
		location.href="group_manage.jsp?memberid=<%=session_id%>&groupid=<%=groupid%>";
    </script>
<%        
	} else {
%>
    <script>
        alert("알 수 없는 오류가 발생하였습니다..");
        location.href="group_manage.jsp?memberid=<%=session_id%>&groupid=<%=groupid%>";
    </script>
<%
	}
	stmt.close();
	myConn.close();
%>
