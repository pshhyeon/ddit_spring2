package kr.or.ddit.controller;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	private static final Logger log = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	private PasswordEncoder pw;
	
	@PostConstruct
	public void init() {
		log.info("## password : " + pw.encode("1234"));
		log.info("## password : " + pw.encode("1234"));
		log.info("## password : " + pw.encode("1234"));
	}

//	@RequestMapping(value = "/list", method = RequestMethod.GET)
	// 위 아래 어노테이션 모두 동일한 기능임
	@PreAuthorize("permitAll")
	@GetMapping("/list")
	public String list() {
		log.info("list() 실행...!");
		return "board/list";
	}
	
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("/register")
	public String registerForm() {
		log.info("registerForm() 실행...!");
		return "board/register";
	}
	
}
