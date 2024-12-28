<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고 완료</title>
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
        color: #4CAF50;
        margin-bottom: 20px;
    }

    p {
        font-size: 18px;
        color: #333;
        margin-bottom: 20px;
    }
    /* 9/23 9:07 버튼 이미지 변경 */

    .back-button,
    .main-button {
        display: inline-block;
        padding: 10px 20px;
        color: #fff;
        text-decoration: none;
        border-radius: 5px;
        font-size: 16px;
        margin-bottom: 10px;
    }

    .back-button {
        background-color: #62b6fe;
    }

    .back-button:hover {
        background-color: #0056b3;
    }

    .main-button {
        background-color: #4CAF50;
    }

    .main-button:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>
	<!-- 9/23 9:06 a태그 자스 함수로 변경(뒤로 되돌리기) -->
    <div class="container">
        <h1>신고 완료</h1>
        <p>신고가 성공적으로 접수되었습니다. 처리 결과는 추후 안내드리겠습니다.</p>
        <a href="javascript:history.back()" class="back-button">뒤로가기</a> <!-- 이전 페이지로 이동 -->
        <a href="MainPage.jsp" class="main-button">메인 페이지로 이동</a> <!-- 메인 페이지로 이동 -->
    </div>
</body>
</html>