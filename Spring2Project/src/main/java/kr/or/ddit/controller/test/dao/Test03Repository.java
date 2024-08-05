package kr.or.ddit.controller.test.dao;

import java.util.ArrayList;
import java.util.List;

import kr.or.ddit.controller.test.vo.StudentVO;

public class Test03Repository {
	
	// 305로 학생 정보를 담을 리스트
	private List<StudentVO> studentList = new ArrayList<StudentVO>();
	
	public Test03Repository() {
		// StudentVO를 활용하여 305호 학생 5명을 초기화해주세요!
		// # 첫번째 학생
		// 아이디 : a001
		// 비밀번호 : 1234
		// 이름 : 홍길동
		// 핸드폰번호 : 010-1234-1234
		// 이메일 : a001@naver.com 과 같은 데이터로 학생 총 5명의 데이터를 초기화 한 후,
		// 학생 정보를 담을 리스트에 추가해주세요!
		
		StudentVO student1 = new StudentVO();
		student1.setMemId("a001");
		student1.setMemPw("1234");
		student1.setMemName("홍길동");
		student1.setMemEmail("a001@google.com");
		student1.setMemPhone("010-1234-5678");
		
		StudentVO student2 = new StudentVO();
		student2.setMemId("a002");
		student2.setMemPw("1234");
		student2.setMemName("홍길서");
		student2.setMemEmail("a002@google.com");
		student2.setMemPhone("010-1234-1234");
		
		StudentVO student3 = new StudentVO();
		student3.setMemId("a003");
		student3.setMemPw("1234");
		student3.setMemName("홍길남");
		student3.setMemEmail("a003@google.com");
		student3.setMemPhone("010-1234-9876");
		
		StudentVO student4 = new StudentVO();
		student4.setMemId("a004");
		student4.setMemPw("1234");
		student4.setMemName("홍길북");
		student4.setMemEmail("a004@google.com");
		student4.setMemPhone("010-9876-1234");
		
		StudentVO student5 = new StudentVO();
		student5.setMemId("a005");
		student5.setMemPw("1234");
		student5.setMemName("홍길홍");
		student5.setMemEmail("a005@google.com");
		student5.setMemPhone("010-9876-9876");
		
		studentList.add(student1);
		studentList.add(student2);
		studentList.add(student3);
		studentList.add(student4);
		studentList.add(student5);
		
	}
	
	// 기능 구현
	// 1) 학생 전체 가져오기
	public List<StudentVO> getList() {
		return studentList;
	}

	// 2) 학생 한명 정보 가져오기
	public StudentVO getInfo(String id) {
		for (StudentVO studentVO : studentList) {
			if (studentVO.getMemId().equals(id)) {
				return studentVO;
			}
		}
		return null;
	}
	
	// 3) 이름, 이메일 정보를 활용해 학생 아이디 가져오기
	public String getId(String name, String email) {
		for (StudentVO studentVO : studentList) {
			if (studentVO.getMemName().equals(name) && studentVO.getMemEmail().equals(email)) {
				return studentVO.getMemId();
			}
		}
		return null;
	}
	
	// 4) 아이디, 이름, 이메일 정로블 활용해 학생 비밀번호 가져오기
	public String getPassword(String id, String name, String email) {
		for (StudentVO studentVO : studentList) {
			if (studentVO.getMemId().equals(id) && studentVO.getMemName().equals(name) && studentVO.getMemEmail().equals(email)) {
				return studentVO.getMemPw();
			}
		}
		return null;
	}
	
	// 등등 필요에 의한 기능을 구현해주세요!
	// 위 4가지 기능은 필수!
	
}
