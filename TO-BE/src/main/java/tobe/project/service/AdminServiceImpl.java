package tobe.project.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import tobe.project.dao.AdminDAO;
import tobe.project.domain.SearchCriteria;
import tobe.project.dto.FileVO;
import tobe.project.dto.MemberVO;
import tobe.project.util.FileUtils;

@Repository
public class AdminServiceImpl implements AdminService{
	@Inject
	private AdminDAO dao;
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Override
	public void insertAdmin(MemberVO vo,MultipartHttpServletRequest mpRequest) throws Exception {
		dao.insertAdmin(vo);
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfoProfile(vo,mpRequest);
		int size = list.size();
		for(int i=0;i<size;i++) {
			dao.addFile(list.get(i));
		}
	}
	@Override
	public List<MemberVO> selectAllMember() throws Exception{
		return dao.selectAllMember();
	}
	@Override
	public int addMember(MemberVO vo) throws Exception{
		return dao.addMember(vo);
	}
	@Override
	public int deleteMember(int tidx) throws Exception {
		return dao.deleteMember(tidx);
	}
	@Override
	public MemberVO selectOneMember(int tidx) throws Exception {
		return dao.selectOneMember(tidx);
	}
	@Override
	public int modifyName(MemberVO vo) throws Exception {
		return dao.modifyName(vo);
	}
	@Override
	public int modifyPosition(MemberVO vo) throws Exception {
		return dao.modifyPosition(vo);
	}
	@Override
	public int modifyDepartment(MemberVO vo) throws Exception {
		return dao.modifyDepartment(vo);
	}
	@Override
	public int adminCheck() throws Exception {
		return dao.adminCheck();
	}
	@Override
	public int totalCountMember(String keyword) throws Exception {
		return dao.totalCountMember(keyword);
	}
	@Override
	public List<MemberVO> searchMemberList(SearchCriteria searchCriteria) throws Exception {
		return dao.searchMemberList(searchCriteria);
	}
	@Override
	public int totalCountsearchMember(SearchCriteria searchCriteria) throws Exception {
		return dao.totalCountsearchMember(searchCriteria);
	}
	@Override
	public void addMember2(MemberVO memberVO, MultipartHttpServletRequest mpRequest) throws Exception {
		dao.addMember(memberVO);
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfoProfile(memberVO,mpRequest);
		int size = list.size();
		for(int i=0;i<size;i++) {
			dao.addFile(list.get(i));
		}
	}
	@Override
	public FileVO selectOneFile(int tidx) throws Exception {
		return dao.selectOneFile(tidx);
	}
	@Override
	public String selectOneId() throws Exception {
		return dao.selectOneId();
	}
	@Override
	public int selectLastPk() throws Exception {
		return dao.selectLastPk();
	}
}
