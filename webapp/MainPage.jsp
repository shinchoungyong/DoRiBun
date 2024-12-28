<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>
<%@page import="com.doo.model.CommentDAO"%>
<%@page import="com.doo.model.CommentDTO"%>
<%@page import="com.doo.model.ProfileImgDAO"%>
<%@page import="com.doo.model.ProfileImgDTO"%>
<%@page import="com.doo.model.UserDTO"%>
<%@page import="com.doo.model.UserDAO"%>
<%@page import="com.doo.model.BoardDAO"%>
<%@page import="com.doo.model.BoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>두리번</title>
<style>
/* Google 폰트 */
@import
   url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap')
   ;

@import
   url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css')
   ;
   
@font-face {
    font-family: 'HakgyoansimDunggeunmisoTTF-B';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2408-5@1.0/HakgyoansimDunggeunmisoTTF-B.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}

@font-face {
    font-family: 'TheJamsil5Bold';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2') format('woff2');
    font-weight: 500;
    font-style: normal;
}

body {
   background-image : url('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D');

   font-family: 'Poppins', sans-serif; /* 현대적인 폰트 */
   margin: 0;
   padding: 0;
   background-color: #f7f7f7; /* 밝은 배경 색상 */
   color: #333; /* 기본 텍스트 색상 */
   line-height: 1.6;
   width: 40%;
   margin-left: 30%;
   
}

/* 메인 컨테이너 */
#mainbody {
   width: 90%;
   max-width: 1200px;
   margin: 40px auto;
   background-color: #fff; /* 흰색 배경 */
   padding: 20px;
   border-radius: 12px; /* 부드러운 모서리 */
   box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1); /* 가벼운 그림자 */
}
/* 로고 사이즈 */
#doribun_logo{
   width : 150px;
   height : 150px;
   margin-left: 10px;

}

/* 헤더 */
#LayoutHeader {
   width: 92%;
   height: 100px auto;
   display: flex;
   align-items: center;
   justify-content: space-between;
   background-color: #A9E2F3; /* 메인 색상 */
   color: white;
   border-radius: 12px 12px 0 0;
   padding: 20px;
   font-weight: 600;
}

/* 네비게이션 바 */
.Layouttop {
   width: 92%;
   display: flex;
   align-items: center;
   justify-content: flex-end;
   background-color: #A9E2F3; /* 메인 색상 */
   color: white;
   border-radius: 0 0 12px 12px;
   padding: 20px;
   font-weight: 600;
   background-color: #A9E2F3;
   justify-content: flex-end;
}
/* 9/19 11:40 css버튼 변경 */
.profile-button, .message-button, .logout-button, #addBoard, #address,
   .Admin {
   background-color: #000000; /* 상단버튼색상*/
   color: white;
   padding: 10px 20px;
   border: none;
   border-radius: 30px;
   cursor: pointer;
   font-size: 14px;
   font-weight: 500;
   transition: background-color 0.3s ease;
   box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 버튼 그림자 */
   margin-left: 10px;
   margin-bottom: 10px;
}

button:hover:not(.submitComment), form a:hover {
   background-color: red;
}

/* 검색창 스타일 */
.searchtab {
   width: 100%;
   display: flex;
   justify-content: center;
   margin: 30px 0;
}

input[type="text"] {
   width: 80%;
   max-width: 700px;
   padding: 15px 20px;
   font-size: 16px;
   border-radius: 30px;
   border: 1px solid #ddd;
   box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05); /* 가벼운 그림자 */
   transition: box-shadow 0.3s ease;
}

input[type="text"]:focus {
   outline: none;
   box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

/* 게시물 추가 버튼 */
#addBoard {
   border-radius: 50%;
   font-size: 20px;
   margin-top: 10px;
   margin-bottom: 20px;
   align-content: center;
   margin-left: 45%;
   /* 9/19 12:11 */
   width: 50px 100%;
   height: 50px 100%;
}

