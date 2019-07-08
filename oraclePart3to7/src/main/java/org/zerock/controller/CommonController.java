package org.zerock.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {

	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		
		log.info("=========================== access denied : " + auth);
		
		model.addAttribute("msg", "Access Denied");
	}
	
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		log.info("============= ERROR : " + error);
		log.info("============= 로그아웃 : " + logout);
		
		if (error != null) {
			model.addAttribute(error, "LOGIN ERROR CHECK YOUR ACCOUNT");
		}
		
		if (logout != null) {
			model.addAttribute(logout, "logout!!");
		}
		
	}
	
	
	
}
