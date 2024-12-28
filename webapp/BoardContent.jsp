<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판글작성</title>

<style>
@font-face {
    font-family: 'TheJamsil5Bold';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2') format('woff2');
    font-weight: 500;
    font-style: normal;
}

input, label, button{
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
	margin: 50px auto;
	background-color: white;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 30px;
}

.Board-group {
	margin-bottom: 15px;
}

label {
	display: block;
	margin-bottom: 5px;
	color: #555;
}

input[type="file"], textarea, input[type="text"] {
	width: 100%;
   padding: 10px;
   box-sizing: border-box;
   border: solid 2px #1E90FF;
   border-radius: 5px;
   font-size: 12px;
   resize: none;
}

.Board-group .error {
	color: #62b6fe;
	font-size: 12px;
}
/*24-09-13 오전 수정사항 ; 버튼색상 #62b6fe로 수정  */
.update-Board {
	width: 98%;
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

#profileImage {
	border: solid 1px;
	border-radius: 50%;
	margin-bottom: 30px;
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

#profileImage {
	border-radius: 0%;
	width: 300px;
	max-height: 700px;
	min-height: 200px;
	margin-left: 25%
}
</style>
</head>
<body>

	<div class="container">
		<button class="back-button" onclick="goMain()">←</button>



		<form action="BoardUploadService.do" id="update-Board" method="post" enctype="multipart/form-data" >
			<div class="form-group">
				<div class="error" id="file-error"></div>
			</div>
			<br> <br>

			<div class="Board-group">
				<label for="file"></label> <img
					src="https://via.placeholder.com/150" alt="사진" id="profileImage">
				<input type="file" accept="image/*"  name ="b_file" onchange="previewImage(event)">
				<!-- <div class="error" id="nickname-error"></div> -->
			</div>

			<div class="Board-group">
				<label for="b_title">제목</label> <input type="text" id="b_title" name="b_title" placeholder="제목을 입력하세요" required>
				<!--  <div class="error" id="confirm-password-error"></div> -->
			</div>

			<div class="Board-group">
				<label for="password">텍스트 게시글</label>
				<textarea id="newContent" placeholder="오늘의 여행은 어땠나요?"
					onkeydown="resize(this)" onkeyup="resize(this)" name="b_content" ></textarea>
				<!--   <div class="error" id="password-error"></div> -->
			</div>

			<div class="Board-group">
				<label for="confirm-hashtag">해시태그</label> <input type="text" id="confirm_hashtag" name="b_confirm_hashtag" placeholder="해시태그를 입력하세요" required>
				<!--  <div class="error" id="confirm-password-error"></div> -->
			</div>

			<button class="update-Board" type="submit">게시하기</button>
		</form>
		<div class="success-message" id="success-message"></div>
	</div>

	<script>
	
	
		function previewImage(event) {
    		var reader = new FileReader();
    		reader.onload = function(){
        		var output = document.getElementById('profileImage');
        		output.src = reader.result; // 선택한 이미지 파일을 미리보기로 보여줌
    			};
    		reader.readAsDataURL(event.target.files[0]);
		}

		function goMain() {
		    alert('메인페이지로 이동합니다.');
		    window.location.href = "MainPage.jsp";
		}
	</script>
	</body>
</html>