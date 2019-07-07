package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/security/*")
@Controller

public class SecuritySampleController {
	
	@GetMapping("/all")
	public void doAll() {
		log.info("================DO ALL ACCESS EVERYBODY ==============");
	}
	
	@GetMapping("/member")
	public void doMember() {
		log.info("=============== LOGINED MEMBER ===============");
	}

	@GetMapping("/admin")
	public void doAdmin() {
		log.info("================ ADMIN ONLY =================");
	}



}
