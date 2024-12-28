package com.doo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doo.frontcontroller.Command;
import com.doo.model.ProfileImgDAO;
import com.doo.model.ProfileImgDTO;
import com.doo.model.UserDTO;

public class ProfileImgLoadingServices implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		UserDTO profileLoading = (UserDTO)session.getAttribute("profileLoading");
		String user_id = profileLoading.getUser_id();
		
		UserDTO vo = new UserDTO(user_id);
		
		ProfileImgDTO loadingImg = new ProfileImgDAO().loadingImg(vo);
		
		session.setAttribute("loadingImg", loadingImg);
		return "ProfileLoadingService.do";
	}

}
