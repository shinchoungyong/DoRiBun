package com.doo.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doo.frontcontroller.Command;
import com.doo.model.BoardDAO;
import com.doo.model.BoardDTO;
import com.doo.model.UserDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


public class BoardUploadService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		// 파일 업로드를 위한 변수 설정
				// 1. request 객체
				// 2. 파일을 저장할 경로(String)
				String savePath = request.getServletContext().getRealPath("./file");
				System.out.println("savePath : " + savePath);

				// 3. 파일 최대크기(int)
				int maxSize = 1024 * 1024 * 10;

				// 4. 인코딩 방식(String)
				String encoding = "UTF-8";

				// 5. 파일이름 중복제거
				DefaultFileRenamePolicy rename = new DefaultFileRenamePolicy();

				// 파일 업로드 해주는 객체 -> MultipartRequest
				MultipartRequest multi;
				
				try {
					multi = new MultipartRequest(request, savePath, maxSize, encoding, rename);
					// 요청 데이터 받아오기
					HttpSession session = request.getSession();
					UserDTO loginMember = (UserDTO)session.getAttribute("loginMember");
					if(loginMember == null)
					{
						System.out.println("null이죠? ㅋㅋㅋㅋ");
					}
					String b_title = multi.getParameter("b_title");
					if(b_title == null)
					{
						System.out.println("b_title null이죠? ㅋㅋㅋㅋ");
					}
					String user_id = loginMember.getUser_id();
					String b_file = multi.getFilesystemName("b_file");
					String b_content = multi.getParameter("b_content");
					if(b_content == null)
					{
						System.out.println("b_content null이죠? ㅋㅋㅋㅋ");
					}
					String b_confrim_hashtag = multi.getParameter("b_confirm_hashtag");
					if(b_confrim_hashtag == null)
					{
						System.out.println("b_confrim_hashtag null이죠? ㅋㅋㅋㅋ");
					}
					BoardDTO vo = new BoardDTO(b_title, b_content, b_file, user_id,b_confrim_hashtag);
					System.out.println(vo.toString());
					// DB에 넣어주기
					int cnt = new BoardDAO().uploadBoard(vo);
					
					if (cnt > 0) {
						System.out.println("게시글 작성 성공");
					} else {
						System.out.println("게시글 작성 실패");
					}
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				// response.sendRedirect("BoardMain.jsp");

				return "MainPage.jsp";
			}
}

