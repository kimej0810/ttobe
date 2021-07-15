package tobe.project.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import tobe.project.dao.EmailDAO;
import tobe.project.domain.SearchCriteria;
import tobe.project.dto.EmailDTO;
import tobe.project.dto.MemberVO;
import tobe.project.util.MailHandler;

@Service
public class EmailServiceImpl implements EmailService{
	
	@Inject
	EmailDAO emailDAO;
	
	@Inject
	JavaMailSender mailSender;
	private static final String FROM_ADDRESS = "tobe202105@gmail.com";
	
	@Override
	public void joinEmail(MemberVO dto) {
		try {
			MailHandler mailHandler = new MailHandler(mailSender);
			mailHandler.setTo(dto.getT_email());
			mailHandler.setFrom(FROM_ADDRESS);
			mailHandler.setSubject("귀하의 입사를 축하합니다!");
			String htmlContent = "<img src='cid:joinImg1' width='800px;margin:auto;'><div style='width:700px;height:200px;margin:auto;'>"
					+ "<h2>입사를 축하합니다!</h2><br><br><br>귀하의 사원번호는 ["+dto.getT_id()+"] 이며, <br><br>초기 비밀번호는 ["+dto.getT_id()+"] 입니다.<br><br>로그인 후 비밀번호를 변경하시기 바랍니다.</div><img src='cid:joinImg2' width='800px;margin:auto;'>";
			mailHandler.setText(htmlContent, true);
			mailHandler.setInline("joinImg1", "joinImg1.png");
			mailHandler.setInline("joinImg2", "joinImg2.png");
			mailHandler.send();
			EmailDTO edto = new EmailDTO();
			edto.setM_addressee(dto.getT_email());
			edto.setM_content(htmlContent);
			edto.setM_title("귀하의 입사를 축하합니다!");
			edto.setTidx(dto.getTidx());
			emailDAO.writeEmail(edto);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	@Override
	public void sendEmail(EmailDTO emailVO) {
		try {
			MailHandler mailHandler = new MailHandler(mailSender);
			mailHandler.setTo(emailVO.getM_addressee());
			mailHandler.setFrom(FROM_ADDRESS);
			mailHandler.setSubject(emailVO.getM_title());
			String htmlContent = "<img src='cid:emailImg1' width='800px;margin:auto;'><div style='width:700px;height:200px;margin:auto;'>"
					+ ""+emailVO.getM_content()+"</div><img src='cid:emailImg2' width='800px;margin:auto;'>";
			mailHandler.setText(htmlContent, true);
			mailHandler.setInline("emailImg1", "emailImg1.png");
			mailHandler.setInline("emailImg2", "emailImg2.png");
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
