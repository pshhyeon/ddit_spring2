package kr.or.ddit.controller.test.test05;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.controller.test.dao.Test03Repository;
import kr.or.ddit.controller.test.vo.StudentVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/elevator")
@Slf4j
public class TestController05 {
	
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String loginPage() {
		return "test/test05/main";
	}
	
}
