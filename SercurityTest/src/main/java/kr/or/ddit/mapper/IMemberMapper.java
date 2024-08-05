package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.CrudMember;
import kr.or.ddit.vo.CrudMemberAuth;

public interface IMemberMapper {
	public CrudMember readByUserId(String username);
}
