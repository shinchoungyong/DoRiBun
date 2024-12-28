<%@page import="com.doo.model.BadgeDAO"%>
<%@page import="com.doo.model.BadgeDTO"%>
<%@page import="com.doo.model.ProfileImgDAO"%>
<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>
<%@page import="com.doo.model.CommentDAO"%>
<%@page import="com.doo.model.CommentDTO"%>
<%@page import="com.doo.model.UserDAO"%>
<%@page import="com.doo.model.BoardDAO"%>
<%@page import="com.doo.model.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.doo.model.ProfileImgDTO"%>
<%@page import="com.doo.model.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>프로필 페이지</title>
<style>
/* Google 폰트 */
@import
	url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap')
	;

@import
	url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css')
	;

@font-face {
	font-family: 'TheJamsil5Bold';
	src:
		url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2')
		format('woff2');
	font-weight: 300;
	font-style: normal;
}

button, h1, h2, input, li, div, span, .board_content_index,
	.like-posts-button {
	font-family: 'TheJamsil5Bold';
}

/* 반응형 디자인 */
@media screen and (max-width: 480px) {
	#mainbody {
		width: 100%;
		margin: 10px;
	}
	.profile-header {
		flex-direction: column;
		align-items: center;
	}
	.edit-button, .delete-button {
		width: 100%;
	}
}

.custom-file-upload {
	display: flex;
}

.profile-photo-section {
	width: 200px;
}
/* 전체 페이지 스타일 설정 */
body {
	background-image:
		url('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D');
	width: 40%;
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f4f4f4;
	margin-left: 30%;
}

#mainbody {
	width: 90%;
	max-width: 1200px;
	margin: 40px auto;
	background-color: #fff; /* 흰색 배경 */
	padding: 20px;
	border-radius: 12px; /* 부드러운 모서리 */
	box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1); /* 가벼운 그림자 */
}

/* 프로필 헤더 영역: 사용자 이름과 사진, 수정 버튼 */
.profile-header {
	display: flex;
	width: 100%;
	align-items: center;
	border-bottom: 1px solid #ddd; /* 하단에 선 추가 */
	padding-bottom: 15px;
	margin: 0 auto;
	background-color: #fff;
	margin-top: 0px;
	align-items: center;
}

.user-info {
	margin-left: 10%;
}

/* 프로필 사진 스타일 */
.profile-header img {
	border-radius: 50%; /* 사진을 원형으로 만들기 */
	width: 100px;
	height: 100px;
}

/* 사용자 이름 스타일 */
.profile-header h2 {
	font-family: "Jua", sans-serif;
	margin: 0;
}

/* 사용자 이름을 크게 표시 */
.profile-header .username {
	font-size: 24px;
	font-weight: bold;
}

/* 회원정보수정 버튼 스타일 */
.profile-header .edit-button, .like-posts-button {
	width: 60%;
	min-width: 30px auto;
	padding: 5px 10px;
	background-color: #62b6fe; /* 버튼 배경색 설정 */
	color: white;
	border: none;
	cursor: pointer;
	border-radius: 5px;
	margin-right: 150px;
}

.delete-button {
	width: 60%;
	min-width: 30px auto;
	padding: 5px 10px;
	background-color: #62b6fe; /* 버튼 배경색 설정 */
	color: white;
	border: none;
	cursor: pointer;
	border-radius: 5px;
	margin-right: 150px;
}

.edit-comfirm {
	width: 60%;
	min-width: 30px auto;
	padding: 5px 10px;
	background-color: #62b6fe; /* 버튼 배경색 설정 */
	color: white;
	border: none;
	cursor: pointer;
	border-radius: 5px;
	margin-left: 30px;
	margin-right: 150px;
}

/* 프로필 변경 버튼 이미지 */
#profileImage {
	width: 100%;
	min-width: 50px;
	min-height: 50px;
	border-radius: 50%;
	object-fit: cover;
	cursor: pointer;
	display: flex;
	justify-content: flex-start;
	margin-left: 30px;
}
/* 파일선택 버튼 숨기기 */
#user_img {
	display: none;
	width: 100%;
}

