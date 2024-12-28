package com.doo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doo.frontcontroller.Command;

public class LogoutService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		// session 값 지우고 Main.jsp로 이동
				HttpSession session = request.getSession();
				session.invalidate();
				

				return "LoginMain.jsp";
	}

}
