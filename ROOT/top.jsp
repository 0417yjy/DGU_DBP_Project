<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head><title>Insert title here</title></head>
<body>
	<% 
		String session_id = (String)session.getAttribute("user");
		String session_uname = (String)session.getAttribute("userName"); 
		String log;
  	
		if(session_id==null){
			log="<a href=login.jsp>로그인</a>";
		} else {
			log="<a href=logout.jsp>로그아웃</a>";
			// log="<a href=logout.jsp>" + session_id + "</a>";
		}
	%>

	<table width="75%" align="center" bgcolor="#FFFF99" border>
		<tr>
			<td align="center"><b><%=log%></b></td>
			<td align="center"><b><a href="mypage.jsp">마이페이지</b></td>
			<td align="center"><b><a href="join.jsp">그룹에 참여</b></td>
			<td align="center"><b><a href="delete.jsp">송금 요청하기</b></td>
			<td align="center"><b><a href="select.jsp">송금하기</b></td>
			<td align="center"><b><a href="select.jsp">받은 송금 처리하기</b></td>
		</tr>
	</table>
</body>
</html>