/* 회원정보수정 버튼에 마우스를 올렸을 때 색상이 변함 */
.profile-header .edit-button:hover {
	background-color: #0056b3;
}

/* 프로필 사진 섹션 스타일 */
.profile-photo-section {
	margin-top: 20px;
}

/* 프로필 사진의 기본 스타일 */
.profile-photo-section img {
	display: block;
	margin: 0 auto;
	border-radius: 50%; /* 사진을 원형으로 */
	width: 150px;
	height: 150px;
	border: 2px solid #007BFF; /* 파란색 테두리 추가 */
}

/* 섹션 제목 스타일 (예: 획득한 뱃지, 작성한 게시글) */
.section-title {
	font-size: 20px;
	margin: 20px 0;
	border-bottom: 2px solid #007BFF;
	padding-bottom: 5px;
	display: flex;
	justify-content: space-between;
}

/* 뱃지 목록과 게시글 목록을 위한 스타일 */
.posts, .badges {
	list-style: none;
	padding: 0;
}

/* 뱃지 및 게시글 항목 각각의 스타일 */
.posts li, .badges li {
	margin: 10px 0;
	padding: 10px;
	background-color: #f9f9f9;
	border: 1px solid #ddd;
}

/* 게시글 제목 스타일 */
.posts li h3 {
	margin: 0 0 5px 0;
	font-size: 18px;
}

/* 뱃지 아이템 스타일 */
.badges li {
	display: inline-block;
	padding: 10px;
	background-color: #fff5c4;
	border-radius: 10px;
	margin-right: 10px;
}

/* 뱃지 이미지 스타일 */
.badges li img {
	width: 40px;
	height: 40px;
	vertical-align: middle;
	margin-right: 10px;
}

/* 뱃지 페이지로 이동하는 버튼 스타일 */
.badge-page-button {
	padding: 5px 15px;
	background-color: #62b6fe;
	color: white;
	border: none;
	cursor: pointer;
	border-radius: 5px;
}

/* 뱃지 페이지로 이동 버튼에 마우스를 올렸을 때 색상이 변함 */
.badge-page-button:hover {
	background-color: #0056b3;
}

.delete-button:hover {
	background-color: #0056b3;
}

/* 뒤로가기 버튼 꾸민곳 */
.profile-button {
	padding: 5px 15px;
	background-color: #62b6fe;
	color: white;
	border: none;
	cursor: pointer;
	border-radius: 5px;
	margin-right: 150px;
}

.profile-button:hover, button:hover {
	background-color: #0056b3;

	/* 뒤로가기 버튼 꾸민곳 */
}

.back-button-container {
	text-align: left;
	margin-top: 30px;
}

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

/* 9//19 13:25 작성한 게시글 css */
.board_content {
	width: 80%;
	margin: 0 auto;
	padding: 20px;
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 상자에 그림자 효과 */
	margin-top: 50px;
	border-radius: 30px; /* 컨테이너의 모서리를 둥글게 */
	/* border: 1px solid; */ /* 임시로 제작중 구분을 위해 넣음. 디자인 하는중에 제거 예정 */
}

/* 게시물 카드 스타일 */
.board_content {
	background-color: white;
	border-radius: 12px;
	padding: 20px;
	margin-bottom: 20px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
	transition: box-shadow 0.3s ease;
	/* border: 1px solid;  */ /* 임시로 제작중 구분을 위해 넣음. 디자인 하는중에 제거 예정 */
}

.board_content:hover {
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
}

.board {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 15px;
}

.left-botton, .right-botton {
	display: flex;
	align-items: center;
}

.profile, .f_bad, .f_good {
	background-color: #2E9AFE;
	color: white;
	padding: 10px 20px;
	border-radius: 30px;
	border: none;
	cursor: pointer;
	transition: background-color 0.3s ease;
	display: flex;
	align-items: center;
}

.profile i, .f_bad i, .f_good i {
	margin-right: 8px;
}

.profile:hover, .function:hover {
	background-color: #d35400;
}

/* 게시물 텍스트 스타일 */
#newContent {
	width: 90%;
	background-color: #f8f8f8;
	padding: 15px;
	border-radius: 10px;
	text-align: center;
	font-size: 16px;
	color: #7f8c8d;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

