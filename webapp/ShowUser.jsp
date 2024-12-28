<%@page import="java.util.List"%>
<%@page import="com.doo.model.UserDTO"%>
<%@page import="com.doo.model.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@font-face {
	font-family: 'TheJamsil5Bold';
	src:
		url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2')
		format('woff2');
	font-weight: 500;
	font-style: normal;
}

h1, caption, input, td{
font-family: 'TheJamsil5Bold';}


body {
	background-color: #F3F4F9;
	margin: 0;
	padding: 0;
	font-family: Verdana, Geneva, Tahoma, sans-serif;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

#User-container {
	padding: 40px 80px;
	width: 800px;
	background-color: #FFFFFF;
	border-radius: 30px;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
	text-align: center;
}

#header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

#back {
	background-color: lightskyblue;
	color: white;
	border: none;
	padding: 10px 20px;
	cursor: pointer;
	border-radius: 5px;
}

h1 {
	color: lightskyblue;
	font-size: 2em;
	font-weight: 500;
	margin: 0;
}

table {
	border: 3px solid lightskyblue;
	border-radius: 3px;
	width: 100%;
	margin-top: 20px;
	text-align: center;
	border-collapse: collapse;
}

table td {
	padding: 8px;
	border: 3px solid lightskyblue;
}

caption {
	border: none;
	font-size: 2em;
	padding: 10px 50px;
	cursor: pointer;
	color: lightskyblue;
}

input[type="button"] {
	border: none;
	font-size: 1em;
	padding: 10px 30px;
	cursor: pointer;
	background-color: #FF4B5E;
	border-radius: 3px;
	color: white;
}

input[type="submit"]:hover {
	background-color: #ff6678;
}

a {
	text-decoration: none;
}

a:hover {
	color: #ff4b5e;
	text-decoration: none;
}
</style>
</head>
<body>
	<div id="User-container">
		<div id="header">
			<h1>회원관리</h1>
			<input type="button" id="back" name="back" value="되돌아가기"
				onclick="goMain()">
		</div>
		<table>
			<caption>회원 정보 목록</caption>
			<tr>
				<td>아이디</td>
				<td>비밀번호</td>
				<td>이름</td>
				<td>닉네임</td>
				<td>전화번호</td>
			</tr>
			
			<%List<UserDTO> users = new UserDAO().allusers();%>
			
			<%for (UserDTO user : users) { %>
			<tr>
				<td><%=user.getUser_id()%></td>
				<td><%=user.getUser_pw()%></td>
				<td><%=user.getUser_name()%></td>
				<td><%=user.getUser_nick()%></td>
				<td><%=user.getUser_phone()%></td>
				<td><a href="AdminService.do?user_id=<%=user.getUser_id()%>">삭제</a></td>
			</tr>
			<%}%>
		</table>
	</div>
	
	<script type="text/javascript">
	function goMain() {
        alert('메인페이지로 이동합니다.');
        window.location.href = "MainPage.jsp";
    }
	</script>
</body>
</html>