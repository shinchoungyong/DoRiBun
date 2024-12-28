<%@page import="com.doo.model.UserDTO"%>
<%@page import="com.doo.model.ProfileImgDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지창</title>
<style>
@font-face {
	font-family: 'TheJamsil5Bold';
	src:
		url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2')
		format('woff2');
	font-weight: 500;
	font-style: normal;
}

h1, label, input {
	font-family: 'TheJamsil5Bold';
}

body {
	background-image:
		url('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D');
	display: flex;
	flex-direction: column;
	align-items: center;
	height: 100vh;
	margin: 0;
	font-family: Arial, sans-serif;
	justify-content: center;
	background-color: #f7f7f7; /* 배경 색상 추가 */
}

.container {
	border: 1px solid #ccc; /* 박스 테두리 */
	padding: 20px;
	border-radius: 8px; /* 모서리 둥글게 */
	background-color: #fff; /* 배경 색상 */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	width: 100%;
	max-width: 600px; /* 최대 너비 설정 */
}

h1 {
	text-align: center; /* 제목 중앙 정렬 */
	margin-bottom: 20px;
}

table {
	width: 100%;
	border-collapse: collapse; /* 테두리 겹침 제거 */
}

td {
	padding: 10px; /* 셀 여백 */
	border: 1px solid #ddd; /* 셀 테두리 */
	vertical-align: middle; /* 수직 정렬 */
}

input[type="text"], textarea {
	width: 100%; /* 입력 필드 전체 너비 */
	padding: 8px;
	border: 1px solid #ccc; /* 입력 필드 테두리 */
	border-radius: 4px; /* 입력 필드 모서리 둥글게 */
	box-sizing: border-box; /* 여백 포함 */
}

textarea {
	height: 100px; /* 텍스트 영역 높이 */
	resize: vertical; /* 수직으로 크기 조절 가능 */
}

button {
	padding: 10px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
	margin-top: 5px;
}

#send-button {
	background-color: #007bff;
	color: white;
	margin-left: 35%;
}

#send-button:hover {
	background-color: #0056b3;
}

#cancel-button {
	background-color: #6c757d;
	color: white;
}

#cancel-button:hover {
	background-color: #5a6268;
}

.message {
	margin-top: 20px;
	padding: 10px;
	background-color: #d4edda;
	color: #155724;
	border: 1px solid #c3e6cb;
	border-radius: 4px;
	display: none;
}
</style>
</head>
<body>

   <%
   // 사용자 정보를 세션 또는 요청에서 가져옵니다.
   UserDTO vo = (UserDTO) session.getAttribute("loginMember");
   %>

   <div class="container">
      <h1>메세지 전송창</h1>
      <form id="message-form" action="MessageService.do" method="post">
         <table>
            <tr>
               <td><label for="senderid">보내는사람</label></td>
               <td><label for="receiverid">받는사람</label></td>
            </tr>
            <tr>
               <td><input type="text" id="senderid" name="senderid"
                  value="<%=vo != null ? vo.getUser_id() : ""%>" readonly></td>
               <td><input type="text" id="receiverid" name="receiverid"></td>
            </tr>
            <tr>
               <td colspan="2"><label for="messageContent"></label> <textarea
                     id="messageContent" name="messageContent"></textarea></td>
            </tr>
         </table>
         <div class="actions">
            <button id="send-button" type="submit">보내기</button>
            <button id="cancel-button" type="button">취소</button>
         </div>
         <div id="confirmation-message" class="message" style="display: none;"></div>
      </form>
   </div>

   <script>
    document.addEventListener('DOMContentLoaded', function() {
        const sendButton = document.getElementById('send-button');
        const cancelButton = document.getElementById('cancel-button');
        const confirmationMessage = document.getElementById('confirmation-message');
        const messageForm = document.getElementById('message-form');

        sendButton.addEventListener('click', function(event) {
            event.preventDefault();
            
            const messageContent = document.getElementById('messageContent').value;
            const receiver = document.getElementById('receiverid').value;

            if (messageContent.trim() === '' || receiver.trim() === '') {
                alert('모든 필드를 채워 주세요.');
                return;
            }

            // 확인 메시지 표시
            confirmationMessage.textContent = '메시지가 전송되었습니다!';
            confirmationMessage.style.display = 'block';
            
            // 실제 폼 제출 (서버에 메시지 전송)
            messageForm.submit();
        });

        cancelButton.addEventListener('click', function(event) {
            event.preventDefault(); // 기본 폼 제출 방지

            // 폼 초기화
            messageForm.reset();
            confirmationMessage.style.display = 'none';
            
            // 메인 페이지로 이동
            window.location.href = 'MainPage.jsp'; 
        });
    });

   </script>
</body>
</html>