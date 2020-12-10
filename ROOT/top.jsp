<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.util.regex.*" %>
<%
	String session_id = (String)session.getAttribute("user");
	String log;

	if (session_id==null) {
		log="<a href=login.jsp>로그인</a>";
	} else {
		log="<a href=logout.jsp>로그아웃</a>";
		Pattern p = Pattern.compile("[A-Z].*");
		Matcher m = p.matcher(session_id);
	}
%>
<table width="75%" align="center" bgcolor="#FFFF99" border>
	<tr>
		<td align="center"><b><%=log%></b></td>	
		<td align="center"><b><a href="update_professor.jsp">교수정보변경</b></td>    
		<td align="center"><b><a href="insert_teach.jsp">강좌개설신청</b></td>
		<td align="center"><b><a href="update_teach.jsp">수강정원변경</b></td>
		<td align="center"><b><a href="grade.jsp">성적등록</b></td>
	</tr>
</table>
