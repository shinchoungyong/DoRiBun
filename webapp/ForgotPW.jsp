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
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2') format('woff2');
    font-weight: 500;
    font-style: normal;
}

body {
background-image : url('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D');
	background-color: #F3F4F9;
	margin: 0;
	padding: 0;
	font-family: Verdana, Geneva, Tahoma, sans-serif;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

#form-container {
	display: flex;
	justify-content: center;
	align-items: center;
}

#forgot-pw-container {
	padding: 40px 50px;
	width: 300px;
	background-color: #FFFFFF;
	border-radius: 30px;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
	text-align: center;
	min-height: 400px;
}
/*24-09-13 오전 수정사항 ; h1글씨색 #62b6fe로 수정  */
h1 {
	font-family: 'TheJamsil5Bold';
	color: #62b6fe;
	font-size: 2em;
	font-weight: 500;
	margin-bottom: 20px;
}

form input[type="text"], form input[type="password"], form input[type="password2"]
	{
	display: block;
	margin: 0 auto 20px;
	border: 1px solid #E5E9F5;
	background-color: #F6F7FA;
	padding: 15px;
	border-radius: 5px;
	width: calc(100% - 40px);
	font-size: 1em;
}

label {
	font-family: 'TheJamsil5Bold';
	color: #7369AB;
	font-size: 1em;
	display: block;
	margin-bottom: 5px;
	text-align: left;
}

::placeholder {
	color: #C0C7DB;
	font-size: larger;
	letter-spacing: 1.2px;
}
/*24-09-13 오전 수정사항 ; 버튼색상 #62b6fe로 수정  */
input[type="submit"] {
	font-family: 'TheJamsil5Bold';
	width: calc(100% - 80px);
	border: none;
	font-size: 1em;
	padding: 10px 30px;
	cursor: pointer;
	background-color: #62b6fe;
	border-radius: 3px;
	color: white;
	margin-top: 10px;
}

input[type="submit"]:hover {
	background-color: #ff6678;
}

#form-controls {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 20px;
	margin-bottom: 20px;
	align-items: center;
}
/* 뒤로가기 버튼 꾸민곳 */
.back-button-container {
	display: flex;
	justify-content: left;
	margin-top: 30px;
}

/*24-09-13 오전 수정사항 ; 버튼색상 #62b6fe로 수정  */
.back-button {
	padding: 10px 20px;
	background-color: #62b6fe;
	color: white;
	border: none;
	cursor: pointer;
	border-radius: 5px;
	font-size: 16px;
	display: flex;
	justify-content: flex-start;
}

.back-button:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<!-- 비밀번호 변경창 -->
	<div id="form-container">
		<!-- 비밀번호 변경폼 -->
		<div id="forgot-pw-container">
			<!-- 로그인 페이지로 이동하는 버튼 만들어둡니다 -->
			<button class="back-button" onclick="goLogin()">←</button>
			<h1>비밀번호 변경</h1>
			<form action="PwUpdateService.do" method="post">

				<label for="user_id">아이디</label> <input type="text" name="user_id"
					id="id" placeholder="아이디 입력" required> <label
					for="new-password">새 비밀번호</label> <input type="password"
					name="new_user_pw1" id="pw" placeholder="새 비밀번호 입력"> <label
					for="confirm-password">새 비밀번호 확인</label> <input type="password"
					name="new_user_pw2" id="pw" placeholder="새 비밀번호 확인" required>

				<div id="form-controls">
					<input type="submit" value="비밀번호 변경완료">
				</div>
			</form>
		</div>
</body>
<script>
	/* 뒤로가기 버튼 함수 */
	function goLogin() {
		alert('로그인페이지로 이동합니다.');
		window.location.href = "LoginMain.jsp";
	}
	
</script>
<%
    // 세션에 메시지가 있다면 알림창을 띄웁니다.
    String message = (String) session.getAttribute("message");
    if (message != null) {
%>
<script type="text/javascript">
    alert("<%= message %>");
    <% session.removeAttribute("message"); %> <!-- 메시지 초기화 -->
</script>
<%
    }
%>
</html>