/* 해시태그 링크 */
.hashtag {
	color: #3498db;
	text-decoration: none;
	font-size: 16px;
	margin-top: 10px;
}

.hashtag:hover {
	text-decoration: underline;
}

#board_image {
	width: 100%;
	height: 300px auto;
}

/* 게시물 작성자 사진 크기 */
#profile_img {
	width: 30px;
	height: 30px;
	border-radius: 12px;
	margin-right: 10px;
}

/* 9월 24일  10시 3분 commnet, delete - comment 수정 */
.comment-profile{  
   font-family: 'TheJamsil5Bold';
   background-color: #FFFFFF;
   color: black;
   border-radius: 30px;
   border: none;
   cursor: pointer;
   transition: background-color 0.3s ease;
   display: flex;
   align-items: center;
   justify-content: space-between;
}
.delete-comment{
   font-family: 'TheJamsil5Bold';
   background-color: #2E9AFE;
   color: white;
   padding: 10px 20px;
   border-radius: 30px;
   border: none;
   cursor: pointer;
   transition: background-color 0.3s ease;
   display: flex;
   align-items: center;
   height: 30px;
}

.profile-image {
   width: 50px; /* 원하는 크기로 조절 */
   height: 50px; /* 원하는 크기로 조절 */
   border-radius: 50%; /* 원형으로 만들기 */
   box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 이미지에 그림자 추가 */
   margin-bottom: 5px; /* 이미지와 닉네임 사이 간격 */
   cursor: pointer; /* 마우스 커서 포인터로 변경 */
   margin-right: 10px; /* 프로필 이미지와 텍스트 사이 간격 */
}

.nickname {
   align-content: center;
   font-size: 14px;
   font-weight: bold; /* 닉네임 강조 */
   color: #2c3e50; /* 닉네임 색상 */
   text-align: center;
   cursor: pointer; /* 마우스 커서 포인터로 변경 */
}

.comment-text {
   flex: 1; /* 텍스트 부분을 남은 공간 모두 차지하도록 */
   background-color: #ffffff;
   padding: 10px;
   border-radius: 10px; /* 둥근 모서리 */
   box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05); /* 가벼운 그림자 */
   border: 1px solid #eee; /* 외곽선 추가 */
   line-height: 1.6; /* 텍스트 가독성을 위한 줄 간격 */
   color: #555; /* 텍스트 색상 */
}

/* 댓글 구분선 */
.comment+.comment {
   border-top: 1px solid #ddd; /* 댓글 사이 구분선 */
   margin-top: 10px; /* 댓글 사이 간격 */
   padding-top: 5px; /* 구분선과의 간격 */
}

/* 9/23 9:40 댓글 작성하기 */
.Formcomment {
   display: flex;
   align-content: center;
   justify-content: space-between;
   margin-bottom: 20px;
}

textarea {
   font-family: 'TheJamsil5Bold';
   width: 90%;
   padding: 10px;
   box-sizing: border-box;
   border: solid 2px #1E90FF;
   border-radius: 5px;
   font-size: 12px;
   resize: none;
}

