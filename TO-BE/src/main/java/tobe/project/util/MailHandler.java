package tobe.project.util;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class MailHandler {
	private JavaMailSender sender;
	private MimeMessage message;
	private MimeMessageHelper messageHelper;
	//create
	public MailHandler(JavaMailSender jSender) throws MessagingException {
		this.sender = jSender;
		message = jSender.createMimeMessage();
		messageHelper = new MimeMessageHelper(message,true,"UTF-8");
	}
	//from 매개변수명 수정하기
	public void setFrom(String fromAddress) throws MessagingException {
		messageHelper.setFrom(fromAddress);
	}
	//to 매개변수명 수정하기
	public void setTo(String email) throws MessagingException {
		messageHelper.setTo(email);
	}
	//title
	public void setSubject(String subject) throws MessagingException {
		messageHelper.setSubject(subject);
	}
	//contents
	public void setText(String text, boolean useHtml) throws MessagingException{
		messageHelper.setText(text,useHtml);
	}
	//file
	public void setAttach(String displayFileName, String pathToAttachment) throws MessagingException, IOException{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder
			      .getRequestAttributes()).getRequest();
		String filePath = request.getSession().getServletContext().getRealPath("/resources/static/img/");
		DataSource dataSource = new FileDataSource(filePath+pathToAttachment);
		messageHelper.addAttachment(displayFileName, dataSource);
	}
	//image
		public void setInline(String contentId, String pathToInline) throws MessagingException, IOException{
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder
				      .getRequestAttributes()).getRequest();
			String filePath = request.getSession().getServletContext().getRealPath("/resources/static/img/");
			DataSource dataSource = new FileDataSource(filePath+pathToInline);
			messageHelper.addInline(contentId,dataSource);
		}
	//send
	public void send() {
		try {
			sender.send(message);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
