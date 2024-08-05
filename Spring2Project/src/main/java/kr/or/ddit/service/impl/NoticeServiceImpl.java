package kr.or.ddit.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.mapper.ILoginMapper;
import kr.or.ddit.mapper.INoticeMapper;
import kr.or.ddit.mapper.IProfileMapper;
import kr.or.ddit.service.INoticeService;
import kr.or.ddit.vo.crud.CrudMember;
import kr.or.ddit.vo.crud.NoticeFileVO;
import kr.or.ddit.vo.crud.NoticeMemberVO;
import kr.or.ddit.vo.crud.NoticeVO;
import kr.or.ddit.vo.crud.PaginationInfoVO;

@Service
public class NoticeServiceImpl implements INoticeService {

	@Inject
	private INoticeMapper noticeMapper;
	
	@Inject
	private ILoginMapper loginMapper;
	
	@Inject
	private IProfileMapper profileMapper;
	
	@Inject
	private PasswordEncoder pw;
	
	@Override
	public ServiceResult insertNotice(HttpServletRequest req, NoticeVO noticeVO) {
		ServiceResult result = null;
		
		int status = noticeMapper.insertNotice(noticeVO);
		if (status > 0) { // 등록 성공
			// 파일 데이터를 write process 진행
			// 공지사항 게시글 등록 시 업로드 한 파일 목록을 가져온다.
			List<NoticeFileVO> noticeFileList = noticeVO.getNoticeFileList();
			
			// 공지사항 파일 업로드 처리 메소드
			try {
				noticeFileUpload(noticeFileList, noticeVO.getBoNo(), req);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			result = ServiceResult.OK;
		} else { // 등록 실패
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	private void noticeFileUpload(List<NoticeFileVO> noticeFileList, int boNo, HttpServletRequest req) throws Exception {
		// 공지사항 게시판에서 등록된 파일은 기복 '/resources/notice/' 경로로 설정
		String savePath = "/resources/notice/";
		if (noticeFileList != null) {	// 넘겨받은 파일 데이터가 존재 할 때
			if (noticeFileList.size() > 0) {
				for (NoticeFileVO noticeFileVO : noticeFileList) {
					// 파일명을 설정할 때 원본 파일명의 공백을 '_'로 변경한다.
					String saveName = UUID.randomUUID().toString();
					saveName = saveName + "_" + noticeFileVO.getFileName().replaceAll(" ", "_");
					String saveLocate = req.getServletContext().getRealPath(savePath + boNo);
					File file = new File(saveLocate);
					if (!file.exists()) {
						file.mkdirs();
					}
					// 파일 복사를 하기 위한 최종 경로
					saveLocate += "/" + saveName;
					noticeFileVO.setBoNo(boNo);
					noticeFileVO.setFileSavepath(saveLocate);
					noticeMapper.insertNoticeFile(noticeFileVO);	// 파일 데이터를 DB에 저장
					
					// 파일 복사를 하기 위한 target
					File saveFile = new File(saveLocate);
					noticeFileVO.getItem().transferTo(saveFile);	// 파일 복사
					
				}
			}
		}
	}

	@Override
	public NoticeVO selectNotice(int boNo) {
		noticeMapper.incrementHit(boNo);
		return noticeMapper.selectNotice(boNo);
	}

	@Override
	public ServiceResult updateNotice(HttpServletRequest req, NoticeVO noticeVO) {
		ServiceResult result = null;
		int status = noticeMapper.updateNotice(noticeVO);
		if (status > 0) { // 수정 성공
			// 게시글 정보에서 파일 목록 가져오기
			List<NoticeFileVO> noticeFileList = noticeVO.getNoticeFileList();
			try {
				// 공지사항 파일 업로드
				noticeFileUpload(noticeFileList, noticeVO.getBoNo(), req);
				
				// 기존 파일 데이터를 삭제 내역을 이용하여 지워준다.
				// [10,11,14....]
				Integer[] delNoticeNo = noticeVO.getDelNoticeNo();
				if (delNoticeNo != null) {
					for (int i = 0; i < delNoticeNo.length; i++) {
						// 삭제할 파일 번호 목록들 중, 파일 번호에 해당하는 공지사항 파일 정보를 가져온다.
						NoticeFileVO noticeFileVO = noticeMapper.selectNoticeFile(delNoticeNo[i]);
						// 삭제 내역에 들어있는 fileNo에 해당하는 데이터를 삭제한다.
						noticeMapper.deleteNoticeFile(delNoticeNo[i]);
						File file = new File(noticeFileVO.getFileSavepath());
						file.delete(); // 파일삭제
					}
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			result = ServiceResult.OK;
		} else { // 수정 실패
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult deleteNotice(HttpServletRequest req, int boNo) {
		ServiceResult result = null;
		
		// 공지사항 파일 데이터를 삭제하기 위한 준비 (파일 적용)
		NoticeVO noticeVO = noticeMapper.selectNotice(boNo);
		noticeMapper.deleteNoticeFileByBoNo(boNo);	// 게시글 번호에 해당하는 파일 데이터 삭제
		
		int status = noticeMapper.deleteNotice(boNo);
		if (status > 0) { // 삭제 성공
			// 공지사항 게시글 정보에서 파일 목록 가져오기
			List<NoticeFileVO> noticeFileList = noticeVO.getNoticeFileList();
			try {
				if (noticeFileList != null) {
					String[] filePath = noticeFileList.get(0).getFileSavepath().split("/");
					
					String path = filePath[0];
					deleteFolder(req, path);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			result = ServiceResult.OK;
		} else { // 삭제 실패
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	private void deleteFolder(HttpServletRequest req, String path) {
		// UUID_원폰파일명 전 폴더경로를 folder 파일객체로 잡는다.
		File folder = new File(path);		
		try {
			if (folder.exists()) {	// 경로가 존재할 경우
				// 폴더 안에 있는 파일들의 목록을 가져온다.
				File[] fileList = folder.listFiles();
				for (int i = 0; i < fileList.length; i++) {
					if (fileList[i].isFile()) {	// 꺼낸 파일이 파일인지 아닌지 체크
						fileList[i].delete();	// 파일 삭제
					}else {
						deleteFolder(req, fileList[i].getPath());	// 폴더일 경우 재귀 함수로 폴더 안에 파일을 삭제 
					}
				}
				folder.delete();	// 폴더 삭제
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int selectNoticeCount(PaginationInfoVO<NoticeVO> pagingVO) {
		return noticeMapper.selectNoticeCount(pagingVO);
	}

	@Override
	public List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pagingVO) {
		return noticeMapper.selectNoticeList(pagingVO);
	}
	

	// ----------------------------------------- 로그인 컨트롤러 관련 이벤트 -----------------------------------------
	@Override
	public ServiceResult idCheck(String memId) {
		ServiceResult result = null;
		NoticeMemberVO noticeMemberVO = loginMapper.idCheck(memId);
		if (noticeMemberVO != null) {
			result = ServiceResult.EXIST;
		} else {
			result = ServiceResult.NOTEXIST;
		}
		return result;
	}

	@Override
	public ServiceResult signup(HttpServletRequest req, NoticeMemberVO memberVO) {
		ServiceResult result = null;
		
		// 회원가입 시, 프로필 이미지로 파일을 업로드 하는데 이때 업로드 할 서버 경로
		String uploadPath = req.getServletContext().getRealPath("/resources/profile");
		// 폴더 구조의 위치를 갖고 있는 파일 객체 생성
		File file = new File(uploadPath);
		// 해당 경로에 폴더구조가 만들어져 있는지 체크
		if (!file.exists()) {
			file.mkdirs();
		}
		
		String profileImg = "";	// 회원정보에 추가할 프로필 이미지 경로
		try {
			// 회원가입 할때 선택했던 프로필 이미지 파일
			MultipartFile profileImgFile = memberVO.getImgFile();
			
			// 넘겨받은 파일 데이터가 있는지 체크
			if (profileImgFile.getOriginalFilename() != null && !profileImgFile.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString();	// UUID 파일명 생성
				// UUID_원본파일명 생성
				fileName += "_" + profileImgFile.getOriginalFilename();
				uploadPath += "/" + fileName;	// /resources/profile/UUID_원본파일명
				profileImgFile.transferTo(new File(uploadPath));	// transferTo(new File(uploadPath))를 사용시 파일복사가 된다.
				// 파일 복사가 일어난 파일의 위치로 접근하기 위한 URI 설정
				profileImg = "/resources/profile/" + fileName;
			}
			memberVO.setMemProfileimg(profileImg);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 넘겨받은 비밀번호를 암호화 처리하여 데이터를 넘겨준다.
		memberVO.setMemPw(pw.encode(memberVO.getMemPw()));	// 비밀번호 암호화하기
		
		int status = loginMapper.signup(memberVO);
		if (status > 0) {	// 회원가입 성공
			// 한명의 회원이 등록 될 때 하나의 권한을 무조건 가질 수 있도록 권한 등록(스프링 시큐리티 적용시)
			loginMapper.signupAuth(memberVO.getMemNo());
			result = ServiceResult.OK;
		} else {	// 회원가입 실패
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public NoticeMemberVO loginCheck(NoticeMemberVO memberVO) {
		return loginMapper.loginCheck(memberVO);
	}

	@Override
	public String findId(Map<String, String> map) {
		return loginMapper.findId(map);
	}

	@Override
	public String findPw(Map<String, String> map) {
		return loginMapper.findPw(map);
	}

	@Override
	public NoticeFileVO noticeDownload(int fileNo) {
		NoticeFileVO noticeFileVO = noticeMapper.noticeDownload(fileNo);
		if (noticeFileVO == null) {
			throw new RuntimeException();
		}
		noticeMapper.incrementNoticeDowncount(fileNo);	// 다운로드 횟수 증가
		return noticeFileVO;
	}

	// ---------------------------------- 프로필 ---------------------------------- 
	@Override
	public NoticeMemberVO selectMember(String memId) {
		return profileMapper.selectMember(memId);
	}

	@Override
	public ServiceResult updateProfile(HttpServletRequest req, NoticeMemberVO memberVO) {
		ServiceResult result = null;
		String uploadPath = req.getServletContext().getRealPath("/resources/profile");
		// 폴더 구조의 위치를 갖고 있는 파일 객체 생성
		File file = new File(uploadPath);
		// 해당 경로에 폴더구조가 만들어져 있는지 체크
		if (!file.exists()) {
			file.mkdirs();
		}
		
		String profileImg = "";	// 회원정보에 추가할 프로필 이미지 경로
		try {
			// 수정시 선택했던 프로필 이미지 파일
			MultipartFile profileImgFile = memberVO.getImgFile();
			
			// 넘겨받은 파일 데이터가 있는지 체크
			if (profileImgFile.getOriginalFilename() != null && !profileImgFile.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString();	// UUID 파일명 생성
				// UUID_원본파일명 생성
				fileName += "_" + profileImgFile.getOriginalFilename();
				uploadPath += "/" + fileName;	// /resources/profile/UUID_원본파일명
				profileImgFile.transferTo(new File(uploadPath));	// transferTo(new File(uploadPath))를 사용시 파일복사가 된다.
				// 파일 복사가 일어난 파일의 위치로 접근하기 위한 URI 설정
				profileImg = "/resources/profile/" + fileName;
			}
			memberVO.setMemProfileimg(profileImg);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		memberVO.setMemPw(pw.encode(memberVO.getMemPw()));	// 비밀번호 암호화하기
		
		int status = profileMapper.updateProfile(memberVO);
		if (status > 0) {	
			result = ServiceResult.OK;
		} else {	
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

}
