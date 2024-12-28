package com.doo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doo.frontcontroller.Command;
import com.doo.model.BadgeDAO;
import com.doo.model.BadgeDTO;
import com.doo.model.BoardDAO;
import com.doo.model.BoardDTO;
import com.doo.model.ReportDAO;
import com.doo.model.ReportDTO;
import com.doo.model.UserDAO;
import com.doo.model.UserDTO;

public class ReportService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		
		UserDTO loginMember = (UserDTO) session.getAttribute("loginMember");
		
		
		String user_id = loginMember.getUser_id();
		String b_idxParam = (String) session.getAttribute("b_idx");
		Integer b_idx = Integer.parseInt(b_idxParam); // Double로 변환

		String report_reason = request.getParameter("reportReason");
		
		System.out.println("user_id :" + user_id);
		System.out.println("b_idx : " + b_idx);
		System.out.println("reason : " + report_reason);
		
		ReportDTO dto = new ReportDTO(b_idx, user_id, report_reason);
		
		int cnt = new ReportDAO().reportInsert(dto);
		
		BoardDTO vo = new BoardDAO().BringIndex(new BoardDTO(b_idx));
		

		if(cnt > 0)
		{
			int cnt1 = 0;
			cnt1 = new ReportDAO().countreport(new BoardDTO(b_idx));
			System.out.println("신고당한 아이디 : "+ vo.getUser_id());
			System.out.println(vo.getUser_id()+"가 신고당한 횟수 :" + cnt1);
			if(cnt1 >= 3)
			{	
				String bg_idx = "B00002";	
				String bg_img = "B00002.png";
				String bg_name = "비매 뱃지";
				String bg_info = "신고를 3회 이상 당한 사용자에게 부여되는 뱃지";
				
				BadgeDTO reportBadge = new BadgeDTO(bg_idx, bg_name, bg_info, vo.getUser_id(), bg_img);
				
				int res = new BadgeDAO().assignBadge(reportBadge);
				
				if(res > 0)
				{
					System.out.println("뱃지 부여 성공");
				}
				
			}
			System.out.println("신고 성공");
			return "ReportSuccess.jsp";
		}
		else
		{
			System.out.println("신고 실패");
			return "ReportFail.jsp";
		}
				
	}

}
