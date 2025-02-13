package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.crud.NoticeFileVO;
import kr.or.ddit.vo.crud.NoticeVO;
import kr.or.ddit.vo.crud.PaginationInfoVO;

public interface INoticeMapper {
	public int insertNotice(NoticeVO noticeVO);
	public void incrementHit(int boNo);
	public NoticeVO selectNotice(int boNo);
	public int updateNotice(NoticeVO noticeVO);
	public int deleteNotice(int boNo);
	public int selectNoticeCount(PaginationInfoVO<NoticeVO> pagingVO);
	public List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pagingVO);
	public void insertNoticeFile(NoticeFileVO noticeFileVO);
	
	// 공지사항 게시판 다운로드
	public NoticeFileVO noticeDownload(int fileNo);
	public void incrementNoticeDowncount(int fileNo);
	
	public NoticeFileVO selectNoticeFile(Integer integer);
	public void deleteNoticeFile(Integer integer);
	public void deleteNoticeFileByBoNo(int boNo);
}