/* 게시물 카드 스타일 */
.board_content {
   font-family: 'TheJamsil5Bold';
   background-color: white;
   border-radius: 12px;
   padding: 20px;
   margin-bottom: 20px;
   box-shadow: 0 6px 10px rgba(0, 0, 0, 0.1);
   transition: box-shadow 0.3s ease;
   /* border: 1px solid; */ /* 임시로 제작중 구분을 위해 넣음. 디자인 하는중에 제거 예정 */
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

.profile{
   font-family: 'TheJamsil5Bold';
   font-size : 16px;
   background-color: #FFFFFF;
   color: black;
   padding: 10px 20px;
   border-radius: 30px;
   border: none;
   cursor: pointer;
   transition: background-color 0.3s ease;
   display: flex;
   align-items: center;
   
}



.f_bad, .f_good {
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

/* 반응형 디자인 */
@media screen and (max-width: 768px) {
   #mainbody {
      width: 95%;
   }
   .Layouttop {
      flex-direction: column;
      gap: 10px;
   }
   button {
      width: 100%;
      margin-top: 10px;
   }
}

/* 푸터 스타일 */
footer {
   text-align: center;
   padding: 20px 0;
   color: #aaa;
   font-size: 14px;
}

/* GPS주소 텍스트 스타일임당 */
body {
   font-family: Arial, sans-serif;
   text-align: left;
   padding: 20px;
}

h1 {
   color: #333;
}

#address {
   margin-top: 20px;
   font-size: 10px;
   font-weight: bold;
} /* 쪽지 추가 버튼 */
nav {
   position: relative;
}

#menuButton {
   padding: 10px 20px;
   font-size: 16px;
   cursor: pointer;
}

#menu {
   position: absolute;
   top: 40px;
   left: 0;
   width: 200px;
   background-color: #f9f9f9;
   border: 1px solid #ddd;
   padding: 10px;
   display: none;
}

#menu ul {
   list-style: none;
   padding: 0;
}

#menu ul li {
   margin: 10px 0;
}

#menu ul li a {
   text-decoration: none;
   color: #333;
}

.hidden {
   display: none;
}
/* 9/19 12:10  */
/* 게시물 작성자 사진 크기 */
#profile_img {
   width: 30px;
   height: 30px;
   border-radius: 12px;
   margin-right: 10px;
}

/* 9/19 3:23 메세지 메뉴 버튼 생성 및 스타일설정 */
/* message-menu 버튼 공통 스타일 */
.message-menu {
   background-color: highlighttext; /* 버튼 기본 배경색 (녹색) */
   color: black; /* 텍스트 색상 */
   padding: 12px 20px; /* 버튼 내부 패딩 */
   border: none; /* 테두리 제거 */
   border-radius: 30px; /* 둥근 모서리 */
   cursor: pointer; /* 마우스 커서 포인터로 변경 */
   font-size: 16px; /* 글자 크기 */
   font-weight: 600; /* 글자 굵기 */
   transition: background-color 0.3s ease, box-shadow 0.3s ease, transform
      0.3s ease; /* 부드러운 전환 효과 */
   box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* 기본 그림자 */
   margin: 10px 0; /* 상하 여백 */
   width: 100%; /* 버튼 너비 100% */
   display: flex; /* 아이콘과 텍스트 정렬을 위한 flex 사용 */
   align-items: center; /* 아이콘과 텍스트 수직 가운데 정렬 */
   justify-content: center; /* 아이콘과 텍스트 수평 가운데 정렬 */
   text-align: center; /* 텍스트 가운데 정렬 */
   gap: 8px; /* 아이콘과 텍스트 사이 간격 */
}

/* 아이콘과 텍스트 스타일 */
.message-menu i {
   font-size: 18px; /* 아이콘 크기 */
}

/* 호버 효과 */
.message-menu:hover {
   background-color: #45A049; /* 호버 시 배경색 변화 */
   box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15); /* 호버 시 그림자 증가 */
   transform: translateY(-2px); /* 호버 시 살짝 위로 이동 */
}

/* 클릭 효과 */
.message-menu:active {
   background-color: #388E3C; /* 클릭 시 배경색 변화 */
   transform: translateY(0); /* 클릭 시 원래 위치로 */
   box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* 클릭 시 그림자 원래대로 */
}

/* 댓글 프로필 */

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

button.submitComment:hover{
 background-color: white;
}

</style>

