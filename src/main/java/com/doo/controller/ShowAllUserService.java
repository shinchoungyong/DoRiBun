package com.doo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doo.frontcontroller.Command;
import com.doo.model.UserDAO;
import com.doo.model.UserDTO;

public class ShowAllUserService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		
		// user_id 값 가져오기
		String user_id = request.getParameter("user_id");
		
		// user_id를 이용해 UserDTO 만들기
		UserDTO dto = new UserDTO(user_id);
		
		// UserDAO를 통해 모든 사용자 목록을 조회하기
		List<UserDTO> allusers = new UserDAO().allusers();
		
		// 현재 세션을 가져오고, 세션에 사용자 목록을 저장하기
		HttpSession session = request.getSession();
		
		// 현재 세션을 가져오고, 세션에 사용자 목록을 저장하기
		session.setAttribute("allusers", allusers);
		
		// ShowUser.jsp 페이지로 이동
		return "ShowUser.jsp";
	}

}
