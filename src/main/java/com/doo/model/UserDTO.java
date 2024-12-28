package com.doo.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UserDTO {
	 // 유저 아이디 
    private String user_id;

    // 유저 비밀번호 
    private String user_pw;

    // 유저 생년월일 
    private String user_birthdate;

    // 유저 이름 
    private String user_name;

    // 유저 폰번호 
    private String user_phone;

    // 유저 성별 남자:M, 여자:F
    private String user_gender;

    // 유저 가입일자 
    private Date joined_at;

    // 유저 구분 
    private String user_type;
    
    // 유저 닉네임
    private String user_nick;
    
    // 유저 프로필
    private String user_img;
	
	public UserDTO(String user_id, String user_pw) {
		this.user_id = user_id;
		this.user_pw = user_pw;
	}
	

	public UserDTO(String user_id, String user_pw, String user_birthdate, String user_name, String user_phone,
			String user_gender, String user_nick) {
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.user_birthdate = user_birthdate;
		this.user_name = user_name;
		this.user_phone = user_phone;
		this.user_gender = user_gender;
		this.user_nick = user_nick;
		
	}

	public UserDTO(String user_id, String user_pw, String user_nick) {
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.user_nick = user_nick;
	}

	public UserDTO(String user_id) {
		this.user_id = user_id;
	}
	
	
	
	
	
	
	
	
	
}
