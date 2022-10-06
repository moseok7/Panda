package com.panda.member;


public interface MemberService {
	
	public void register(MemberVO member) throws Exception;
	
	public MemberVO login(MemberVO member) throws Exception;
	
}
