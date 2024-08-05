package kr.or.ddit.controller.test;

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
@RequestMapping("/test03")
@Slf4j
public class TestController03 {

	Test03Repository dao = new Test03Repository(); 
	
	// 로그인 페이지
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String loginPage() {
		return "test/test03/login";
	}
	
	// 아이디/비밀번호 찾기 페이지
	@RequestMapping(value = "/findInfo.do", method = RequestMethod.GET)
	public String findInfo() {
		return "test/test03/findInfo";
	}
	
	// 로그인 후 정보 페이지
	@RequestMapping(value = "/info.do", method = RequestMethod.GET)
	public String info() {
		return "test/test03/info";
	}
	
	// 로그인 처리
	@RequestMapping(value = "/loginChk", method = RequestMethod.POST)
	public String login(StudentVO vo, Model model) {
		log.info("request vo : " + vo);
		List<StudentVO> list = dao.getList();
		for (StudentVO studentVO : list) {
			if (studentVO.getMemId().equals(vo.getMemId()) && studentVO.getMemPw().equals(vo.getMemPw())) {
				model.addAttribute("list", list);
				model.addAttribute("vo", studentVO);
				model.addAttribute("msg", studentVO.getMemName() + "님! 환영합니다!");
				return "test/test03/info";
			}
		}
		model.addAttribute("msg", "일치하는 회원 정보가 없습니다");
		return "test/test03/login";
	}
	
	// 아이디 찾기
	@RequestMapping(value = "findId", method = RequestMethod.POST)
	public ResponseEntity<String> findId(@RequestBody StudentVO vo){
		log.info("@@vo : " + vo);
		String id = dao.getId(vo.getMemName(), vo.getMemEmail());
		if (id == null) {
			return new ResponseEntity<String>("", HttpStatus.OK);
		}
		return new ResponseEntity<String>(id, HttpStatus.OK);
	}
	
	// 아이디 찾기
	@RequestMapping(value = "findPassword", method = RequestMethod.POST)
	public ResponseEntity<String> findPassword(@RequestBody StudentVO vo){
		log.info("@@vo : " + vo);
		String password = dao.getPassword(vo.getMemId(), vo.getMemName(), vo.getMemEmail());
		if (password == null) {
			return new ResponseEntity<String>("", HttpStatus.OK);
		}
		return new ResponseEntity<String>(password, HttpStatus.OK);
	}
	
	// 이미지 변경
	@RequestMapping(value = "/uploadImg", method = RequestMethod.POST)
	public ResponseEntity<String> uploadImg(MultipartFile file){
		log.info("uploadImg() 실행...!");
		log.info("originalFilename : " + file.getOriginalFilename());
		return new ResponseEntity<String>("UPLOAD SUCCESS", HttpStatus.OK);
	}
	
}
