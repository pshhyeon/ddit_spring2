package kr.or.ddit.controller.jsp;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/el")
public class JSPELController {

	/*
	 * 		8. EL함수
	 * 		- JSTL은 표현언어(EL)에서 사용할 수 있는 함수를 제공한다.
	 * 
	 * 		1) EL 함수 목록
	 * 		- JSTLHomeController에서 확인 요망
	 */
	@RequestMapping(value = "/home0101", method = RequestMethod.GET)
	public String home0901(Model model) {
		String str = "<font>Hello World!</font>";
		model.addAttribute("str", str);
		return "home/el/home0101";
	}
	
	
}
