package com.panda.member;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/member")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberservice;

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registerGet() {

		logger.info("회원가입 페이지 Get 방식");
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerPost(MemberVO member) throws Exception {

		logger.info("회원가입 페이지 Post 방식");

		memberservice.register(member);

		return "index";
	}

	// 아이디 중복 검사
	@RequestMapping(value = "/Idcheck", method = RequestMethod.POST)
	@ResponseBody
	public String IdcheckPOST(String memberId) throws Exception {

		logger.info("Idcheck() 진입");

		int result = memberservice.idCheck(memberId);

		logger.info("결과값 = " + result);

		if (result != 0) {

			return "fail"; // 중복 아이디가 존재

		} else {

			return "success"; // 중복 아이디 x

		}

	} // Idcheck() 종료
} // Idcheck() 종료
