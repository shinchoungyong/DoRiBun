<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보 수정</title>
    <style>
    @font-face {
    font-family: 'TheJamsil5Bold';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2') format('woff2');
    font-weight: 300;
    font-style: normal;
}
h2, label, button{
 font-family: 'TheJamsil5Bold';
}
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius : 30px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }

        input[type="text"], input[type="nickname"], input[type="password"] {
            width: 95%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        .form-group .error {
            color: red;
            font-size: 12px;
        }
		/*24-09-13 오전 수정사항 ; 버튼색상 #62b6fe로 수정  */
        .edit {
            width: 100%;
            padding: 10px;
            background-color: #62b6fe;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        .success-message {
            text-align: center;
            color: green;
            margin-top: 15px;
        }
        #profileImage{
        	border : solid 1px; 
        	border-radius : 50%;
        }
        
		/* 뒤로가기 버튼 꾸민곳 */
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
    <h2>회원정보 수정</h2>
    <form action="UpdateService.do" id="update-form" >
        <div class="form-group">
            <div class="error" id="file-error"></div>
        </div>

        <div class="form-group">
            <label for="nickname">닉네임</label>
            <input type="text" id="nickname" name="user_nick" placeholder="닉네임을 입력하세요" required>
            <div class="error" id="nickname-error"></div>
        </div>

        <div class="form-group">
            <label for="password">새 비밀번호</label>
            <input type="password" id="password" name="user_pw" placeholder="새 비밀번호를 입력하세요" required>
            <div class="error" id="password-error"></div>
        </div>

        <div class="form-group">
            <label for="confirm-password">비밀번호 확인</label>
            <input type="password" id="confirm-password" name="confirm_password" placeholder="비밀번호를 다시 입력하세요" required>
            <div class="error" id="confirm-password-error"></div>
        </div>

        <button class="edit" type="submit">수정하기</button>
    </form>
    <div class="success-message" id="success-message"></div>
</div>

<script>

	
    function handleFormSubmit(event) {
        event.preventDefault();

        // 에러 메시지 초기화
        document.getElementById('file-error').textContent = '';
        document.getElementById('nickname-error').textContent = '';
        document.getElementById('password-error').textContent = '';
        document.getElementById('confirm-password-error').textContent = '';

        // 입력 필드 값 가져오기
        const username = document.getElementById('file').value;
        const email = document.getElementById('nickname').value;
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirm-password').value;

        // 입력 유효성 검사
        let valid = true;

        if (username.length < 2) {
            document.getElementById('file-error').textContent = '적용되지 않는  사진 형식입니다.';
            valid = false;
        }

        if (!validateEmail(email)) {
            document.getElementById('nickname-error').textContent = '유효한 닉네임을 입력하세요.';
            valid = false;
        }

        if (password.length < 6) {
            document.getElementById('password-error').textContent = '비밀번호는 6자 이상이어야 합니다.';
            valid = false;
        }

        if (password !== confirmPassword) {
            document.getElementById('confirm-password-error').textContent = '비밀번호가 일치하지 않습니다.';
            valid = false;
        }

        if (valid) {
            document.getElementById('success-message').textContent = '회원정보가 성공적으로 수정되었습니다!';
            // 실제로 서버에 데이터를 전송하는 로직은 여기서 처리합니다.
        }

        return false;
    }
    function goProfile() {
   		alert('프로필 페이지로 이동합니다.'); // 메인페이지로 돌아가는 버튼함수 !
    	window.location.href = "Profile.jsp";
}
    
</script>

</body>
</html>