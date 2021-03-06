package tobe.project.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import tobe.project.domain.SearchCriteria;
import tobe.project.dao.ApprovalDAO;
import tobe.project.dto.ApprovalDTO;
import tobe.project.dto.ApprovalVO;
import tobe.project.dto.MemberVO;

@Repository
public class ApprovalServiceImpl implements ApprovalService{

	@Inject
	private ApprovalDAO dao;

	@Override
	public void writeApprovalDocument(ApprovalDTO dto) throws Exception {
		dao.writeApprovalDocument(dto);
	}

	@Override
	public ApprovalDTO selectOneApprovalDocumentContents(int eidx) throws Exception {
		return dao.selectOneApprovalDocumentContents(eidx);
	} 

	@Override
	public void modifyApprovalDocument(ApprovalDTO dto) throws Exception{
		dao.modifyApprovalDocument(dto); 
	}
	@Override
	public void deleteApprovalDocument(int eidx) throws Exception {
		dao.deleteApprovalDocument(eidx);
	}
	
	@Override
	public List<ApprovalVO> selectAllApprovalDocumentListNormal(SearchCriteria scri) throws Exception {
		return dao.selectAllApprovalDocumentListNormal(scri);
	}

	@Override
	public int totalCountApprovalDocumentNormal(SearchCriteria scri) throws Exception {
		return dao.totalCountApprovalDocumentNormal(scri);
	}
	
	@Override
	public List<ApprovalVO> selectAllApprovalDocumentList(SearchCriteria scri) throws Exception {
		return dao.selectAllApprovalDocumentList(scri);
	}
	@Override
	public int totalCountApprovalDocument(SearchCriteria scri) throws Exception {
		return dao.totalCountApprovalDocument(scri);
	}

	@Override
	public MemberVO selectOneMember(int tidx) throws Exception {
		return dao.selectOneMember(tidx);
	}
	@Override
	public MemberVO selectOneMemberId(String t_id) throws Exception {
		return dao.selectOneMemberId(t_id);
	}
	
	@Override
	public int totalCountWaiting() throws Exception {
		return dao.totalCountWaiting();
	}

	@Override
	public int totalCountProgress() throws Exception {
		return dao.totalCountProgress();
	}

	@Override
	public int totalCountComplete() throws Exception {
		return dao.totalCountComplete();
	}
	
	@Override
	public int totalCountNo() throws Exception {
		return dao.totalCountNo();
	}
	
	@Override
	public void modifyApprovalStatusProgress(int eidx) throws Exception {
		dao.modifyApprovalStatusProgress(eidx);
	}

	@Override
	public int modifyApprovalStatusOk(int eidx) throws Exception {
		return dao.modifyApprovalStatusOk(eidx);
	}

	@Override
	public void modifyApprovalStatusNo(ApprovalDTO dto) throws Exception {
		dao.modifyApprovalStatusNo(dto);
	}

	@Override
	public void modifyApprovalDocumentAgain(ApprovalDTO dto) throws Exception {
		dao.modifyApprovalDocumentAgain(dto);
	}
}
