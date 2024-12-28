package com.doo.frontcontroller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doo.controller.AdminService;
import com.doo.controller.BoardUploadService;
import com.doo.controller.CommentService;
import com.doo.controller.DeleteCommentService;
import com.doo.controller.DeleteIdService;
import com.doo.controller.DeleteMessageService;
import com.doo.controller.JoinService;
import com.doo.controller.LikeService;
import com.doo.controller.LoginService;
import com.doo.controller.LogoutService;
import com.doo.controller.MessageService;
import com.doo.controller.ProfileImgUpdateServices;
import com.doo.controller.ProfileLoadingService;
import com.doo.controller.PwUpdateService;
import com.doo.controller.ReportService;
import com.doo.controller.ShowAllReportService;
import com.doo.controller.ShowAllUserService;
import com.doo.controller.UpdateService;

public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("FrontContoller");
		
		// 어떤 요청이 들어왔는지 확인
				String requestURI = request.getRequestURI();
				System.out.println("요청이 들어온 주소 : " + requestURI);

				// ContextPath 확인
				String contextPath = request.getContextPath();
				System.out.println("ContextPath : " + contextPath);

				// 문자열 자르기
				// subString(start) : start 위치부터 끝까지 문자열 자르기
				// subString(start, end) : start 위치부터 end 전까지 문자열 자르기
				String result = requestURI.substring(contextPath.length());
				System.out.println("요청 서블릿 : " + result);

				request.setCharacterEncoding("UTF-8");
				Command service = null;
					
				if (result.equals("/LoginService.do")) { // 로그인 기능
					service = new LoginService();
				}
				else if(result.equals("/JoinService.do"))
				{
					service = new JoinService();
				}
				else if(result.equals("/PwUpdateService.do"))
				{
					service = new PwUpdateService();
				}
				else if(result.equals("/LogoutService.do"))
				{
					service = new LogoutService();
				}
				else if(result.equals("/UpdateService.do"))
				{
					service = new UpdateService();
				}
				else if(result.equals("/ProfileLoadingService.do"))
				{
					service = new ProfileLoadingService();
				}
				else if(result.equals("/DeleteIdService.do"))
				{
					service = new DeleteIdService(); // 실험 해보W기
				}
				else if(result.equals("/ProfileImgUpdateServices.do"))
				{
					service = new ProfileImgUpdateServices(); // 실험 해보기
				}
				else if(result.equals("/BoardUploadService.do"))
				{
					service = new BoardUploadService(); // 실험 해보기
				}
				else if(result.equals("/ReportService.do"))
				{	
					service = new ReportService(); // 실험 해보기
				}
				else if(result.equals("/AdminService.do")) // 회원삭제 기능으로 서비스 생성
				{
					service = new AdminService();
				}
				else if(result.equals("/ShowAllUserService.do")) // 회원삭제 기능으로 전체회원 정보를 보여주는 서비스 생성
				{
					service = new ShowAllUserService();
				}
				else if(result.equals("/MessageService.do"))
				{
					service = new MessageService(); // 실험 해보기
				}
				else if(result.equals("/CommentService.do"))
				{
					service = new CommentService(); // 실험 해보기
				}
				else if(result.equals("/LikeService.do"))
				{
					service = new LikeService(); // 실험 해보기
				}
				else if(result.equals("/DeleteMessageService.do"))	
				{
					service = new DeleteMessageService(); // 실험 해보기
				}
				else if(result.equals("/DeleteCommentService.do"))	
				{
					service = new DeleteCommentService(); // 실험 해보기
				}
				else if(result.equals("/ShowAllReportService.do")) // 회원삭제 기능으로 전체회원 정보를 보여주는 서비스 생성
				{
					service = new ShowAllReportService();
				}

				
				// 서비스 실행 및 결과 페이지 이동
				// 9-24 4:57 여기 바꿔주세요
		        String move = service.excute(request, response);
		        
		        if (move != null) {
		            // 페이지 이동 방식 설정 (조건부)
		            if (move.contains(".jsp")) {
		                // JSP 페이지로 포워딩 (데이터 유지를 위해)
		                RequestDispatcher dispatcher = request.getRequestDispatcher(move);
		                dispatcher.forward(request, response);
		            } else {
		                // 그 외는 sendRedirect로 이동
		                response.sendRedirect(move);
		            }
		        }

	}}
