package kr.or.ddit.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;

public class CustomNoOpPasswordEncoder implements PasswordEncoder {

	private static final Logger log = LoggerFactory.getLogger(CustomNoOpPasswordEncoder.class);
	
	@Override
	public String encode(CharSequence rawPassword) { // 내가넘긴 비밀번호를 암호화할때
		log.info("encode() 실행...!");
		log.info("before encode(password) : " + rawPassword);
		return rawPassword.toString();
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) { // 내가넘긴 비밀번호와 DB의 비밀번호를 비교
		log.info("matches() 실행...!");
		log.info("matches : " + rawPassword + " : " + encodedPassword);
		return rawPassword.toString().equals(encodedPassword);
	}
	
}
