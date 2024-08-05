package kr.or.ddit.service.impl;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.mapper.IMemberMapper;
import kr.or.ddit.service.IMemberService;
import kr.or.ddit.vo.crud.CrudMember;
import kr.or.ddit.vo.crud.CrudMemberAuth;

@Service
public class MemberServiceImpl implements IMemberService {

	@Inject
	private IMemberMapper mapper;
	
	@Transactional(rollbackFor = IOException.class)
	@Override
	public void register(CrudMember member) throws IOException{
		mapper.create(member); // 회원정보를 등록
		
		// 에러를 발생 : 롤백처리 x ==> IOException은 Exception을 상속받는다!!  
		// checkedException 계열도 rollbackFor 속성을 활용한다면 Rollback이 가능하다.
		if (true) {
			// 즉,RuntimeException계열이 아니 때문에 Rollback처리가 되지 않는다. 따라서 (rollbackFor = IOException.class) 속성을 붙여야 한다
			throw new IOException();
		}
		
		// UnCheckedException(RuntimeException을 상속받은 에러)는 롤백이 가능하다.
//		if (true) {
//			throw new NullPointerException();
//		}
		
		// 한명의 회원정보를 등록 후, 하나의 권한을 등록한다.
		CrudMemberAuth memberAuth = new CrudMemberAuth();
		memberAuth.setUserNo(member.getUserNo());
		memberAuth.setAuth("ROLE_USER");
		
		mapper.createAuth(memberAuth); // 회원 권한 등록
	}

	@Override
	public List<CrudMember> list() {
		return mapper.list();
	}

	@Override
	public CrudMember read(int userNo) {
		return mapper.read(userNo);
	}

	@Override
	public void modify(CrudMember member) {
		// 회원정보를 수정
		mapper.modify(member);
		// 회원정보 수정 완료 후, auth(권한)을 수정
		// 1. userNo에 해당하는 권한 모두를 삭세
		List<CrudMemberAuth> authList = member.getAuthList();
		
		int userNo = member.getUserNo();
		mapper.deleteAuth(userNo);
		for (int i = 0; i < authList.size(); i++) {
			CrudMemberAuth memberAuth = authList.get(i);
			String auth = memberAuth.getAuth();
			if (auth == null) {
				continue;
			}
			if (auth.trim().length() == 0) {
				continue;
			}
			memberAuth.setUserNo(userNo);
			mapper.createAuth(memberAuth);
		}
		// 2. 화면에서 전달받은 권한들로 다시 insert
	}

	@Override
	public void remove(int userNo) {
		mapper.deleteAuth(userNo);
		mapper.delete(userNo);
	}

}
