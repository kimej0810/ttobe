package tobe.project.service;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import tobe.project.dao.MemberDAO;
import tobe.project.dto.LoginDTO;
import tobe.project.dto.MemberDTO;
import tobe.project.dto.MemberVO;
import tobe.project.util.FileUtils;

@Repository
public class MemberServiceImpl implements MemberService{
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Inject
	private MemberDAO dao;
	
	@Inject
	BCryptPasswordEncoder pwdEncoder;
	
	@Override
	public List<MemberVO> selectAllMember() throws Exception{
		return dao.selectAllMember();
	}
	@Override
	public List<MemberDTO> searchDepartmentMember(String t_department)throws Exception{
		return dao.searchDepartmentMember(t_department);
	}
	@Override
	public MemberDTO selectOneMemberIdx(int tidx) throws Exception {
		return dao.selectOneMemberIdx(tidx);
	}
	@Override
	public List<MemberDTO> searchMember(MemberVO vo) throws Exception {
		return dao.searchMember(vo);
	}
	@Override
	public List<MemberDTO> searchMember2(String t_name) throws Exception {
		return dao.searchMember2(t_name);
	}
	//////////////////////////////////////////////////////////
	//로그인
	@Override
	public MemberDTO login(LoginDTO dto) throws Exception {
		return dao.login(dto);
	}
	//비밀번호 변경
	@Override
	public int modifyPwd(MemberVO vo) throws Exception {
		return dao.modifyPwd(vo);
	}
	//비밀번호 찾기 이메일 전송
	@Override
	public void sendEmail(MemberVO vo, String div,String pwd) throws Exception {
		//메일 서버 설정
		String charSet = "UTF-8";
		String hostSMTP = "smtp.gmail.com";
		String hostSMTPid = "tobe202105@gmail.com";
		String hostSMTPpwd = "tobe0524!";
		//보내는 사람 설정
		String fromEmail = "tobe202105@gmail.com";
		String fromName = "AFPS";
		String subject = "";
		String msg = "";
		if(div.equals("findPwd")) {
			subject = "AFPS 임시 비밀번호 입니다.";
			msg += vo.getT_id() + "님의 임시 비밀번호입니다. 비밀번호를 변경하여 사용하세요.";
			msg += "임시 비밀번호 :";
			msg += pwd;
		}
		//받는사람 설정
		String email = vo.getT_email();
		try {
			HtmlEmail htmlEmail = new HtmlEmail();
			htmlEmail.setDebug(true);
			htmlEmail.setCharset(charSet);
			htmlEmail.setSSL(true);
			htmlEmail.setHostName(hostSMTP);
			htmlEmail.setSmtpPort(465);
			htmlEmail.setAuthentication(hostSMTPid, hostSMTPpwd);
			htmlEmail.setTLS(true);
			htmlEmail.addTo(email, charSet);
			htmlEmail.setFrom(fromEmail, fromName, charSet);
			htmlEmail.setSubject(subject);
			htmlEmail.setHtmlMsg(msg);
			htmlEmail.send();
		}catch (Exception e) {
			System.out.println("메일 전송 실패 : " + e);
		}
	}
	//비밀번호 찾기
	@Override
	public void findPwd(HttpServletResponse response, MemberVO vo) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		MemberDTO mvo = dao.selectOneMemberId(vo.getT_id());
		if(dao.checkId(vo.getT_id()) == 0){
			out.print("등록되지 않은 아이디 입니다.");
			out.close();
		} else if(!vo.getT_email().equals(mvo.getT_email())) {
			out.print("등록되지 않은 이메일입니다.");
			out.close(); 
		}else {
			String pwd = ""; 
			for(int i=0; i<12; i++) {
				pwd += (char)((Math.random()*26)+97);
			}
			
			String repwd = pwdEncoder.encode(pwd);
			vo.setT_pwd(repwd);
			dao.modifyPwd(vo); sendEmail(vo,"findPwd",pwd);
			out.print("이메일로 임시 비밀번호를 발송하였습니다."); out.close();
		}
	}
	//사원정보 조회?
	@Override
	public MemberDTO selectOneMember(String t_id) throws Exception {
		return dao.selectOneMemberId(t_id);
	}
	//사원정보 수정
	@Override
	public void modifyMember(MemberVO vo, MultipartHttpServletRequest mpRequest) throws Exception {
		dao.modifyMember(vo);
		
		List<Map<String, Object>> list = fileUtils.parseInsertFileInfoProfile(vo, mpRequest);
		int size = list.size();
		for(int i=0; i<size; i++){
			dao.insertFile(list.get(i));
		}
		
	}
	@Override
	public List<MemberDTO> selectAllMember2() throws Exception {
		return dao.selectAllMember2();
	}
}