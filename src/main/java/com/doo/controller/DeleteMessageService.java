package com.doo.controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doo.frontcontroller.Command;
import com.doo.model.MessageDAO;

public class DeleteMessageService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		
		int num = Integer.parseInt(request.getParameter("num"));
		System.out.println("num"+num);
		
		int cnt = new MessageDAO().deleteMessage(num);
		System.out.println("cnt"+cnt);
		
		if(cnt > 0) {
			System.out.println("메세지 삭제 성공");
		}else {
			System.out.println("메세지 삭제 실패");
		}
		
		return "Receive.jsp";
	}
}
