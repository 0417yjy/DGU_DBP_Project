<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<title>교수정보변경</title>
	</head>
	<body>
	<%
		request.setCharacterEncoding("utf-8");
		String p_id = request.getParameter("p_id");
		String p_pwd = request.getParameter("p_pwd");
		String p_research = request.getParameter("p_research");
		
	
		Connection myConn = null;  
		Statement stmt = null;  
		String mySQL = "";
	
		String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:DBLAB";
		String user = "FE2015112135";	// 본인 아이디(ex.FE0000000000)
		String passwd = "FE2015112135";	// 본인 패스워드(ex.FE0000000000)
		String dbdriver = "oracle.jdbc.driver.OracleDriver"; 
	
		try {
			Class.forName(dbdriver);
			myConn =  DriverManager.getConnection (dburl, user, passwd);
			stmt = myConn.createStatement();	
		} catch(SQLException ex) {
		 	System.err.println("SQLException: " + ex.getMessage());
		}
		
		mySQL = "update professor ";
		mySQL = mySQL + " set p_research ='" + p_research + "' , " ;	
		mySQL = mySQL + " p_pwd ='" + p_pwd + "' where p_id='" + p_id + "' ";
		
		try {			
			stmt.executeUpdate(mySQL);  
	%>
		<script>
			alert("정보가 수정되었습니다.");       
			location.href="update_professor.jsp";
		</script>
	<%    
		} catch(SQLException ex) {
			String sMessage; 
			if (ex.getErrorCode() == 20002) sMessage="패스워드는 문자와 숫자를 조합해야 합니다.";
			else if (ex.getErrorCode() == 20003) sMessage="연구분야를 다시 입력해주세요.";
			else if (ex.getErrorCode() == 20004) sMessage="패스워드는 기존과 동일하게 변경할 수 없습니다.";
			else sMessage="잠시 후 다시 시도하십시오";
	%>
		<script>
			alert("<%= sMessage %>");
			location.href = "update_professor.jsp";
		</script>
	<%	
		} finally {
			if (stmt != null) {
				try { 
					stmt.close();  
					myConn.close(); 
				} catch(SQLException ex) { }
			}			
		}
	%>
	</body>
</html>

