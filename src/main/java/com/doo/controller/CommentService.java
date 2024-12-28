package com.doo.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doo.frontcontroller.Command;
import com.doo.model.CommentDAO;
import com.doo.model.CommentDTO;
import com.doo.model.ProfileImgDAO;
import com.doo.model.ProfileImgDTO;
import com.doo.model.UserDAO;
import com.doo.model.UserDTO;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class CommentService implements Command {

    public String excute(HttpServletRequest request, HttpServletResponse response) {

        // 요청 인코딩 설정
        try {
            response.setCharacterEncoding("UTF-8");
            request.setCharacterEncoding("UTF-8"); // 요청 인코딩
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        HttpSession session = request.getSession();
        UserDTO loginMember = (UserDTO) session.getAttribute("loginMember");

        String jsonString = null;
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        jsonString = sb.toString();
        JsonObject json = JsonParser.parseString(jsonString).getAsJsonObject();
        
        Integer b_idx = json.get("b_idx").getAsInt();
        String cmt_content = json.get("cmt_content").getAsString();
        String user_id = loginMember.getUser_id();

        CommentDTO dto = new CommentDTO(b_idx, cmt_content, user_id);
        int cnt = new CommentDAO().insertComment(dto);

        response.setContentType("application/json");
        try (PrintWriter out = response.getWriter()) {
            if (cnt > 0) {
                // 댓글 작성 성공 시 사용자 정보 조회
                UserDTO commenter = new UserDAO().profileLoading(new UserDTO(user_id));
                ProfileImgDTO commenterIMG = new ProfileImgDAO().loadingImg(new UserDTO(user_id));
                // JSON 객체에 댓글 내용과 사용자 정보 추가
                JsonObject responseJson = new JsonObject();
                responseJson.addProperty("success", true);
                responseJson.addProperty("newComment", cmt_content);
                responseJson.addProperty("commenterIMGImage", commenterIMG.getUser_img());
                responseJson.addProperty("commenterNickname", commenter.getUser_nick());
                
                out.print(responseJson.toString());
            } else {
                out.print("{\"success\": false}");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }
}