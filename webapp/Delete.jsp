<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 탈퇴</title>
    <style>
@font-face {
	font-family: 'TheJamsil5Bold';
	src:
		url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2')
		format('woff2');
	font-weight: 300;
	font-style: normal;
}

h2, button, p {
	font-family: 'TheJamsil5Bold';
}
/* 기본 페이지 스타일 */
body {
	font-family: 'Arial', sans-serif;
	background-color: #f4f4f4;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

/* 컨테이너 스타일 */
.container {
	background-color: #fff;
	padding: 40px;
	border-radius: 12px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	text-align: center;
	width: 100%;
	max-width: 400px;
}

h2 {
	color: #333;
	margin-bottom: 20px;
}

/* 입력 필드 스타일 */
input[type="password"] {
	width: 100%;
	padding: 10px;
	margin: 10px 0;
	border: 1px solid #ddd;
	border-radius: 6px;
	font-size: 16px;
	box-sizing: border-box;
}

/*24-09-13 오전 수정사항 ; 버튼색상 #62b6fe로 수정  */
/* 버튼 스타일 */
.del {
	width: 100%;
	padding: 10px;
	background-color: #62b6fe;
	color: white;
	border: none;
	border-radius: 6px;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}
/* 버튼 마우스올리면 반짝 */
.del:hover {
	background-color: #0056b3;
}

.back-button {
	margin-right: 400px;
}
/* 경고 텍스트 스타일 */
.warning {
	color: #FF4B5E;
	font-size: 14px;
	margin-top: 10px;
}

.back-button-container {
	text-align: left;
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
}

.back-button:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>

    <div class="container">
        <button class="back-button" onclick="goProfile()">←</button>
        <h2>회원 탈퇴</h2>
        <!-- 회원 탈퇴 폼 -->
        <form id="deleteForm" action="DeleteIdService.do" method="POST" onsubmit="return confirmDeletion(event)">
            <!-- 비밀번호 입력 필드 -->
            <input type="password" name="input_pw" placeholder="비밀번호를 입력하세요" required>
            
            <!-- 회원 탈퇴 버튼 -->
            <button class="del" type="submit">회원 탈퇴</button>

            <!-- 경고 문구 -->
            <p class="warning">회원 탈퇴 시 모든 정보가 삭제됩니다.</p>

            <!-- 서버로부터 받은 메시지 표시 -->
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
            %>
                <p class="warning"><%= errorMessage %></p>
            <%
                }
            %>
        </form>
    </div>

    <script>
        // 프로필 페이지로 돌아가는 함수
        function goProfile() {
            alert('프로필 페이지로 이동합니다.');
            window.location.href = "Profile.jsp";
        }

        // 회원 탈퇴 확인 함수
        function confirmDeletion(event) {
            // 비밀번호를 다시 확인하도록 메시지를 띄운다.
            // 9-24 점심전
            var password = document.querySelector('input[name="input_pw"]').value;
            if (!password) {
                alert("비밀번호를 입력해주세요.");
                return false;
            }
			
            // 정말 탈퇴할지 확인 메시지를 띄운다.
            // 9-24 점심전
            var confirmation = confirm("정말로 회원 탈퇴를 하시겠습니까? 모든 정보가 삭제됩니다.");
            if (!confirmation) {
                // 확인을 하지 않으면 폼 제출을 막는다.
                event.preventDefault();
                return false;
            }

            return true;
        }
    </script>

</body>
</body>
</html>