/* 9/23 9:40 댓글 작성하기 버튼 스타일 */
.submitComment {
   min-width: 10px;
   background-color: #FFFFFF;
   border-color: #1E90FF;
   border-radius: 10px;
   text-align: center;
   font-size: 16px;
}
/* 9/23 9:40 댓글 작성하기 버튼 스타일 */
#Arrowcomment {
   width: 20px;
   height: 20px;
   background-color: #FFFFFF;
}
</style>
</head>
<body>
	<div id="mainbody">
		<%
   UserDTO profileLoading = (UserDTO) session.getAttribute("profileLoading");
   ProfileImgDTO loadingImg = (ProfileImgDTO) session.getAttribute("loadingImg");
   System.out.println(loadingImg.getUser_img());
   %>
		<!-- 프로필 페이지 컨테이너 시작 -->

		<button class="back-button" onclick="goMain()">←</button>
		<!-- 프로필 헤더: 프로필 사진, 사용자 정보, 회원정보 수정 버튼 -->
		<div class="profile-header">
			<div class="profile-photo-section">
				<!-- 24-09-13 오전 프로필사진로드-->
				<label for="user_img" class="custom-file-upload"> <img
					src="./file/<%=loadingImg.getUser_img()%>" id="profileImage">
				</label>
				<!-- 24-09-13 오전 프로필사진 추가 버튼 기능-->
				<br>
				<form action="ProfileImgUpdateServices.do"
					enctype="multipart/form-data" method="post">
					<input type="file" id="user_img" accept="image/*" name="user_img"
						onchange="previewImage(event)" /> <input class="edit-comfirm" type="submit"
						value="프로필변경완료">
				</form>
			</div>
			<div class="user-info">
				<h2 class="username"><%=profileLoading.getUser_nick()%></h2>
				<br>
				<!-- 회원정보 수정 버튼 -->
				<button class="edit-button" onclick="editProfile()">회원정보수정</button>
				<br> <br>
				<button class="delete-button" onclick="DeleteUser()">회원탈퇴</button>
				<br> <br>
				<!-- 내가 좋아요한 게시글 보기 버튼 추가 -->
				<button class="like-posts-button" onclick="goLikedPosts()">내가
					좋아요한 게시글 보기</button>
				<br> <br>
			</div>
		</div>


		<!-- 획득한 뱃지 섹션 -->
		<% List<BadgeDTO> badges = new BadgeDAO().loadingBadge(new UserDTO(profileLoading.getUser_id()));%>
		<div class="badges-section">
			<h3 class="section-title">
				획득한 뱃지
				<!-- 뱃지 페이지로 이동하는 버튼 -->
				<button class="badge-page-button" onclick="goToBadgePage()">뱃지
					페이지로 이동</button>
			</h3>
			<ul class="badges">
			<% for(int i = 0; i < badges.size();i++) {%>
				<li><img src="./file/<%=badges.get(i).getBg_img()%>" alt="뱃지 <%=i%>">
					<span><%=badges.get(i).getBg_name()%></span></li>
			<%} %>
			</ul>
		</div>

		<%
            	// 게시물을 불러오기
            	UserDTO vo = new UserDTO(profileLoading.getUser_id());
	            List<BoardDTO> boards = new BoardDAO().userBoard(vo);
				System.out.print(boards.size());
				pageContext.setAttribute("boards", boards);
            	
            %>



		<!-- 작성한 게시글 섹션 -->
		<div class="posts-section">
			<h3 class="section-title">작성한 게시글</h3>

			<%
      for (int i = 0; i < boards.size(); i++) {

         String user_id = boards.get(i).getUser_id();
         UserDTO dto = new UserDTO(user_id);
         UserDTO user = new UserDAO().profileLoading(dto);
         Integer b_idx = boards.get(i).getB_idx();
		 List<CommentDTO> comments = new CommentDAO().allComment(b_idx);
      %>
			<div class="board_content">
				<section class="mainbody">


					<div class="board">
						<div class="left-botton">
							<button class="profile" id="p_pic" type="submit">
								<img src="./file/<%=loadingImg.getUser_img()%>" id="profile_img">
								<i><%=user.getUser_nick()%></i>
							</button>
						</div>

						<div class="right-botton">

							<!-- 9/19 12:37 좋아요 버튼  -->
							<button class="f_good" data-bidx="<%=boards.get(i).getB_idx()%>"
								data-userid="<%=profileLoading.getUser_id()%>">
								<i class="far fa-thumbs-up"></i> <span class="likeCount"><%=boards.get(i).getB_likes()%></span>
							</button>
							<script src="script.js"></script>





						</div>

					</div>




					<div class="board_free">
						<div class="board_content_index">
							<img src="./file/<%=boards.get(i).getB_file()%>" id="board_image"><br>
							<br>
							<h1><%=boards.get(i).getB_title()%></h1>
							<br>

							<h2><%=boards.get(i).getB_content()%></h2>
							<br>
							<h2><%=boards.get(i).getCreated_at()%></h2>
							<br>

							<div>
								<%
								if (comments != null) {
									for (int j = 0; j < comments.size(); j++) {
										CommentDTO comment = comments.get(j);
										String content = comment.getCmt_content();
										String escapedContent = StringEscapeUtils.escapeHtml4(content);
										String formattedContent = escapedContent.replace("\r\n", "<br/>").replace("\n", "<br/>").replace("\r", "<br/>");
										String commenterId = comment.getUser_id(); // 댓글 작성자 ID
										UserDTO commenter = new UserDAO().profileLoading(new UserDTO(commenterId));
										ProfileImgDTO commenterIMG = new ProfileImgDAO().loadingImg(new UserDTO(commenterId));
								%>
								<div class="comment">
									<div class="comment-profile">
										<button type="submit" class="comment-profile"
											<%if (profileLoading.getUser_id().equals(comment.getUser_id())) {%>
											onclick="goProfile()" <%} else {%>
											onclick="goOtherProfile('<%=comment.getUser_id()%>')" <%}%>>
											<img src="./file/<%=commenterIMG.getUser_img()%>" alt=""
												class="profile-image"> <span class="nickname"><%=commenter.getUser_nick()%></span>
										</button>
										<%
									if (profileLoading.getUser_id().equals(comment.getUser_id())) {
									%>
									<button class="delete-comment"
										data-comment-id="<%=comment.getUser_id()%>" onclick="goDeleteCommentService('<%=comment.getCmt_idx()%>')">삭제</button>
									<%
									}
									%>
									</div>
									<div class="comment-text">
										<%=formattedContent%>
									</div>
								</div>
								<br>
								<%
								}
								}
								%>
							</div>

							<form class= "Formcomment" id="commentForm<%=i%>" method="post" accept-charset="UTF-8">
								<%
								Integer b_idxToCmt = boards.get(i).getB_idx();
								%>
								<input type="hidden" name="b_idx" value="<%=b_idxToCmt%>">
								<textarea id="newContent<%=i%>" placeholder="댓글 작성"
									name="cmt_content" onkeydown="resize(this)"
									onkeyup="resize(this)"></textarea>
								<button class= "submitComment" type="button" onclick="submitComment(<%=i%>)"><img  id="Arrowcomment"
                              src="https://cdn-icons-png.flaticon.com/512/60/60525.png"></button>
							</form>
						</div>
					</div>

					<div>
						<a href="" class="hashtag" id="h_tag" name="해시태그" type="button"><%=boards.get(i).getB_confirm_hashtag()%></a>
					</div>
				</section>
			</div>
			<%
      }
      %>

		</div>
	</div>
	<script>
        // 뱃지 페이지로 이동하는 함수
        function goToBadgePage() {
            window.location.href = "Badge.jsp"; // 여기에 실제 뱃지 페이지 URL을 입력하세요.
        }
        
        

        // 프로필 사진 미리보기 함수
        function previewImage(event) {
            var reader = new FileReader();
            reader.onload = function(){
                var output = document.getElementById('profileImage');
                output.src = reader.result; // 선택한 이미지 파일을 미리보기로 보여줌
            };
            reader.readAsDataURL(event.target.files[0]);
        }

        // 회원정보 수정 페이지로 이동하는 함수
        function editProfile() {
            alert('회원정보 수정 페이지로 이동합니다.');
            window.location.href = "Edit_user_info.jsp";
        }
        // 회원탈퇴 ~
        function DeleteUser() {
            alert('회원탈퇴 페이지로 이동합니다.');
            window.location.href = "Delete.jsp";
        }
        // 메인페이지 ~ (뒤로가기)
        function goMain() {
            alert('메인페이지로 이동합니다.');
            window.location.href = "MainPage.jsp";
        }
        function proChange() {
            alert('프로필변경');
            window.location.href = "ProfileImgInsertServices.do"; // url 입력하시는 곳
        }
         // 9/24 17:33 댓글창 프로필로 이동 
   		 function goOtherProfile(userId) {
   	         window.location.href = "OtherProfile.jsp?user_id=" + userId;
   	      }
   		function goProfile() {
            window.location.href = "ProfileLoadingService.do";
         }
   		
   		
        <!-- 24-09-13 오전 프로필사진 추가 버튼 기능-->
        // 프로필 사진 변경 관련 기능//
        const fileInput = document.getElementById('user_img');
        const profileImage = document.getElementById('profileImage');

        // 파일이 선택되면 이미지 미리보기로 변경
        fileInput.addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();

                reader.onload = function(e) {
                    profileImage.src = e.target.result;
                }

               /*  reader.readAsDataURL(file); */
            }
        });
        
    </script>

	<!--9/19 13:41 좋아요 버튼 카운트 함수  -->
	<script type="text/javascript">
	document.querySelectorAll('.f_good').forEach(button => {
	    button.addEventListener('click', function() {
	        const b_idx = this.getAttribute('data-bidx');  // 게시물 ID
	        const userId = this.getAttribute('data-userid'); // 유저 ID
	        const isLiked = this.classList.contains('liked'); // 좋아요 여부 확인

	        fetch('LikeService.do', {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/json'
	            },
	            body: JSON.stringify({
	                b_idx: b_idx,
	                user_id: userId,
	                isLiked: isLiked  // 이미 좋아요 눌렀는지 여부
	            })
	        })
	        .then(response => response.json())
	        .then(data => {
	            if (data.success) {
	                const likeCountElement = this.querySelector('.likeCount');
	                let likeCount = parseInt(likeCountElement.textContent);

	                if (isLiked) {
	                    likeCount--; // 좋아요 취소 시 감소
	                    this.classList.remove('liked');
	                } else {
	                    likeCount++; // 좋아요 추가 시 증가
	                    this.classList.add('liked');
	                }

	                likeCountElement.textContent = likeCount; // 업데이트된 좋아요 수 반영
	            }
	        })
	        .catch(error => console.error('Error:', error));
	    });
	});
