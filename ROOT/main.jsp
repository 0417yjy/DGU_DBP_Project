<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head><title>Fishy</title></head>
<body>
	<%@ include file="top.jsp" %>
	<table width="100%" align="center" height="100%">
	<% if(session_id != null) { %>
		<tr>
			<td align="center"><%=session_id%>님 방문을 활영합니다</td>
		</tr>	
	<% } else {	%>
		<tr>
			<td align="center"> 로그인한 후 사용하세요.</td>
		</tr>
	<% } %>
	</table>
</body>
</html>

