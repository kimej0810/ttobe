package tobe.project.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

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
			mailHandler.setTo(emailVO.getM_addressee());
			mailHandler.setFrom(FROM_ADDRESS);
			mailHandler.setSubject(emailVO.getM_title());
			String htmlContent = "<img src='cid:sideImg'><div style='width:400px;height:400px;margin:auto;border:1px solid black;'>"+emailVO.getM_content()+"</div>";
			mailHandler.setText(htmlContent, true);
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
