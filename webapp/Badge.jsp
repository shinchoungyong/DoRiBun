<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모든 뱃지</title>
<style>
@font-face {
	font-family: 'TheJamsil5Bold';
	src:
		url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2')
		format('woff2');
	font-weight: 500;
	font-style: normal;
}

h1, p, span {
	font-family: 'TheJamsil5Bold';
}

body {
	background-image:
		url('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D');
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f9f9f9;
}

.container {
	max-width: 800px;
	margin: 50px auto;
	padding: 20px;
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h1 {
	text-align: center;
	margin-bottom: 30px;
}

.badge-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
	gap: 20px;
	padding: 20px;
}

.badge-item {
	text-align: center;
	background-color: #f4f4f4;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	transition: transform 0.2s ease-in-out;
}

.badge-item:hover {
	transform: translateY(-5px);
}

.badge-item img {
	width: 100px;
	height: 100px;
	object-fit: cover;
	border-radius: 50%;
	margin-bottom: 10px;
}

.badge-item p {
	margin: 0;
	font-size: 18px;
	font-weight: bold;
}

.badge-item span {
	font-size: 14px;
	color: #555;
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
		<h1>
			<!-- 전 페이지로 돌아가는 폼 버튼 -->
			<div class="back-button-container">
				<button class="back-button" onclick="goProfile()">←</button>
			</div>
			전체 뱃지
		</h1>
		<div class="badge-grid">
			<div class="badge-item">
				<img src="./file/B00001.png" alt="뱃지 1">
				<p>비기너 뱃지</p>
				<span>첫 가입 시 획득하는 뱃지</span>
			</div>
			<div class="badge-item">
				<img src="./file/B00002.png" alt="뱃지 2">
				<p>비매 뱃지</p>
				<span>게시물 신고를 3회 이상 당한 사용자에게 부여되는 뱃지</span>
			</div>
			<div class="badge-item">
				<img src="./file/B00003.png" alt="뱃지 3">
				<p>리뷰왕 뱃지</p>
				<span>리뷰게시글 50회 작성하면 획득하는 뱃지</span>
			</div>
			<div class="badge-item">
				<img src="./file/admin.png" alt="뱃지 4">
				<p>관리자 뱃지</p>
				<span>관리자에게 부여된 뱃지</span>
			</div>
			<!-- 9/25 9:49 뱃지 이미지 추가 -->
			<div class="badge-item">
				<img src="./file/B00005.png" alt="뱃지 5">
				<p>소통해요 뱃지</p>
				<span>댓글을 100회 작성하면 획득하는 뱃지</span>
			</div>
			<!-- 추가된 5개의 뱃지 -->
			<div class="badge-item">
				<img src="./file/B00006.png" alt="뱃지 6">
				<p>혼자는 싫어 뱃지</p>
				<span>5회 이상 동행자 구인글을 작성하면 획득하는 뱃지</span>
			</div>
			<div class="badge-item">
				<img src="./file/B00007.png" alt="뱃지 7">
				<p>좋아요 100회 달성 뱃지</p>
				<span>작성한 게시글에 처음으로 좋아요 100회 이상 받았을 때 획득하는 뱃지</span>
			</div>
			<div class="badge-item">
				<img src="./file/B00008.png" alt="뱃지 8">
				<p>커뮤니티 기여자 뱃지</p>
				<span>전체(구인, 리뷰, 여행) 게시글을 50회 작성하면 획득하는 뱃지</span>
			</div>
			<div class="badge-item">
				<img src="./file/B00009.png" alt="뱃지 9">
				<p>인기쟁이 뱃지</p>
				<span>매달 최다 메세지 수신 시에 획득하는 뱃지</span>
			</div>
			<div class="badge-item">
				<img src="./file/B00010.png" alt="뱃지 10">
				<p>두리번 뱃지</p>
				<span>매달 최다 게시글, 댓글 작성자에게 부여되는 뱃지</span>
			</div>
		</div>
	</div>
	<script>
		function goProfile() {
			alert('프로필 페이지로 이동합니다.'); // 메인페이지로 돌아가는 버튼함수 !
			window.location.href = "Profile.jsp";
		}
	</script>
</body>
</html>