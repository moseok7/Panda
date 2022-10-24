package com.panda.member;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value = "/member")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberservice;

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private BCryptPasswordEncoder pwEncoder;

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registerGet() {

		logger.info("회원가입 페이지 Get 방식");
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerPost(MemberVO member) throws Exception {

		logger.info("회원가입 페이지 Post 방식");

		String rawPw = ""; // 인코딩 전 비밀번호
		String encodePw = ""; // 인코딩 후 비밀번호

		rawPw = member.getMemberPw(); // 비밀번호 데이터 얻음
		encodePw = pwEncoder.encode(rawPw); // 비밀번호 인코딩
		member.setMemberPw(encodePw); // 인코딩된 비밀번호 member객체에 다시 저장

		memberservice.register(member);

		return "redirect:/";
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

	@RequestMapping(value = "/mailCheck", method = RequestMethod.GET)
	@ResponseBody
	public String mailCheckGET(String email) throws Exception {

		/* 인증번호(난수) 생성 */
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;

		/* 이메일 보내기 */
		String setFrom = "pandaKh361@gmail.com";
		String toMail = email;
		String title = "회원가입 인증 이메일 입니다.";
		String content = "홈페이지를 방문해주셔서 감사합니다." + "<br><br>" + "인증 번호는 " + checkNum + "입니다." + "<br>"
				+ "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";

		try {

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}

		String num = Integer.toString(checkNum);

		return num;

	}

	// 로그인 처리 Get
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void loginGET() {

		logger.info("로그인 페이지 진입");

	}

	// 로그인 처리 Post
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginPOST(HttpServletRequest request, MemberVO member, RedirectAttributes rttr) throws Exception {

		HttpSession session = request.getSession();

		String rawPw = "";
		String encodePw = "";

		MemberVO loginData = memberservice.login(member);

		if (loginData != null) { // 일치하는 아이디 존재시

			rawPw = member.getMemberPw(); // 사용자가 제출한 비밀번호
			encodePw = loginData.getMemberPw(); // 데이터베이스에 저장한 인코딩된 비밀번호

			if (true == pwEncoder.matches(rawPw, encodePw)) { // 비밀번호 일치여부 판단

				loginData.setMemberPw("");
				session.setAttribute("member", loginData); // 일치하는 아이디, 비밀번호 경우 (로그인 성공)

				return "redirect:/";

			} else {

				rttr.addFlashAttribute("result", 0);
				return "redirect:/member/login";

			}

		} else {

			rttr.addFlashAttribute("result", 0);
			return "redirect:/member/login";

		}
	}

	
	  //메인페이지 로그아웃
	  
	  @RequestMapping(value="/logout", method=RequestMethod.GET) public String
	  logoutGET(HttpServletRequest request) throws Exception{
	  
	  logger.info("logoutMainGET메서드 진입");
	  
	  HttpSession session = request.getSession();
	  
	  session.invalidate();
	  
	  return "redirect:/"; 
	  
	  }
	 

	/* 비동기방식 로그아웃 */
	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	@ResponseBody
	public void logoutPOST(HttpServletRequest request) throws Exception {

		logger.info("비동기 로그아웃 메서드 진입");

		HttpSession session = request.getSession();

		session.invalidate();

	}

}
