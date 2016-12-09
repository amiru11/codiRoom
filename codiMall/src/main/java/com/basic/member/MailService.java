package com.basic.member;

import javax.inject.Inject;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailService {
	
	@Inject
	private JavaMailSender mailSender;
	
	public void IdFind(MemberDTO memberDTO, String mail){
		MimeMessage msg = mailSender.createMimeMessage();
		
		try {
	        msg.setSubject("[안내] 아이디 발신 <관리자가 보낸메일>", "UTF-8");
	        String htmlContent = "당신의 아이디는 <Strong>" + memberDTO.getId() + "</Strong> 입니다. 사이트에 접속해서 로그인 하세요.<br>";
			htmlContent += "<a href='http://localhost:8080/codi/' target='_blank'>홈으로 이동</a>";
	        msg.setText(htmlContent, "UTF-8", "html");
	        msg.setRecipient(RecipientType.TO , new InternetAddress(mail));
	        msg.setFrom(new InternetAddress("chlalfm88@gmail.com"));
	        
	        mailSender.send(msg);
	        
			} catch (Exception e) {
				// TODO: handle exception
			}
	}
	
	public void PwFind(MemberDTO memberDTO) {
        MimeMessage msg = mailSender.createMimeMessage();
        
        try {
        msg.setSubject("[안내] 임시 비밀번호 발신 <관리자가 보낸메일>", "UTF-8");
        String htmlContent = "당신의 임시 비밀번호는 <Strong>" + memberDTO.getPw() + "</Strong> 입니다. 사이트에 접속해서 로그인 후 비밀번호를 변경하세요.<br>";
		htmlContent += "<a href='http://localhost:8080/codi/' target='_blank'>홈으로 이동</a>";
        msg.setText(htmlContent, "UTF-8", "html");
        msg.setRecipient(RecipientType.TO , new InternetAddress(memberDTO.getId()));
        msg.setFrom(new InternetAddress("chlalfm88@gmail.com"));
        
        mailSender.send(msg);
        
		} catch (Exception e) {
			// TODO: handle exception
		}
    }
	
	

}
