package com.doo.controller;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doo.frontcontroller.Command;
import com.doo.model.BoardDAO;
import com.doo.model.LikeDAO;
import com.doo.model.LikeDTO;
import com.doo.model.UserDTO;
import com.google.gson.Gson;

public class LikeService implements Command {

    @Override
    public String excute(HttpServletRequest request, HttpServletResponse response) {
        StringBuilder sb = new StringBuilder();
        String line;
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return "{\"success\": false, \"message\": \"Error reading request\"}";
        }

        Gson gson = new Gson();
        LikeRequest likeRequest = gson.fromJson(sb.toString(), LikeRequest.class);

        HttpSession session = request.getSession();
        UserDTO loginmember = (UserDTO) session.getAttribute("loginMember");
        if (loginmember == null) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            return "{\"success\": false, \"message\": \"User not logged in\"}";
        }

        String user_id = loginmember.getUser_id();
        LikeDTO dto = new LikeDTO(likeRequest.b_idx, user_id);
        boolean isLiked = new LikeDAO().checkIfUserLiked(dto);

        boolean success = false;

        if (isLiked) {
            int cnt1 = new LikeDAO().deleteLike(dto);
            int cnt2 = new BoardDAO().updateLikeCntMinus(new LikeDTO(likeRequest.b_idx));

            if (cnt1 != 0 && cnt2 != 0) {
                success = true;
            }
        } else {
            int cnt1 = new LikeDAO().insertLike(dto);
            int cnt2 = new BoardDAO().updateLikeCntPlus(new LikeDTO(likeRequest.b_idx));

            if (cnt1 != 0 && cnt2 != 0) {
                success = true;
            }
        }

        // JSON 응답 생성
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            response.getWriter().write("{\"success\": " + success + "}");
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null; // 여기서 null을 반환하여 아무것도 하지 않도록 함
    }

    private static class LikeRequest {
        int b_idx;
        String user_id;
        boolean isLiked;
    }
}