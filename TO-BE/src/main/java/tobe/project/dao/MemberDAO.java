package tobe.project.dao;

import java.util.List;
import java.util.Map;

import tobe.project.dto.LoginDTO;
import tobe.project.dto.MemberDTO;
import tobe.project.dto.MemberVO;

public interface MemberDAO {
	
	public List<MemberVO> selectAllMember() throws Exception;
	public List<MemberDTO> searchDepartmentMember(String t_department) throws Exception;
	public MemberDTO selectOneMemberIdx(int tidx) throws Exception;
	public List<MemberDTO> searchMember(MemberVO vo)throws Exception;
	public List<MemberDTO> searchMember2(String t_name)throws Exception;
	//로그인
	public MemberDTO login(LoginDTO dto) throws Exception;
	//사원정보 수정
	public void modifyMember(MemberVO vo) throws Exception;
	//사진 업로드
	public void insertFile(Map<String, Object> map) throws Exception;
	//비밀번호 변경
	public int modifyPwd(MemberVO vo) throws Exception;
	//비밀번호찾기 아이디체크
	public int checkId(String id) throws Exception;
	//사원
	public MemberDTO selectOneMemberId(String t_id) throws Exception;
	public MemberVO selectOneMember(String t_id) throws Exception;
	public List<MemberDTO> selectAllMember2()throws Exception;
	
}
