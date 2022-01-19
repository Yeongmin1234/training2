package org.zerock.controller;

import org.apache.tomcat.util.net.openssl.ciphers.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@CrossOrigin(origins = "*")
public class CommonController {
	@GetMapping("/accessError")
	public void acessDenied(Authentication auth,Model model) {
		log.info("access Denied : "+ auth);
		model.addAttribute("msg","등급이 맞지않아 접근이 제한됩니다");
	}
}
