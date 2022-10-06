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

	@Override
	public MemberVO login(MemberVO member) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
