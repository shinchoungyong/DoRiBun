package com.doo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doo.frontcontroller.Command;
import com.doo.model.UserDAO;
import com.doo.model.UserDTO;

public class PwUpdateService implements Command {

    @Override
    public String excute(HttpServletRequest request, HttpServletResponse response) {
        String user_id = request.getParameter("user_id");
        String new_user_pw1 = request.getParameter("new_user_pw1");
        String new_user_pw2 = request.getParameter("new_user_pw2");

        // 비밀번호 확인 일치 여부 검사
        if (new_user_pw1.equals(new_user_pw2)) {
            UserDTO vo = new UserDTO(user_id, new_user_pw1);
            int cnt = new UserDAO().PwUpdateMember(vo);

            if (cnt > 0) {
                System.out.println("비밀번호 변경 성공!");
                request.getSession().setAttribute("message", "비밀번호 변경이 완료되었습니다.");
                return "LoginMain.jsp"; // 로그인 페이지로 이동
            } else {
                System.out.println("비밀번호 변경 실패..");
                request.getSession().setAttribute("message", "비밀번호 변경에 실패했습니다.");
                return "ForgotPW.jsp"; // 비밀번호 변경 페이지로 이동
            }
        } else {
            System.out.println("비밀번호가 일치하지 않습니다.");
            request.getSession().setAttribute("message", "입력한 비밀번호가 일치하지 않습니다.");
            return "ForgotPW.jsp"; // 비밀번호 변경 페이지로 이동
        }
    }
}