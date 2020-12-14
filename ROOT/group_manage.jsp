<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"  %>
<%
    String userid = request.getParameter("memberid");
    String groupid = request.getParameter("groupid");
%>
<!DOCTYPE html>
<html>

<head>
    <title>그룹 관리</title>
<body>
    <%@ include file="top.jsp" %>
    <%
    String adminid = "";
    String faid = "";
    String groupname = "";
    String groupdesc = "";

    Connection myConn = null;     
	Statement stmt = null;	
	ResultSet myResultSet = null; 
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
    // get admin id
    mySQL = "select adminid from fishy_group where groupid=" + groupid;
	myResultSet = stmt.executeQuery(mySQL);
    if(myResultSet.next()) {
        adminid = myResultSet.getString("adminid");
    }
    
    if(!userid.equals(adminid)) {
%>
    <script>
    alert("You're not the admin of this group!");
    location.href='mypage.jsp';
    </script>
<%        
    }
%>
<%
    mySQL = "select groupname, financialagentid, groupdesc from fishy_group where groupid=" + groupid;
	myResultSet = stmt.executeQuery(mySQL);
    if(myResultSet.next()) {
        groupname = myResultSet.getString("groupname");
        faid = myResultSet.getString("financialagentid");
        groupdesc = myResultSet.getString("groupdesc");
    }
%>
    <form method="post" action="group_manage_verify.jsp">
        <table width="75%" align="center" border>
        <input type="hidden" name="groupid" value="<%= groupid%>"></input>
            <tr><th>그룹 이름</th>
               <td><input type="text" name="groupname" size="100"  value="<%= groupname %>"></td>
            </tr>
            <tr><th>그룹 설명</th>
                <td><input type="text" name="groupdesc" size="100"  value="<%= groupdesc %>"></td>
            </tr>
            <tr><th>관리자 지정</th>
                <td>
                    <select id="newadmin" name="newadmin">
<%
    mySQL = "select m.memberid, m.username from fishy_member m, fishy_membergroup mg where m.memberid=mg.memberid and mg.groupid=" + groupid;
	myResultSet = stmt.executeQuery(mySQL);
    while(myResultSet.next()) {
        String memberid = myResultSet.getString("memberid");
        String username = myResultSet.getString("username");
%>
                        <option value="<%= memberid %>"><%= username%></option>
<%        
    }
%>                            
                    </select>
                </td>
            </tr>
            <tr><th>총무 지정</th>
                <td>
                    <select id="newfa" name="newfa">
                        <option value="0">-</option>
<%
    mySQL = "select m.memberid, m.username from fishy_member m, fishy_membergroup mg where m.memberid=mg.memberid and mg.groupid=" + groupid + " and mg.permissionlevel > 0";
	myResultSet = stmt.executeQuery(mySQL);
    while(myResultSet.next()) {
        String memberid = myResultSet.getString("memberid");
        String username = myResultSet.getString("username");
%>
                        <option value="<%= memberid %>"><%= username%></option>
<%        
    }
%>                
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                <input type="submit" value="수정">
                </td> 
            </tr>
        </table>
    </form>
    <%-- 참여를 바라는 사용자 리스트--%>
    <table width="75%" align="center" border>
        <tr>
            <th rowspan=0>참여 신청 리스트</th>
        </tr>
<%
    mySQL = "select m.memberid, m.username from fishy_member m, fishy_membergroup mg where m.memberid=mg.memberid and mg.groupid=" + groupid + " and mg.permissionlevel=0";
    myResultSet = stmt.executeQuery(mySQL);
    while(myResultSet.next()) {
        String memberid = myResultSet.getString("memberid");
        String username = myResultSet.getString("username");
%>
        <tr>
            <td style="width: 80%;"><%= username %></td>
            <td><button onclick="location.href='join_response.jsp?groupid=<%=groupid%>&memberid=<%=memberid%>&action=accept'">참여 허가</button></td>
            <td><button onclick="location.href='join_response.jsp?groupid=<%=groupid%>&memberid=<%=memberid%>&action=reject'">참여 거부</button></td>
        </tr>
<%
    }
    stmt.close();  
	myConn.close();
%>
    </table>
</body>
</html>