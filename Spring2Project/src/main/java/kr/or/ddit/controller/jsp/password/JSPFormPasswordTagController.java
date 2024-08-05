package kr.or.ddit.controller.jsp.password;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.vo.Member;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/formtag/password")
public class JSPFormPasswordTagController {
	/*
	 * 		5. 패스워드 필수 요소
	 * 		- HTML 패스워드 필드를 출력하려면 <form:password> 요소를 사용한다.
	 */
	
	@RequestMapping(value = "/registerForm01" , method = RequestMethod.GET)
	public String registerForm01(Model model) {
		log.info("registerForm01 실행");
		model.addAttribute("member",new Member());
		return "home/formtag/password/registerForm01";
	}
	
	
	@RequestMapping(value = "/registerForm02" , method = RequestMethod.GET)
	public String registerForm02(Model model) {
		log.info("registerForm02 실행");
		
		Member member = new Member();
		member.setPassword("11223344");
		
		model.addAttribute("member",member);
		return "home/formtag/password/registerForm01";
	}
	
}
