<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인 페이지</title>
    <style type="text/css">
        @font-face {
            font-family: 'TheJamsil5Bold';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2') format('woff2');
            font-weight: 300;
            font-style: normal;
        }

        body {
            background-image: url('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D');
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

        #sign-in-container {
            padding: 40px 60px;
            width: 300px;
            height: 400px;
            background-color: #FFFFFF;
            border-radius: 30px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h1 {
            color: #62b6fe;
            font-size: 2em;
            font-weight: 500;
            margin-bottom: 40px;
            font-family: 'TheJamsil5Bold';
        }

        form input[type="text"],
        form input[type="password"] {
            display: block;
            margin: 0 auto 20px;
            border: 1px solid #E5E9F5;
            background-color: #F6F7FA;
            padding: 15px;
            border-radius: 5px;
            width: calc(100% - 40px);
            font-size: 1em;
        }

        #form-controls {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
            margin-bottom: 20px;
            align-items: center;
        }

        label {
            color: #62b6fe;
            font-size: 1em;
            display: block;
            margin-bottom: 5px;
            text-align: left;
            font-family: 'TheJamsil5Bold';
        }

        ::placeholder {
            color: #C0C7DB;
            font-size: larger;
            letter-spacing: 1.2px;
        }

        input[type="submit"] , button{
            border: none;
            font-size: 1em;
            padding: 10px 30px;
            cursor: pointer;
            background-color: #62b6fe;
            border-radius: 3px;
            color: white;
            font-family: 'TheJamsil5Bold';
        }

        input[type="submit"]:hover , button:hover {
            background-color: #ff6678;
        }

        .password-reset {
            margin-top: 15px;
        }

        #forgot-password-link {
            font-family: 'TheJamsil5Bold';
            background-color: #62b6fe;
            color: white;
            padding: 10px 20px;
            border-radius: 3px;
            text-decoration: none;
            font-size: 1em;
            margin-top: 20px;
            margin-bottom: 20px;
        }

        #forgot-password-link:hover {
            background-color: #ff6678;
        }
    </style>
    <script>
        // 회원가입 버튼 클릭 시 메시지 출력 방지 및 페이지 이동
        function goToJoin() {
            window.location.href = 'Join.jsp';
        }
    </script>
</head>
<body>
    <!-- 로그인 창 -->
    <div id="form-container">
        <!-- 로그인 폼 -->
        <div id="sign-in-container">
            <h1>로그인</h1>
            <form action="LoginService.do" method="post">
                <label for="user_id">아이디</label>
                <input type="text" name="user_id" id="id" placeholder="아이디를 입력하세요" required>

                <label for="user_pw">비밀번호</label>
                <input type="password" name="user_pw" id="pw" placeholder="비밀번호를 입력하세요" required>

                <div id="form-controls">
                    <input type="submit" value="로그인"> <!-- 로그인 버튼 -->
                    <button type="button" onclick="goToJoin()">회원가입</button> <!-- 회원가입 버튼 -->
                </div>

                <div id="forgot-password-container">
                    <a href="ForgotPW.jsp" id="forgot-password-link">비밀번호를 잊어버리셨나요?</a>
                </div>
            </form>
        </div>
    </div>

    <% 
        // 로그인 실패 메시지가 있을 경우 자바스크립트를 통해 알림창을 띄웁니다.
        String loginFailMessage = (String) request.getAttribute("loginFailMessage");
        if (loginFailMessage != null) {
    %>
    <script type="text/javascript">
        alert("<%= loginFailMessage %>");
    </script>
    <% 
        }
    %>
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
</body>
</html>