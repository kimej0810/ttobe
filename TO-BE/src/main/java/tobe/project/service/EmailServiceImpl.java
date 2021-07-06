package tobe.project.service;

import java.io.FileReader;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import tobe.project.dao.EmailDAO;
import tobe.project.domain.SearchCriteria;
import tobe.project.dto.EmailDTO;
import tobe.project.util.MailHandler;

@Service
public class EmailServiceImpl implements EmailService{
	
	@Inject
	EmailDAO emailDAO;
	
	@Inject
	JavaMailSender mailSender;
	private static final String FROM_ADDRESS = "tobe202105@gmail.com";
	
	@Override
	public void sendEmail(EmailDTO emailVO) {
		
		try {
			MailHandler mailHandler = new MailHandler(mailSender);
			//받는사람
			mailHandler.setTo(emailVO.getM_addressee());
			//보내는사람
			mailHandler.setFrom(FROM_ADDRESS);
			//제목
			mailHandler.setSubject(emailVO.getM_title());
			//HTML Layout
			String htmlContent = "<img src='cid:sideImg'><div style='width:400px;height:400px;margin:auto;border:1px solid black;'>"+emailVO.getM_content()+"</div>";
			mailHandler.setText(htmlContent, true);
			//첨부파일
			//mailHandler.setAttach("test.png", "sideImg.png");
			//이미지삽입
			mailHandler.setInline("sideImg", "sideImg.png");
			mailHandler.send();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	@Override
	public int writeEmail(EmailDTO emailVO) throws Exception {
		return emailDAO.writeEmail(emailVO);
	}
	@Override
	public int totalCountEmail(String keyword) throws Exception {
		return emailDAO.totalCountEmail(keyword);
	}
	@Override
	public List<EmailDTO> searchEmailList(SearchCriteria searchCriteria) throws Exception {
		return emailDAO.searchEmailList(searchCriteria);
	}
	@Override
	public int totalCountsearchEmail(SearchCriteria searchCriteria) throws Exception {
		return emailDAO.totalCountsearchEmail(searchCriteria);
	}
	@Override
	public EmailDTO selectOneEmail(EmailDTO dto) throws Exception {
		return emailDAO.selectOneEmail(dto);
	}
	@Override
	public int searchMember(EmailDTO dto) throws Exception {
		return emailDAO.searchMember(dto);
	}
	@Override
	public int deleteEmail(int eidx) throws Exception {
		return emailDAO.deleteEmail(eidx);
	}
}
