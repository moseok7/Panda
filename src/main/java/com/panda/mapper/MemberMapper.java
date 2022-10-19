package com.panda.mapper;

import com.panda.member.MemberVO;

public interface MemberMapper {
	
	public void register(MemberVO member) throws Exception;
	
	/* 아이디 중복 검사 */
	public int idCheck(String memberId) throws Exception;
	
	public MemberVO login(MemberVO member) throws Exception;
	
}
