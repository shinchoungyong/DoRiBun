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

public class DeleteIdService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		UserDTO profileLoading = (UserDTO)session.getAttribute("profileLoading");
		
		String input_pw = request.getParameter("input_pw");
		String user_id = profileLoading.getUser_id();
		String user_pw = profileLoading.getUser_pw();
		
		if(input_pw.equals(user_pw))
		{
			UserDTO vo  = new UserDTO(user_id);
			UserDTO dto = new UserDTO(user_id, user_pw);
			List<BoardDTO> boards = new BoardDAO().userBoard(vo);
			
			int row1 = new ReportDAO().DeleteReportTable(vo);
			int row2 = new CommentDAO().DeleteCommentTable(vo);
			int row3 = new LikeDAO().DeleteLikeTable(vo);
			int row4 = new ProfileImgDAO().deleteUserFromProfileImgTable(vo);
			
			if(boards != null)
			{
				for(int i = 0; i < boards.size();i++)
				{	
					Integer b_idx = boards.get(i).getB_idx();
					BoardDTO dto1 = new BoardDTO(b_idx);
					int cnt1 = new CommentDAO().deleteCommentB_idx(dto1);
					int cnt2 = new LikeDAO().deleteLikeB_idx(dto1);
					int cnt3 = new ReportDAO().deleteB_idx(dto1);
					
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
			
			int row = new UserDAO().deleteMember(dto);
			
			if (row > 0) {
                System.out.println("삭제 성공");
                session.invalidate(); // 세션 무효화 (로그아웃 처리)
                request.setAttribute("message", "탈퇴가 성공적으로 완료되었습니다.");
                return "LogoutService.do"; // 로그아웃 서비스로 이동
            } else {
                System.out.println("삭제 실패");
                request.setAttribute("errorMessage", "회원 탈퇴에 실패했습니다. 다시 시도해주세요.");
                try {
                    request.getRequestDispatcher("Delete.jsp").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return null;
            }
			
		}
		else {
            // 비밀번호가 틀렸을 때
        	// 9-24 점심전
            System.out.println("비밀번호 불일치");
            request.setAttribute("errorMessage", "비밀번호가 틀렸습니다. 다시 입력해주세요.");
            try {
                request.getRequestDispatcher("Delete.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }
		
		
	}

}
