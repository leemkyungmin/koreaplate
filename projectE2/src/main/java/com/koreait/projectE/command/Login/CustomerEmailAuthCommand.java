package com.koreait.projectE.command.Login;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.ui.Model;

public class CustomerEmailAuthCommand {

	public long execute(SqlSession sqlSession, Model model) {
		
		long authKey = 0;	
		
		try {
				
			Map<String, Object> map = model.asMap();
			HttpServletRequest request = (HttpServletRequest)map.get("request");
			JavaMailSender mailSender = (JavaMailSender)map.get("mailSender");
			
			// SimpleMailMessage 클래스가 이메일 내용을 작성한다. 
			SimpleMailMessage message = new SimpleMailMessage();
			
			message.setFrom("admin@gmail.com");
			message.setTo(request.getParameter("cEmail")); 
			message.setSubject("인증메일입니다."); 
			authKey = (long)(Math.random() * 1000000000) + 12345678; 
			message.setText("다음 인증 번호를 입력하세요."); 
			message.setText("인증번호 : " + authKey); 
			
			// mailSender 는 send() 메소드로 이메일을 보낸다.
			
			mailSender.send(message);
			
			} catch (Exception e) {
				e.printStackTrace();
			}
		
			return authKey; // 값을 보내줘야 기억하고 비교를 한다.
		
	}

}
