package com.doo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doo.frontcontroller.Command;
import com.doo.model.CommentDAO;
import com.doo.model.CommentDTO;

public class DeleteCommentService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		
		Integer cmt_idx = Integer.parseInt(request.getParameter("cmt_idx"));
		
		System.out.println("DeleteCommentService의 cmt_idx : " + cmt_idx);
		
		CommentDTO vo = new CommentDTO(cmt_idx);
		
		int row = new CommentDAO().deleteComment(vo);
		
		if(row > 0)
		{
			System.out.println("댓글삭제 성공");
		}
		else {
			System.out.println("댓글삭제 실패");
		}
		
		return "MainPage.jsp";
	}

}
