package kr.or.ddit.controller.crud.notice;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.service.INoticeService;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.crud.NoticeMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notice")
public class NoticeProfileController {

	@Inject
	private INoticeService noticeService;
	
	@RequestMapping(value = "/profile.do", method = RequestMethod.GET)
	public String noticeProfile(HttpSession session,RedirectAttributes ra, Model model) {
		String goPage = "";
		
		// 첫번째 방법) HttpSession 이용 방법
//		NoticeMemberVO memberVO = (NoticeMemberVO) session.getAttribute("SessionInfo");
		
		// 두번째 방법) 시큐리티 인증시
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		NoticeMemberVO memberVO = user.getMember();
		
		if (memberVO != null) {
			NoticeMemberVO member = noticeService.selectMember(memberVO.getMemId());
			model.addAttribute("member", member);
			goPage = "notice/profile";
		}else {
			ra.addFlashAttribute("message", "로그인 후 사용가능합니다!");
			goPage = "redirect:/notice/login.do";
		}
		return goPage;
	}
	
	// 마이페이지 수정
	@RequestMapping(value = "/profileUpdate.do", method = RequestMethod.POST)
	public String profileUpdate(HttpSession session, HttpServletRequest req, NoticeMemberVO memberVO, Model model, RedirectAttributes ra) {
		// 서비스를 통해 요청할 마이페이지 수정 이벤트 기능명은 'profileUpate()'로 한다.
		// 수정이 완료되면, '회원정보 수정이 완료되었습니다!' 메세지를 출력해주세요!
		String goPage = "";
		
		ServiceResult result = noticeService.updateProfile(req, memberVO);
		if (result.equals(ServiceResult.OK)) { // 수정 성공
			NoticeMemberVO member = noticeService.selectMember(memberVO.getMemId());
			session.setAttribute("SessionInfo", member);
			ra.addFlashAttribute("message", "회원정보 수정이 완료되었습니다.!");
			goPage = "redirect:/notice/profile.do";
		}else {	// 수정 실패
			model.addAttribute("message", "수정 실패!");
			model.addAttribute("member", memberVO);
			goPage = "notice/profile";
		}
		return goPage;
	}
	
}
