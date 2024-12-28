package com.doo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doo.frontcontroller.Command;
import com.doo.model.BadgeDAO;
import com.doo.model.ProfileImgDAO;
import com.doo.model.ProfileImgDTO;
import com.doo.model.UserDAO;
import com.doo.model.UserDTO;

public class JoinService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		// 요청데이터 받기
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		String user_birthdate = request.getParameter("user_birthdate");
		String user_name = request.getParameter("user_name");
		String user_phone = request.getParameter("user_phone");
		String user_gender = request.getParameter("user_gender");
		String user_nick = request.getParameter("user_nick");
		String user_img = "basic_profile.png";

		UserDTO vo = new UserDTO(user_id, user_pw, user_birthdate, user_name, user_phone, user_gender, user_nick);
		ProfileImgDTO dto = new ProfileImgDTO(user_id, user_img);

		System.out.println(vo.toString());
//				오류 뜰까바
		System.out.println("조인서비스26번째 줄");

		int cnt1 = new UserDAO().joinMember(vo);
		int cnt2 = new ProfileImgDAO().insertProfileImg(dto);
		int cnt3 = new BadgeDAO().assignBadge(new UserDTO(vo.getUser_id()));

		System.out.println("cnt : " + cnt1);

		return "LoginMain.jsp";

	}

}
