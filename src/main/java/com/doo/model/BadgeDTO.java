package com.doo.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

public class BadgeDTO {
	    // 뱃지 번호
	    private String bg_idx;

	    // 뱃지 이름
	    private String bg_name;

	    // 뱃지 정보 
	    private String bg_info;

	    // 유저 아이디 
	    private String user_id;
	    
	    // 획득일자 
	    private Date created_at;

	    // 뱃지 이미지 
	    private String bg_img;

    public BadgeDTO(String bg_idx, String bg_name, String bg_info, String bg_img) {
        this.bg_idx = bg_idx;
        this.bg_name = bg_name;
        this.bg_info = bg_info;
        this.bg_img = bg_img;
    }

	public BadgeDTO(String bg_idx, String bg_name, String bg_info, String user_id, String bg_img) {
		this.bg_idx = bg_idx;
		this.bg_name = bg_name;
		this.bg_info = bg_info;
		this.user_id = user_id;
		this.bg_img = bg_img;
	}

    
 
	

}