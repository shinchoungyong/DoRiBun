package com.doo.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor

public class CommentDTO {
	// 댓글 식별자 
    private Integer cmt_idx;

    // 원글 식별자 
    private Integer b_idx;

    // 댓글 내용 
    private String cmt_content;

    // 댓글 작성일자 
    private Date created_at;

    // 댓글 좋아요수 
    private Integer cmt_likes;

    // 유저 아이디 
    private String user_id;

	public CommentDTO(Integer b_idx, String cmt_content, String user_id) {
		
		this.b_idx = b_idx;
		this.cmt_content = cmt_content;
		this.user_id = user_id;
	}

	public CommentDTO(Integer cmt_idx) {
		this.cmt_idx = cmt_idx;
	}
	
	

	 
    
}
