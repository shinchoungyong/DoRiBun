<%@page import="com.doo.model.BoardDTO"%>
<%@page import="com.doo.model.BoardDAO"%>
<%@page import="com.doo.model.ReportDAO"%>
<%@page import="com.doo.model.ReportDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@font-face {
	font-family: 'TheJamsil5Bold';
	src:
		url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2')
		format('woff2');
	font-weight: 500;
	font-style: normal;
}

h1, caption, input, td {
	font-family: 'TheJamsil5Bold';
}

body {
	background-color: #F3F4F9;
	margin: 0;
	padding: 0;
	font-family: Verdana, Geneva, Tahoma, sans-serif;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

#Report-container {
	padding: 40px 80px;
	width: 800px;
	background-color: #FFFFFF;
	border-radius: 30px;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
	text-align: center;
}

#header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

#back {
	background-color: lightskyblue;
	color: white;
	border: none;
	padding: 10px 20px;
	cursor: pointer;
	border-radius: 5px;
}

h1 {
	color: lightskyblue;
	font-size: 2em;
	font-weight: 500;
	margin: 0;
}

table {
	border: 3px solid lightskyblue;
	border-radius: 3px;
	width: 100%;
	margin-top: 20px;
	text-align: center;
	border-collapse: collapse;
}

table td {
	padding: 8px;
	border: 3px solid lightskyblue;
}

caption {
	border: none;
	font-size: 2em;
	padding: 10px 50px;
	cursor: pointer;
	color: lightskyblue;
}

input[type="button"] {
	border: none;
	font-size: 1em;
	padding: 10px 30px;
	cursor: pointer;
	background-color: #FF4B5E;
	border-radius: 3px;
	color: white;
}
</style>
</head>
<body>
	<div id="Report-container">
		<div id="header">
			<h1>신고내역</h1>
			<input type="button" id="back" name="back" value="되돌아가기"
				onclick="goMain()">
		</div>
		<table>
			<caption>신고내역</caption>
			<tr>
				<td>신고받은아이디</td>
				<td>글제목</td>
				<td>신고한아이디</td>
				<td>신고사유</td>
				<td>신고날짜</td>
			</tr>

			<%
			// 세션에서 allreports 리스트를 가져옴
			List<ReportDTO> reports = (List<ReportDTO>) session.getAttribute("allreports");
			if (reports != null) {
				for (ReportDTO report : reports) {

					// 현재 report 객체의 b_idx(글 식별자)를 가져옴
					Integer b_idx = report.getB_idx();

					// BoardDTO 객체를 생성하여, 글 식별자(b_idx)를 전달
					BoardDTO dto = new BoardDTO(b_idx);

					// BoardDAO의 BringIndex 메서드를 통해 해당 글의 정보를 가져옴 (vo로 저장)
					BoardDTO vo = new BoardDAO().BringIndex(dto);
			%>
			<tr>
				<td><%=vo.getUser_id()%></td>
				<td><%=vo.getB_title()%></td>
				<td><%=report.getUser_id()%></td>
				<td><%=report.getReport_reason()%></td>
				<td><%=report.getReported_at()%></td>
			</tr>
			<%
			}
			} else {
			%>
			<tr>
				<td colspan="5">신고 내역이 없습니다.</td>
			</tr>
			<%
			}
			%>

		</table>
		<script type="text/javascript">
			function goMain() {
				alert('메인페이지로 이동합니다.');
				window.location.href = "MainPage.jsp";
			}
		</script>
</body>
</html>