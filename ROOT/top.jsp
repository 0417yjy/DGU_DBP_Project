<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>

<head>
	<title>Insert title here</title>
	<style>
		.logo {
			position: relative;
			left: 12.5%;
			background-color: white;
			/* Green */
			border: 2px solid #65d2f3;
			color: #2f697a;
			padding: 16px 32px;
			text-align: center;
			text-decoration: none;
			display: inline-block;
			font-size: 16px;
			margin: 4px 2px;
			transition-duration: 0.4s;
			cursor: pointer;
			border-radius: 25px;
		}

		.logo:hover {
			background-color: #65d2f3;
			color: white;
		}
	</style>
</head>

<body>
	<% 
		String session_id = (String)session.getAttribute("user");
		String session_uname = (String)session.getAttribute("userName"); 
		String log;
  	
		if(session_id==null){
			log="<a style='color: white;' href=login.jsp>로그인</a>";
		} else {
			log="<a style='color: white;' href=logout.jsp>로그아웃</a>";
		}
	%>
	<button class="logo" onclick="location.href='index.jsp'">Fi$hy</button>
	<table width="75%" align="center" bgcolor="#65d2f3" color="#fff" border>
		<tr>
			<td align="center"><b><%=log%></b></td>
			<td align="center"><b><a style="color: white;" href="mypage.jsp">마이페이지</b></td>
			<td align="center"><b><a style="color: white;" href="join.jsp">그룹에 참여</b></td>
			<td align="center"><b><a style="color: white;" href="request_tx.jsp">송금 요청하기</b></td>
		</tr>
	</table>
	</div>
	</div>

</body>

</html>