package tobe.project.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import tobe.project.dto.LoginDTO;
import tobe.project.dto.MemberDTO;
import tobe.project.dto.MemberVO;

public interface MemberService {
	public List<MemberVO> selectAllMember() throws Exception;
	public List<MemberDTO> searchDepartmentMember(@Param(value="t_department")String t_department) throws Exception;
	public MemberDTO selectOneMemberIdx(@Param(value="tidx")int tidx) throws Exception;
	public List<MemberVO> searchMember(MemberVO vo)throws Exception;
	//부서전체 검색
	public List<MemberVO> searchMember2(String t_name)throws Exception;
	//로그인
	public MemberDTO login(LoginDTO dto) throws Exception;
	//이메일 전송
	public void sendEmail(MemberVO vo, String div, String pwd) throws Exception;
	//비밀번호 찾기
	public void findPwd(HttpServletResponse response, MemberVO vo) throws Exception;
	//사원정보 수정
	public void modifyMember(MemberVO vo, MultipartHttpServletRequest mpRequest) throws Exception;
	public MemberDTO selectOneMember(String t_id) throws Exception;
	//비밀번호 변경
	public int modifyPwd(MemberVO vo) throws Exception;
	public List<MemberDTO> selectAllMember2()throws Exception;
}
