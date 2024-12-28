<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고 실패</title>
<style type="text/css">
@font-face {
	font-family: 'TheJamsil5Bold';
	src:
		url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2')
		format('woff2');
	font-weight: 500;
	font-style: normal;
}

body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.container {
	text-align: center;
	max-width: 400px;
	margin: 20px;
	padding: 30px;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h1 {
	color: #ff4b5e;
	margin-bottom: 20px;
}

p {
	font-size: 18px;
	color: #333;
	margin-bottom: 20px;
}

.back-button {
	display: inline-block;
	padding: 10px 20px;
	background-color: #62b6fe;
	color: #fff;
	text-decoration: none;
	border-radius: 5px;
	font-size: 16px;
}

.back-button:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<div class="container">
		<h1>신고 실패</h1>
		<p>신고를 처리하는 중에 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.</p>
		<a href="MainPage.jsp" class="back-button">메인 페이지로 돌아가기</a>
	</div>
</body>
</html>