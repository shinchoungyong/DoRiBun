package com.doo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doo.frontcontroller.Command;
import com.doo.model.ReportDAO;
import com.doo.model.ReportDTO;

public class ShowAllReportService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		
		List<ReportDTO> allreports = new ReportDAO().allreports();
		
		HttpSession session = request.getSession();
		
		session.setAttribute("allreports", allreports);
		
		return "ShowReport.jsp";
	}

}
