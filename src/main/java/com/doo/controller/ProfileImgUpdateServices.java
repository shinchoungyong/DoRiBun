package com.doo.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doo.frontcontroller.Command;
import com.doo.model.ProfileImgDAO;
import com.doo.model.ProfileImgDTO;
import com.doo.model.UserDAO;
import com.doo.model.UserDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


public class ProfileImgUpdateServices implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		// 파일 업로드를 위한 변수 설정
		// 1. request 객체
		// 2. 파일을 저장할 경로(String)
		String savePath = request.getServletContext().getRealPath("./file");
		System.out.println("savePath : " + savePath);
		
		// 파일이 저장될 서버의 경로를 설정 (웹 애플리케이션 내의 파일 디렉토리)
        File saveDir = new File(savePath);

        // 디렉터리가 존재하지 않으면 생성
        if (!saveDir.exists()) {
            saveDir.mkdirs();
        }

		// 3. 파일 최대크기(int)
		int maxSize = 1024 * 1024 * 10;

		// 4. 인코딩 방식(String)
		String encoding = "UTF-8";

		// 5. 파일이름 중복제거
		DefaultFileRenamePolicy rename = new DefaultFileRenamePolicy();
		
		System.out.println("36번째 줄");

		// 파일 업로드 해주는 객체 -> MultipartRequest
		MultipartRequest multi;
		System.out.println("40번째 줄");
		try {
			System.out.println("42번째 줄");
			HttpSession session = request.getSession();
			UserDTO profileLoading = (UserDTO)session.getAttribute("profileLoading");
			System.out.println(profileLoading);
			multi = new MultipartRequest(request, savePath, maxSize, encoding, rename);
			System.out.println("45번째 줄");
			
			// 요청 데이터 받아오기
			
			String user_id = profileLoading.getUser_id();
			System.out.println("user_id" + user_id);
			String user_img = multi.getFilesystemName("user_img");
			System.out.println("user_img"+user_img);
			
			ProfileImgDTO vo = new ProfileImgDTO(user_id, user_img);
			// DB에 넣어주기
			int cnt = new ProfileImgDAO().updateProfileImg(vo);
			
			if (cnt > 0) {
				System.out.println(" 성공");
			} else {
				System.out.println("실패");
			}
		} catch (IOException e) {
			System.out.println("실패");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// response.sendRedirect("BoardMain.jsp");

		return "ProfileLoadingService.do";
	}
}

