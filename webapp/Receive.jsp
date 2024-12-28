<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.doo.model.MessageDAO" %>
<%@ page import="com.doo.model.MessageDTO" %>
<%@ page import="com.doo.model.UserDAO" %>
<%@ page import="com.doo.model.UserDTO" %>
<%@ page import="com.doo.model.ProfileImgDAO" %>
<%@ page import="com.doo.model.ProfileImgDTO" %>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

@font-face {
	font-family: 'TheJamsil5Bold';
	src:
		url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2')
		format('woff2');
	font-weight: 500;
	font-style: normal;
}

h3, div{

font-family: 'TheJamsil5Bold';}

body {
background-image : url('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D');
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
}

.container {
	max-width: 600px;
	margin: 20px auto;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.profile {
	display: flex;
	align-items: center;
	border-bottom: 1px solid #ddd;
	padding-bottom: 10px;
	margin-bottom: 10px;
}

.profile img {
	border-radius: 50%;
	width: 50px;
	height: 50px;
	margin-right: 15px;
}

.profile .info {
	flex: 1;
}

.profile .info h2 {
	margin: 0;
	font-size: 18px;
}

.profile .info p {
	margin: 0;
	color: #777;
}

.messages {
	margin-top: 10px;
}

.message {
	position: relative;
	padding: 15px;
	background: #fafafa;
	border: 1px solid #ddd;
	border-radius: 8px;
	margin-bottom: 10px; /* 메시지 사이에 여백 추가 */
	position: relative;
	background-color: #fff;
}

/*24-09-13 오전 수정사항 ; 버튼색상 #62b6fe로 수정  */
.message button {
	position: absolute; /* 버튼을 절대 위치로 설정 */
	right: 1%; /* 오른쪽에서 15px 떨어진 위치 */
	transform: translateY(-50%); /* 버튼을 수직 중앙 정렬 */
	border: none;
	background-color: #62b6fe;
	color: white;
	border-radius: 4px;
	cursor: pointer;
}

.message button:hover {
	background-color: #e60000;
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

.delete-button {
	display: flex;
	justify-content: flex-end;
}

#delete-button {
	padding: 5px 10px;
	background-color: black;
	color: white;
	border: none;
	cursor: pointer;
	border-radius: 5px;
	width: 30px;
	margin-bottom: 5px;
	margin-right: 5px;
}
</style>
</head>
<body>
      <!-- 9월 20일 Receive 메세지 페이지 헤더 구현 -->
    <%
      // 사용자 정보를 세션 또는 요청에서 가져옵니다.
        UserDTO vo = (UserDTO)session.getAttribute("loginMember");
        

      	//사용자 정보 및 프로필 이미지 로드
      	/* UserDTO user = new UserDAO().profileLoading(vo) */;
      	ProfileImgDTO profileImg = new ProfileImgDAO().loadingImg(vo);
      %>

	<div class="container">
		
		<button class="back-button" onclick="goMain()">←</button>
		
		<!-- 프로필 정보 표시 -->
		<div class="profile">
            <img src="./file/<%=profileImg != null ? profileImg.getUser_img() : "default.png" %>" id="">
            <div class="info">
                <h3><%=vo != null ? vo.getUser_nick() : "게스트" %>님이 받으신 메시지</h3>
            </div>
		</div>
		
        <!-- 9월 20일 메시지 조회  -->
       <%
    // 로그인된 사용자의 정보를 통해 메시지 불러오기
    if (vo != null) {
        // 사용자 ID를 기반으로 메시지 조회
        List<MessageDTO> messageList = new MessageDAO().showMessage(vo);

        // 메시지 리스트가 비어 있는지 확인
        if (messageList != null && !messageList.isEmpty()) {
            for (MessageDTO message : messageList) {
           %>		
		        <div class="delete-button">
		        <button id="delete-button">X</button>
				</div>
                <div class="message">
                    <div class="messageNumber">메시지 ID: <%=message.getMESSAGE_ID()%></div>
                    <div class="sender">보낸 사람: <%=message.getSENDER_ID()%></div>
                    <div class="receiver">받는 사람: <%=message.getRECEIVER_ID()%></div>
                    <div class="messageContext">메시지 내용: <%=message.getMESSAGE_CONTENT()%></div>
                </div>
<%
            }
        } else {
            out.println("<p>받은 메시지가 없습니다.</p>");
        }
    } else {
        out.println("<p>로그인이 필요합니다.</p>");
    }
%>

	</div>
	
	<script>
     
        function goMain() {
            alert('메인페이지로 이동합니다.');
            window.location.href = "MainPage.jsp";
        }
    </script>
   
</body>
</html>