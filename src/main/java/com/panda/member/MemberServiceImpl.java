package com.panda.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.panda.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberMapper membermapper;
	
	@Override
	public void register(MemberVO member) throws Exception {
		
		membermapper.register(member);
	}

	/* 아이디 중복 검사 */
	@Override
	public int idCheck(String memberId) throws Exception {
		
		return membermapper.idCheck(memberId);
	}
	
	// 로그인 처리
	@Override
	public MemberVO login(MemberVO member) throws Exception {
		
		return membermapper.login(member);
	}
	
	
}
