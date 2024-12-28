package com.doo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doo.frontcontroller.Command;
import com.doo.model.UserDAO;
import com.doo.model.UserDTO;

public class UpdateService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		
		UserDTO loginMember = (UserDTO)session.getAttribute("loginMember");
		String user_pw = request.getParameter("user_pw");
		
		String user_nick = request.getParameter("user_nick");
		String user_id = (String)loginMember.getUser_id();
		
		UserDTO dto = new UserDTO(user_id, user_pw, user_nick);
		
		int result = new UserDAO().updateMember(dto);
		
		if (result > 0) {
			System.out.println("업데이트 완료");
			session.setAttribute("dto", dto);
			return "MainPage.jsp";
		} else {
			System.out.println("업데이트 실패");
			return "Edit_user_info.jsp";
		}
	}

}
