<%@page import="com.doo.model.LikeDTO"%>
<%@page import="com.doo.model.LikeDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="com.doo.model.BoardDTO"%>
<%@ page import="com.doo.model.BoardDAO"%>
<%@ page import="com.doo.model.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내가 좋아요한 게시글</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        #main {
            width: 70%;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
        }
        .section-title {
            font-size: 24px;
            margin-bottom: 20px;
            border-bottom: 2px solid #007BFF;
            padding-bottom: 10px;
        }
        .post-card {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s ease;
        }
        .post-card:hover {
            box-shadow: 0px 4px 16px rgba(0, 0, 0, 0.15);
        }
        .post-title {
            font-size: 20px;
            margin-bottom: 10px;
        }
        .post-content {
            font-size: 16px;
            color: #555;
        }
        
        .post-image {
        	width: 100%;
			height: 300px auto;
        }
        
        .back-button {
            padding: 10px 20px;
            background-color: #62b6fe;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
            margin-top: 20px;
        }
        .back-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div id="main">
        <h2 class="section-title">내가 좋아요한 게시글</h2>
        
        <%
            // 사용자 정보를 세션에서 가져옴
            UserDTO profileLoading = (UserDTO) session.getAttribute("profileLoading");
            String user_id = profileLoading.getUser_id(); // 사용자 ID 가져오기
			
            UserDTO vo = new UserDTO(user_id);
            // 사용자 ID 확인을 위한 디버그 출력
            System.out.println("User ID: " + user_id); 
            
            // 사용자 ID로 좋아요한 게시글 가져오기
            List<LikeDTO> likes = new LikeDAO().selectLikeBoard(vo);
            
            // JSP 페이지에 데이터 출력
            if (likes == null || likes.isEmpty()) {
                out.println("<p>좋아요한 게시글이 없습니다.</p>");
            } else {
            	
            	
            
                for (LikeDTO like : likes) {
                	
                	BoardDTO dto = new BoardDTO(like.getB_idx());
                	BoardDTO post = new BoardDAO().likedPosts(dto);
      	
        %>
			            <div class="post-card">
			                <div class="post-title"><%= post.getB_title() %></div>
			                <div class="post-content">글쓴이: <%=post.getUser_id()%></div>
			                <div class="post-image"><img class="post-image" alt="" src="./file/<%=post.getB_file()%>"></div>
			                <div class="post-content"><%= post.getB_content() %></div>
			                <div class="post-date">작성일: <%= post.getCreated_at() %></div>
			            </div>
        <%
                }
            }
        %>
        
        <button class="back-button" onclick="goBack()">뒤로가기</button>
    </div>
    
    <script>
        function goBack() {
            window.location.href = "Profile.jsp"; // 실제 프로필 페이지 경로로 변경 필요
        }
    </script>
</body>
</html>