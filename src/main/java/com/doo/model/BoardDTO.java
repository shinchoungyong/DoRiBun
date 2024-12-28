package com.doo.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class BoardDTO {
	// 글 식별자 
    private Integer b_idx;

    // 글 제목 
    private String b_title;

    // 글 내용 
    private String b_content;

    // 글 첨부파일 
    private String b_file;

    // 글 작성일자 
    private Date created_at;

    // 글 조회수 
    private Integer b_views;

    // 글 좋아요수 
    private Integer b_likes;

    // 유저 아이디 
    private String user_id;
    
    // 글 해시태그
    private String b_confirm_hashtag;

	public BoardDTO(String b_title, String b_content, String b_file, String user_id, String b_confirm_hashtag) {
		this.b_title = b_title;
		this.b_content = b_content;
		this.b_file = b_file;
		this.user_id = user_id;
		this.b_confirm_hashtag = b_confirm_hashtag;
	}

	public BoardDTO(Integer b_idx) {
		this.b_idx = b_idx;
	}
	
	
    
    

}
