package com.doo.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;


@Getter
@AllArgsConstructor
@NoArgsConstructor

public class ReportDTO {
	
	// 신고 식별자 
    private Integer report_idx;

    // 글 식별자 
    private Integer b_idx;

    // 유저 아이디 
    private String user_id;

    // 신고 사유 
    private String report_reason;

    // 신고 날짜 
    private Date reported_at;

	public ReportDTO(Integer b_idx, String report_reason) {
		this.b_idx = b_idx;
		this.report_reason = report_reason;
	}

	public ReportDTO(Integer b_idx, String user_id, String report_reason) {
		super();
		this.b_idx = b_idx;
		this.user_id = user_id;
		this.report_reason = report_reason;
	}
	
	
    
    

}
