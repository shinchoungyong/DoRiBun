package com.doo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doo.frontcontroller.Command;
import com.doo.model.ProfileImgDAO;
import com.doo.model.ProfileImgDTO;
import com.doo.model.UserDAO;
import com.doo.model.UserDTO;

public class ProfileLoadingService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		UserDTO loginMember = (UserDTO)session.getAttribute("loginMember");
		String user_id = loginMember.getUser_id();
		
		UserDTO vo = new UserDTO(user_id);
		UserDTO profileLoading = new UserDAO().profileLoading(vo);
		ProfileImgDTO loadingImg = new ProfileImgDAO().loadingImg(vo);
		
		
		session.setAttribute("profileLoading",profileLoading);
		session.setAttribute("loadingImg", loadingImg);
		
		return "Profile.jsp";
	}

}
