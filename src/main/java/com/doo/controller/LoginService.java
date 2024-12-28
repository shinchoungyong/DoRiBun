package com.doo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doo.frontcontroller.Command;
import com.doo.model.UserDAO;
import com.doo.model.UserDTO;

public class LoginService implements Command {

    @Override
    public String excute(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("LoginService");
        String user_id = request.getParameter("user_id");
        String user_pw = request.getParameter("user_pw");

        UserDTO dto = new UserDTO(user_id, user_pw);

        UserDTO loginMember = new UserDAO().loginMember(dto);

        if (loginMember != null) {
            // 로그인 성공
            System.out.println("로그인 성공!");
            HttpSession session = request.getSession();
            session.setAttribute("loginMember", loginMember);
            return "MainPage.jsp";
        } else {
            // 로그인 실패 시 메시지를 설정합니다.
        	// 9-24 5:04 여기 적용하심되여
            System.out.println("로그인 실패");
            request.setAttribute("loginFailMessage", "로그인 실패");
            return "LoginMain.jsp";
        }
    }
}