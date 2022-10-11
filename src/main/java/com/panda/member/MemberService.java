package com.panda.member;


public interface MemberService {
	
	public void register(MemberVO member) throws Exception;
	
	/* 아이디 중복 검사 */
	public int idCheck(String memberId) throws Exception;
	
}
