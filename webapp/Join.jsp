<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body {
	background-color: #F3F4F9;
	margin: 0;
	padding: 0;
	font-family: Verdana, Geneva, Tahoma, sans-serif;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 150vh;
}

#form-container {
	display: flex;
	justify-content: center;
	align-items: center;
}

#sign-up-container {
	width: 80%;
	padding: 40px 60px;
	min-width: 500px;
	background-color: #FFFFFF;
	border-radius: 30px;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
	text-align: center;
	height: 70%;
	min-height: 300px;
	margin-top: 20%;
}
/*24-09-13 오전 수정사항 ; h1글씨색 #62b6fe로 수정  */
h1 {
	color: #62b6fe;
	font-size: 2em;
	font-weight: 500;
	margin-bottom: 20px;
}

form input[type="text"], form input[type="password"], form input[type="tel"]
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

#form-controls {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 20px;
	margin-bottom: 20px;
	align-items: center;
}

label {
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
input[type="submit"], #check-duplicate-btn {
	border: none;
	font-size: 1em;
	padding: 10px 30px;
	cursor: pointer;
	background-color: #62b6fe;
	border-radius: 3px;
	color: white;
}

#check-duplicate-btn:hover, input[type="submit"]:hover {
	background-color: #0056b3;
}

#gender-options {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 20px;
	margin: 10px 0;
}

#gender-options input[type="radio"] {
	display: none;
}
/*24-09-13 오전 수정사항 ; 버튼색상 #62b6fe로 수정  */
#gender-options label {
	display: inline-block;
	padding: 10px 20px;
	border: 2px solid #62b6fe;
	border-radius: 5px;
	cursor: pointer;
	color: #62b6fe;
	font-size: 1em;
	transition: all 0.3s ease;
}
/*24-09-13 오전 수정사항 ; 버튼색상 #62b6fe로 수정  */
#gender-options input[type="radio"]:checked+label {
	background-color: #62b6fe;
	color: white;
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
	display: flex;
	justify-content: flex-start;
}

.back-button:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
    <div id="form-container">
        <div id="sign-up-container">
            <button class="back-button" onclick="goLogin()">←</button>
            <h1>회원가입</h1>
            <form action="JoinService.do" method="post" onsubmit="return validateForm()">
                <label for="user_id">아이디</label>
                <input type="text" name="user_id" id="user_id" placeholder="아이디 입력" required>
                <!-- 중복 확인 버튼 추가 -->
                <button type="button" id="check-duplicate-btn" onclick="checkDuplicateId()">중복 확인</button>
                <p id="duplicate-check-result"></p> <!-- 중복 확인 결과 표시 -->
                
                <label for="user_pw">비밀번호</label>
                <input type="password" name="user_pw" id="pw" placeholder="비밀번호 입력" required>
                
                <label for="pw_check">비밀번호 확인</label>
                <input type="password" name="pw_check" id="pw_check" placeholder="비밀번호를 한 번 더 입력" required>
                
                <label for="user_name">이름</label>
                <input type="text" name="user_name" id="name" placeholder="홍길동" required>
                
                <label for="user_nick">닉네임</label>
                <input type="text" name="user_nick" id="nick" placeholder="닉네임" required>
                
                <label for="user_birthdate">생년월일</label>
                <input type="text" name="user_birthdate" id="birth" placeholder="20010101" maxlength='8' required>
                
                <label for="Phone">휴대폰번호</label>
                <input type="tel" name="user_phone" id="Phone" maxlength='11' placeholder="01012345678" required>
                
                <label for="user_gender">성별</label>
                <div id="gender-options">
                    <input type="radio" id="male" name="user_gender" value="M" required>
                    <label for="male">남성</label>
                    
                    <input type="radio" id="female" name="user_gender" value="F" required>
                    <label for="female">여성</label>
                </div>
                
                <div id="form-controls">
                    <input type="submit" value="회원가입완료">
                </div>
                
            </form>
        </div>
    </div>
    <script type="text/javascript">
        // ID 중복 확인 함수
        function checkDuplicateId() {
            var userId = document.getElementById("user_id").value;
            if (userId.trim() === "") {
                alert("아이디를 입력해주세요.");
                return;
            }
            
            // AJAX를 사용하여 서버에 중복 확인 요청
            // 9-24 12:35
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "CheckIdDuplicate.do?user_id=" + encodeURIComponent(userId), true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var result = xhr.responseText;
                    var resultElement = document.getElementById("duplicate-check-result");
                    if (result === "duplicate") {
                        resultElement.style.color = "red";
                        resultElement.textContent = "이미 사용 중인 아이디입니다.";
                    } else {
                        resultElement.style.color = "green";
                        resultElement.textContent = "사용 가능한 아이디입니다.";
                    }
                }
            };
            xhr.send();
        }

        // 회원가입 폼 유효성 검사 함수
        function validateForm() {
            // 입력된 아이디와 비밀번호를 가져옵니다.
            const userId = document.getElementById('user_id').value;
            const userPw = document.getElementById('pw').value;
            const userPwCheck = document.getElementById('pw_check').value;

            // 모든 필드가 입력되었는지 확인
            if (userId === "" || userPw === "" || userPwCheck === "") {
                alert('모든 필드를 입력해주세요.');
                return false; // 폼 제출 중지
            }

            // 비밀번호와 비밀번호 확인이 일치하는지 확인
            if (userPw !== userPwCheck) { 
                alert('비밀번호가 일치하지 않습니다.');
                return false; // 폼 제출 중지
            }

            // 모든 유효성 검사를 통과한 경우
            alert('회원가입이 완료되었습니다!');
            return true; // 폼이 제출됩니다.
        }

        // 뒤로가기 버튼 함수
        function goLogin() {
            alert('로그인페이지로 이동합니다.');
            window.location.href = "LoginMain.jsp";
        }
    </script>
</body>

</html>