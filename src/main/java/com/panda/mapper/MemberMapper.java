package com.panda.mapper;

import com.panda.member.MemberVO;

public interface MemberMapper {
	
	public void register(MemberVO member) throws Exception;
	
	public MemberVO login(MemberVO memeber) throws Exception;
	
}
