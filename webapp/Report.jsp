<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고 페이지</title>
<style type="text/css">
/* 기존 스타일 유지 */

@font-face {
	font-family: 'TheJamsil5Bold';
	src:
		url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2')
		format('woff2');
	font-weight: 500;
	font-style: normal;
}

body {
   background-color: #F3F4F9;
   margin: 0;
   padding: 0;
   font-family: Arial, sans-serif;
   display: flex;
   justify-content: center;
   align-items: center;
   height: 100vh;
}

.container {
   padding: 40px 60px;
   width: 300px;
   background-color: #FFFFFF;
   border-radius: 30px;
   box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
   text-align: left;
}

h1 {
   color: #FF4B5E;
   font-size: 2em;
   font-weight: 500;
   margin-bottom: 20px;
   text-align: center;
}

label {
   display: block;
   text-align: center;
   margin-bottom: 5px;
}

.form {
   margin-bottom: 20px;
}

table {
   border-collapse: collapse;
   width: 100%;
}

th, td {
   display: block;
   margin: 0 auto 20px;
   border: 1px solid #E5E9F5;
   background-color: #F6F7FA;
   padding: 15px;
   border-radius: 5px;
   width: calc(100% - 40px);
   font-size: 1em;
}

td input[type="checkbox"] {
   margin-right: 8px;
}

.editable {
   display: none; /* 기본적으로 숨김 */
   margin-top: 8px;
   width: 100%; /* 입력 필드가 셀의 전체 너비를 차지하도록 */
}

#submit-button {
   display: block;
   margin: 0 auto 20px;
   padding: 10px 20px;
   border: none;
   background-color: #f30000;
   color: white;
   border-radius: 4px;
   cursor: pointer;
   font-size: 16px;
}

#submit-button:hover {
   background-color: #ff6678;
}

/* 뒤로가기 버튼 꾸민곳 */
#back-button-container {
   display: flex;
   margin-left: 0px;
   text-align: left;
   margin-top: 30px;
}

#back-button {
   padding: 10px 20px;
   background-color: #f30000;
   color: white;
   border: none;
   cursor: pointer;
   border-radius: 5px;
   font-size: 16px;
}

#back-button:hover {
   background-color: #0056b3;
}
</style>
</head>

<body>
   <div class="container">
      <!-- 메인메뉴로 돌아가기 버튼 -->
      <button id="back-button" onclick="goMain()">←</button>
      <h1>신고</h1>
      <form action="ReportService.do" method="post">

         <% 
         	Integer b_idx = Integer.parseInt(request.getParameter("b_idx"));
         	System.out.println("Report.jsp의 b_idx : "+ b_idx);
         	session.setAttribute("b_idx", String.valueOf(b_idx)); %>
         <div class="form">
            <label align="center"></label>
            <table>
               <tr>
                  <td><input type="checkbox" name="reportReason" value="스팸/홍보게시물입니다" class="report-checkbox">스팸/홍보게시물입니다</td>
               </tr>
               <tr>
                  <td><input type="checkbox" name="reportReason" value="개인정보 노출 게시물입니다" class="report-checkbox">개인정보 노출 게시물입니다</td>
               </tr>
               <tr>
                  <td><input type="checkbox" name="reportReason" value="음란물 게시물입니다" class="report-checkbox">음란물 게시물입니다</td>
               </tr>
               <tr>
                  <td><input type="checkbox" name="reportReason" value="욕설/혐오표현 게시물입니다" class="report-checkbox">욕설/혐오표현 게시물입니다</td>
               </tr>
               <tr>
                  <td>
                     <input type="checkbox" name="reportReason" value="기타" id="other-checkbox" class="report-checkbox">기타
                     <input type="text" name="otherReason" id="other-input" class="editable" placeholder="기타를 입력하세요">
                  </td>
               </tr>
            </table>
         </div>
         <button type="submit" id="submit-button">신고하기</button>
      </form>
   </div>

   <script>
      // 기타 체크박스와 입력 필드 관련 스크립트
      const otherCheckbox = document.getElementById('other-checkbox');
      const otherInput = document.getElementById('other-input');
      const reportCheckboxes = document.querySelectorAll('.report-checkbox');

      // 체크박스 중복 선택 방지 (9/23 12:43 신고 중복 불가능)
      reportCheckboxes.forEach(checkbox => {
         checkbox.addEventListener('change', function() {
            if (this.checked) {
               reportCheckboxes.forEach(cb => {
                  if (cb !== this) cb.checked = false; // 다른 체크박스 비활성화
               });

               if (this === otherCheckbox) {
                  otherInput.style.display = 'inline';
                  otherInput.focus();
               } else {
                  otherInput.style.display = 'none';
               }
            }
         });
      });

      // 메인 페이지로 돌아가는 함수
      function goMain() {
         alert('메인페이지로 이동합니다.');
         window.location.href = "MainPage.jsp";
      }
   </script>
</body>
</html>