</head>
<body>

	<div id="mainbody">

		<div id="coordinates"></div>
		<div id="map"></div>

		<!-- 9/19 GPS 텍스트 표출 -->
		<button id="address" onclick="goLocation()">내 위치 찾기 !</button>
		<!-- 헤더 -->
		<header id="LayoutHeader">
			<img id="doribun_logo" src="./file/두리번 로고.png">
		</header>


		<!-- 상단 네비게이션 바 -->
		<nav id="Layouttop-section">
			<div class="Layouttop">
				<!-- 24.09.12 input을 button으로 변경, onclick 및 함수 생성  -->
				<%
				UserDTO loginMember = (UserDTO) session.getAttribute("loginMember");
				System.out.println("A".equals(loginMember.getUser_type()));
				%>

				<!-- 유저의 타입이 'A'일 경우 회원수정 버튼 추가 -->
				<%
				if ("A".equals(loginMember.getUser_type())) {
				%>
				
				<input type="text" id="b_title" value="Test Title" hidden> <input
					type="text" id="user_id" value="user123" hidden> <input
					type="text" id="report_reason" value="Inappropriate content" hidden>
				<input type="date" id="reported_at" name="reported_at" value="24-09-25" hidden>

				<button class="Admin" id="Admin" onclick="goShowReport()">
					<i class="fas fa-exclamation-circle"></i>
				</button>
				
				<button class="Admin" id="Admin" onclick="goModifyUser()">
					<i class="fas fa-user-edit"></i>
				</button>
				<%
				}
				%>


				<!-- 프로필 이동 버튼  -->
				<button class="profile-button" id="profile" onclick="goProfile()">
					<i class="fas fa-user"></i>
				</button>

				<!-- 메세지 이동 버튼  -->
				<!-- 9/19 12:50 -->
				<!-- 9/19 2: 메뉴 내부 버튼 눌렀을 때 이동 온클릭 함수로 구현 -->
				<nav>
					<button class="message-button" id="message">
						<i class="fas fa-envelope"></i>
						<!--style 부분에 @import url에서 그림 및 글자체 가져오는 것  -->
					</button>
					<div id="menu" class="hidden">
						<ul>
							<button class="message-menu" onclick="goSend()">
								<i class="fas fa-paper-plane"></i>
							</button>
							<button class="message-menu" onclick="goReceive()">
								<i class="fas fa-inbox"></i>
							</button>
						</ul>
					</div>
				</nav>

				<!-- 로그아웃 이동 버튼  -->
				<button class="logout-button" id="logout" onclick="goLogin()">
					<i class="fas fa-sign-out-alt"></i>
				</button>

			</div>
		</nav>

		<!-- -------------------------------------- 상단(헤더,네브) 구분 표시 선---------------------------------------------------------------- -->
		<!-- 검색창 -->
		<!-- 9/19 3:55 해시태그 검색 기능 추가 -->
		<div class="searchtab">
			<form action="" method="post">
				<input type="text" id="hashtagSearch" placeholder="#해시태그검색">
			</form>
		</div>

		<hr>

		<!-- 24-09-13 오전 게시물 추가 버튼 -->
		<div class="addBoard">
			<button id="addBoard" onclick="goBoard()">+</button>
		</div>

		<hr>
		<!-- -------------------------------------- 검색창, 게시물 추가 구분 표시 선 ------------------------------------------------------------ -->
		<!-- 게시물 콘텐츠  -->

		<%
		List<BoardDTO> boards = new BoardDAO().allBoard();
		System.out.print(boards.size());
		pageContext.setAttribute("boards", boards);
		%>
		<main id="main">


			<!-- 게시물 A -->
			<%
			for (int i = 0; i < boards.size(); i++) {

				String user_id = boards.get(i).getUser_id();
				UserDTO dto = new UserDTO(user_id);
				UserDTO user = new UserDAO().profileLoading(dto);
				ProfileImgDTO profileImg = new ProfileImgDAO().loadingImg(dto);
				Integer b_idx = boards.get(i).getB_idx();
				List<CommentDTO> comments = new CommentDAO().allComment(b_idx);
			%>
			<div class="board_content">
				<section class="mainbody">

					<div class="board">
						<div class="left-botton">
							<button class="profile" id="p_pic" type="submit"
								<%if (loginMember.getUser_id().equals(user_id)) {%>
								onclick="goProfile()" <%} else {%>
								onclick="goOtherProfile('<%=user_id%>')" <%}%>>
								<img src="./file/<%=profileImg.getUser_img()%>" id="profile_img">
								<i><%=user.getUser_nick()%></i>
								<%
								request.setAttribute("user_id", user_id);
								%>
							</button>
						</div>

						<div class="right-botton">

							<!-- 9/19 12:37 좋아요 버튼  -->
							<button class="f_good" data-bidx="<%=boards.get(i).getB_idx()%>"
								data-userid="<%=loginMember.getUser_id()%>">
								<i class="far fa-thumbs-up"></i> <span class="likeCount"><%=boards.get(i).getB_likes()%></span>
							</button>
							<script src="script.js"></script>



							<!-- 9/19 10:32 신고버튼 폼 -> 온클릭함수 사용하게 변경 -->
							<button class="f_bad" type="submit"
								onclick="goReport('<%=b_idx%>')">
								<i class="far fa-flag"></i>
							</button>

						</div>

					</div>

					<div class="board_free">
						<div class="board_content_index">
							<img src="./file/<%=boards.get(i).getB_file()%>" id="board_image"><br>
							<br>
							<h1><%=boards.get(i).getB_title()%></h1>
							<br>

							<h3><%=boards.get(i).getB_content()%></h3>
							<br>
							<h5><%=boards.get(i).getCreated_at()%></h5>
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
										<!--  -->
										<button type="submit" class="comment-profile"
											<%if (loginMember.getUser_id().equals(comment.getUser_id())) {%>
											onclick="goProfile()" <%} else {%>
											onclick="goOtherProfile('<%=comment.getUser_id()%>')" <%}%>>
											<img src="./file/<%=commenterIMG.getUser_img()%>" alt=""
												class="profile-image"> <span class="nickname"><%=commenter.getUser_nick()%></span>
										</button>
									<!-- 9/23 19:32 댓글 삭제 버튼 추가 -->
									<!-- 22:00 자기가 쓴 댓글만 삭제 버튼 나오기 -->
									<%
									if (loginMember.getUser_id().equals(comment.getUser_id())) {
									%>
									<button class="delete-comment"
										data-comment-id="<%=comment.getUser_id()%>" onclick="goDeleteCommentService('<%=comment.getCmt_idx()%>')">삭제</button>
									<%
									}
									%>
									<!-- ---------------------------- -->
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

							<form class="Formcomment" id="commentForm<%=i%>" method="post"
								accept-charset="UTF-8">
								<%
								Integer b_idxToCmt = boards.get(i).getB_idx();
								%>
								<input type="hidden" name="b_idx" value="<%=b_idxToCmt%>">
								<textarea id="newContent<%=i%>" placeholder="댓글 작성"
									name="cmt_content" onkeydown="resize(this)"
									onkeyup="resize(this)"></textarea>
								<button class="submitComment" type="button"
									onclick="submitComment(<%=i%>)">
									<img id="Arrowcomment"
										src="https://cdn-icons-png.flaticon.com/512/60/60525.png">
								</button>
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

		</main>


		<!-- 푸터 -->
		<footer> &copy; 2024 핵심프로젝트 2팀 Doribun. </footer>
	</div>

	<script>
      function goRecieve() {
         window.location.href = "Receive.jsp";
      }

      function goProfile() {
         window.location.href = "ProfileLoadingService.do";
      }

      function goLogin() {
         alert('로그아웃되었습니다.');
         window.location.href = "LoginMain.jsp";
      }

      function goBoard() {
         window.location.href = "BoardContent.jsp";
      }
      function goLocation() {
         window.location.href = "googlemaps.jsp";
      }
      /* 9/19 12:10 신고버튼 활성화 */
       function goReport(b_idx) {
         window.location.href = "Report.jsp?b_idx=" + b_idx;
      }
      function goSend() {
         window.location.href = "Send.jsp";
      }
      function goReceive() {
         window.location.href = "Receive.jsp";
      }
      // 회원정보 삭제 페이지 이동 함수
		function goModifyUser() {
			window.location.href = "ShowUser.jsp";
		}
	  // 9/23 18:39 댓글창 타인 프로필로 이동 
		 function goOtherProfile(userId) {
	         window.location.href = "OtherProfile.jsp?user_id=" + userId;
	      }
		
	// 댓글 삭제 서비스 이동
	function goDeleteCommentService(cmt_idx) {
	         window.location.href = "DeleteCommentService.do?cmt_idx=" + cmt_idx;
	      }
    //신고내역 페이지 이동 함수
 	function goShowReport(){
	    window.location.href = "ShowAllReportService.do"
 }
   
   
   </script>

	<!-- 9월 19일 9:29 GPS 본인주소 텍스트 메인페이지에 띄우기 -->

	<script>
      var geocoder; // Reverse Geocoding을 위한 Geocoder 객체

      // 페이지 로드 시 자동으로 위치 정보를 가져오기
      window.onload = function() {
         getLocation();
      };

      function getLocation() {
         if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showPosition,
                  showError);
         } else {
            document.getElementById("address").innerHTML = "이 브라우저는 위치 정보를 지원하지 않습니다 ㅜㅜ";
         }
      }

      function showPosition(position) {
         var latitude = position.coords.latitude;
         var longitude = position.coords.longitude;

         // 9/19 주소 변환 (Reverse Geocoding)
         getAddress(latitude, longitude);
      }

      function showError(error) {
         switch (error.code) {
         case error.PERMISSION_DENIED:
            document.getElementById("address").innerHTML = "사용자가 위치 정보 제공을 거부했습니다 ㅜ";
            break;
         case error.POSITION_UNAVAILABLE:
            document.getElementById("address").innerHTML = "위치 정보를 사용할 수 없습니다 ㅜ";
            break;
         case error.TIMEOUT:
            document.getElementById("address").innerHTML = "위치 정보를 가져오는 데 시간이 초과되었습니다 ㅜ";
            break;
         case error.UNKNOWN_ERROR:
            document.getElementById("address").innerHTML = "알 수 없는 오류가 발생했습니다 ㅜㅜ";
            break;
         }
      }

      function getAddress(lat, lng) {
         // 9/19 Geocoding API사용 -- 좌표를 주소로 변환
         geocoder = new google.maps.Geocoder();
         var latlng = {
            lat : parseFloat(lat),
            lng : parseFloat(lng)
         };
         geocoder
               .geocode(
                     {
                        'location' : latlng
                     },
                     function(results, status) {
                        if (status === 'OK') {
                           if (results[0]) {
                              document.getElementById("address").innerHTML = "지도 보기 : "
                                    + results[0].formatted_address;
                           } else {
                              document.getElementById("address").innerHTML = "내위치를 찾을 수 없습니다 ㅜ";
                           }
                        } else {
                           document.getElementById("address").innerHTML = "내위치 요청에 실패했습니다 ㅜ: "
                                 + status;
                        }
                     });
      }

      
      </script>
	<!-- 9/19 9:54 Google Maps API, 앱키 입력-->
	<!-- 앱키  AIzaSyCkMKSuFICn4ZYgCu-u50vBYzXmLSj8Tuo  입니다 -->
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCkMKSuFICn4ZYgCu-u50vBYzXmLSj8Tuo"></script>






	<!-- 9/19 10:32 쪽찌 보내기/받기 버튼 구현  -->
	<script>
      document.getElementById('message').addEventListener('click',
            function() {
               var menu = document.getElementById('menu');
               if (menu.classList.contains('hidden')) {
                  menu.classList.remove('hidden');
                  menu.style.display = 'block';
               } else {
                  menu.classList.add('hidden');
                  menu.style.display = 'none';
               }
            });
      
   // 9/19 3:55 해시태그 검색 기능 추가
      document.getElementById('hashtagSearch').addEventListener('input', function() {
          let searchTag = this.value.trim().toLowerCase(); // 입력된 해시태그 값 (소문자로 변환)
          filterPosts(searchTag); // 게시물 필터링 함수 호출
      });

      function filterPosts(tag) {
          document.querySelectorAll('.board_content').forEach(post => {
              let postTags = post.querySelectorAll('.hashtag'); // 게시물에 포함된 해시태그들
              let tagsArray = Array.from(postTags).map(tagElement => tagElement.innerText.toLowerCase()); // 해시태그를 배열로 변환

              // 게시물에 입력된 해시태그가 포함되어 있는지 확인
              if (tagsArray.some(t => t.includes(tag))) {
                  post.style.display = 'block'; // 포함되어 있으면 표시
              } else {
                  post.style.display = 'none'; // 포함되어 있지 않으면 숨김
              }
          });
      }
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
		                <div class="incomment">
		                    <div class="incomment-profile">
		                        <img src="./file/${data.commenterIMGImage}" alt="" class="profile-image" style="width: 50px; height: 50px;">
		                        <span class="nickname">${data.commenterNickname}</span>
		                    </div>
		                    <div class="incomment-text">${data.newComment}</div>
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

	   </script>

	<!-- 9/23 19:32 댓글 삭제 버튼 추가 -->
	<script>
		// 댓글 삭제 버튼 클릭 이벤트 처리
		document.querySelectorAll('.delete-comment').forEach(button => {
  	     button.addEventListener('click', function() {
        const commentId = this.getAttribute('data-comment-id');
        // 여기에서 댓글 삭제 요청을 서버로 보낼 수 있습니다.
        alert('삭제할 댓글 ID: ' + commentId);
        // AJAX 요청을 통해 서버에 댓글 삭제 요청을 보낼 수 있습니다.
    });
});
</script>


</body>
</html>