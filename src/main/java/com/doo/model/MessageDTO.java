package com.doo.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class MessageDTO {
	private int MESSAGE_ID;
	private String SENDER_ID;
	private String RECEIVER_ID;
	private String MESSAGE_CONTENT;
	
	

}
