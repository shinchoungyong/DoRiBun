package com.doo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doo.frontcontroller.Command;
import com.doo.model.BadgeDAO;
import com.doo.model.BoardDAO;
import com.doo.model.BoardDTO;
import com.doo.model.CommentDAO;
import com.doo.model.LikeDAO;
import com.doo.model.MessageDAO;
import com.doo.model.ProfileImgDAO;
import com.doo.model.ReportDAO;
import com.doo.model.UserDAO;
import com.doo.model.UserDTO;

public class AdminService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		
		// user_id 값 가져오기
		String user_id = request.getParameter("user_id");

		// 현재 세션을 가져오기. 세션이 없다면 새로 생성됨
		HttpSession session = request.getSession();
		
		// 세션에서 AllUsers라는 이름으로 저장된 사용자 목록 가져오기
		List<UserDTO> allusers = (List<UserDTO>)session.getAttribute("allusers");
		
		// user_id를 기반으로 UserDTO 생성
		UserDTO vo = new UserDTO(user_id);
		
		List<BoardDTO> boards = new BoardDAO().userBoard(vo);
		
		// UserDAO의 AdminDeleteId , deleteUserFromBoardTable , deleteUserFromProfileImgTable
		// 9/23일 DeleteReportTable, DeleteCommentTable, DeleteLikeTable 삭제추가
		// 메서드를 호출해 해당 유저를 삭제하고, 삭제된 행의 수를 반환받기 부모인 AdminDeleteId 메서드를 맨 마지막에 적어서
		// 자식 테이블이 먼저 삭제 되도록 설정
		int row1 = new ReportDAO().DeleteReportTable(vo);
		int row2 = new CommentDAO().DeleteCommentTable(vo);
		int row3 = new LikeDAO().DeleteLikeTable(vo);
		int row4 = new ProfileImgDAO().deleteUserFromProfileImgTable(vo);
		
		if(boards != null)
		{
			for(int i = 0; i < boards.size();i++)
			{	
				Integer b_idx = boards.get(i).getB_idx();
				BoardDTO dto = new BoardDTO(b_idx);
				int cnt1 = new CommentDAO().deleteCommentB_idx(dto);
				int cnt2 = new LikeDAO().deleteLikeB_idx(dto);
				int cnt3 = new ReportDAO().deleteB_idx(dto);
				
				if(cnt1 != 0)
				{
					System.out.println("b_idx가 "+b_idx + "인 데이터 댓글삭제완료");
				}
				if(cnt2 != 0)
				{
					System.out.println("b_idx가 "+b_idx + "인 데이터 가진좋아요삭제완료");
				}
				if(cnt3 != 0)
				{
					System.out.println("b_idx가 "+b_idx + "인 데이터 신고내역삭제완료");
				}
			}
		}
		
		int row5 = new MessageDAO().deleteMessageTable(vo);
		int row6 = new BadgeDAO().deleteBadgeTable(vo);
		int row7 = new BoardDAO().deleteUserFromBoardTable(vo);
		int row8 = new UserDAO().AdminDeleteId(vo);
		
		if (row8 > 0) {
			System.out.println("유저 삭제 성공");
		}else {
			System.out.println("유저 정보 삭제 실패");
		}
		
		// 삭제 완료 후 ShowUser.jsp페이지로 다시 이동
		return "ShowUser.jsp";
	}
}