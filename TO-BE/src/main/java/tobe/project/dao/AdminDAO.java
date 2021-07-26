package tobe.project.dao;

import java.util.List;
import java.util.Map;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.FileVO;
import tobe.project.dto.MemberVO;

public interface AdminDAO {
	public int insertAdmin(MemberVO vo)throws Exception;
	public List<MemberVO> selectAllMember() throws Exception;
	public int addMember(MemberVO vo) throws Exception;
	public int deleteMember(int tidx) throws Exception;
	public MemberVO selectOneMember(int tidx) throws Exception;
	public int modifyName(MemberVO vo) throws Exception;
	public int modifyPosition(MemberVO vo) throws Exception;
	public int modifyDepartment(MemberVO vo) throws Exception;
	public int adminCheck()throws Exception;
	//마지막 사원번호 가져오기
	public String selectOneId() throws Exception;
	//페이징
	public int totalCountMember(String keyword) throws Exception;
	public List<MemberVO> searchMemberList(SearchCriteria searchCriteria) throws Exception;
	public int totalCountsearchMember(SearchCriteria searchCriteria) throws Exception;
	//첨부파일 업로드
	public void addFile(Map<String,Object> map)throws Exception;
	//첨부파일 조회
	public FileVO selectOneFile(int tidx) throws Exception;
	public int selectLastPk()throws Exception;
}

