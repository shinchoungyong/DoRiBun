package com.doo.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet; // 어노테이션을 사용하기 위해 추가
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.doo.model.UserDAO;
import com.doo.model.UserDTO;

@WebServlet("/CheckIdDuplicate.do") // 서블릿 경로 설정
public class CheckIdDuplicate extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 클라이언트에서 보낸 user_id 파라미터를 가져옵니다.
        String user_id = request.getParameter("user_id");
        UserDTO vo = new UserDTO(user_id);
        // 아이디 중복 여부를 체크합니다.
        boolean isDuplicate = new UserDAO().isIdDuplicate(vo); 

        // 결과를 클라이언트에 전송합니다.
        if (isDuplicate) {
            response.getWriter().write("duplicate");
        } else {
            response.getWriter().write("available");
        }
    }
}