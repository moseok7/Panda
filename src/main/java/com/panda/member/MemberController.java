package com.panda.member;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/member")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberservice;
	
	@RequestMapping(value = "/register", method=RequestMethod.GET)
	public void registerGet() {	
		
		logger.info("회원가입 페이지 Get 방식");
	}
	
	@RequestMapping(value = "/register", method=RequestMethod.POST)
	public String registerPost(MemberVO member) throws Exception {	
		
		logger.info("회원가입 페이지 Post 방식");
		
		memberservice.register(member);
		
		return "home";
	}
	
}
