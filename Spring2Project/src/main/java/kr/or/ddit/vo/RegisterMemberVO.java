package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class RegisterMemberVO {
	private String userId;
	private String password;
	private String userName;
	private String email;
	private Date birth;
	private String gender;
	private String developer;
	private boolean foreigner;
	private String nationality;
	private String cars;
	private String[] hobbyArray;
	private String introduction;
	private Address address;
	private List<Card> cardList; 
}