</script>

	<script>
	 // 댓글 작성 바로 새로고침 09-23 오전 12시 37분 준형
	 function escapeJSONString(str) {
	    return str.replace(/\\/g, '\\\\') // 백슬래시 이스케이프
	              .replace(/"/g, '\\"')   // 따옴표 이스케이프
	              .replace(/\n/g, '\\n')  // 줄 바꿈 이스케이프
	              .replace(/\r/g, '\\r')  // 캐리지 리턴 이스케이프
	              .replace(/\t/g, '\\t');  // 탭 이스케이프
	}

	 function submitComment(index) {
		    const form = document.getElementById(`commentForm${index}`);
		    
		    const b_idx = form.querySelector('input[name="b_idx"]').value;
		    const cmt_content = form.querySelector(`textarea[name="cmt_content"]`).value;

		    const data = {
		        b_idx: b_idx,
		        cmt_content: escapeJSONString(cmt_content)
		    };

		    fetch('CommentService.do', {
		        method: 'POST',
		        headers: {
		            'Content-Type': 'application/json; charset=UTF-8'
		        },
		        body: JSON.stringify(data)
		    })
		    .then(response => response.json())
		    .then(data => {
		        if (data.success) {
		            const commentSection = document.querySelectorAll('.board_content_index')[index].querySelector('div'); // 댓글 추가할 영역
		            const newComment = document.createElement('div');

		            // 댓글 작성자 정보 추가
		            newComment.innerHTML = `
		                <div class="comment">
		                    <div class="comment-profile">
		                        <img src="./file/${data.commenterIMGImage}" alt="" class="profile-image" style="width: 50px; height: 50px;">
		                        <span class="nickname">${data.commenterNickname}</span>
		                    </div>
		                    <div class="comment-text">${data.newComment}</div>
		                </div>
		                <br>
		            `;
		            commentSection.appendChild(newComment);
		            form.reset();
		        } else {
		            alert('댓글 작성에 실패했습니다.');
		        }
		    })
		    .catch(error => console.error('Error:', error));
		}

	 
	// 내가 좋아요한 게시글 페이지로 이동하는 함수
		/* 9/24 10:09 */
		 function goLikedPosts() {
		     window.location.href = "MyLikedPosts.jsp"; // 실제 내가 좋아요한 게시글 페이지 URL로 변경 필요
		 }
	   </script>

</body>
</html>