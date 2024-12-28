package com.doo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doo.frontcontroller.Command;
import com.doo.model.MessageDAO;
import com.doo.model.MessageDTO;

public class MessageService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
	    System.out.println("MessageService 도착");
		
		String senderid = request.getParameter("senderid");
		String receiverid = request.getParameter("receiverid");
		String messageContent = request.getParameter("messageContent");
		
		MessageDTO dto = new MessageDTO(0,senderid,receiverid,messageContent);
		int row = new MessageDAO().insertMessage(dto);
		
		if(row>0) {
			System.out.println("메세지 전송 성공");
		}else {
			System.out.println("메세지 전송 실패");
		}
		
		return "MainPage.jsp";
	}                        
}
