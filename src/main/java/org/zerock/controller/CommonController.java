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
//		WebSecurityConfigurerAdapter.configure(HttpSecurity http);
		log.info("access Denied : "+ auth);
		model.addAttribute("msg","Access Denied");
	}
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		log.info("success");
		if(error!=null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}
		
		if(logout!=null) {
			model.addAttribute("logout", "Logout!!");
		}
	}
	@GetMapping("/customLogout")
	public void logoutGet() {
		log.info("success");
	}
}
