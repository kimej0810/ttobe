package tobe.project.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.FileVO;
import tobe.project.dto.MemberVO;

public interface AdminService {
	public void insertAdmin(MemberVO vo, MultipartHttpServletRequest mpRequest)throws Exception;
	public List<MemberVO> selectAllMember() throws Exception;
	public int addMember(MemberVO vo) throws Exception;
	public int deleteMember(int tidx) throws Exception;
	public MemberVO selectOneMember(@Param(value="tidx")int tidx) throws Exception;
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
	//test
	public void addMember2(MemberVO memberVO, MultipartHttpServletRequest mpRequest)throws Exception;
	//첨부파일 조회
	public FileVO selectOneFile(int tidx) throws Exception;
	public int selectLastPk()throws Exception;
	//번호자동등록
	public int autoNumInsert(String autoNum)throws Exception;
	//번호가져오기
	public String autoNumSelect()throws Exception;
}
