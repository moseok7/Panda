package com.panda.user;

import javax.servlet.http.Cookie;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {
	
	@RequestMapping(value = "/login")
	public String login(@CookieValue(value="saveId", required=false)Cookie cookie, Model model) {	
		if (cookie != null) { // 아이디 저장 쿠키 있으면 불러오기
			String saveIdCookie = cookie.getValue();
			model.addAttribute("saveIdCookie", saveIdCookie);
		}		
		return "user/login";
	}
}
