package com.panda.member;

import lombok.Data;

@Data
public class MemberVO {
	
	private String memberId;
	private String memberPw;
	private String memberName;
	private String memberEmail;
	private String memberAddress1;
	private String memberAddress2;
	private String memberAddress3;
	private int memberLevel;
	
}
