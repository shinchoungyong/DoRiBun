package com.doo.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;


@Getter
@AllArgsConstructor
@NoArgsConstructor

public class LikeDTO {
	private Integer like_idx;
	private Integer b_idx;
	private String user_id;
	private Date liked_at;
	
	
	public LikeDTO(Integer b_idx, String user_id) {
		this.b_idx = b_idx;
		this.user_id = user_id;
	}


	public LikeDTO(Integer b_idx) {
		this.b_idx = b_idx;
	}
	
	
	
	
}
