package tobe.project.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import tobe.project.domain.SearchCriteria;
import tobe.project.dao.ApprovalDAO;
import tobe.project.dto.ApprovalVO;
import tobe.project.dto.MemberVO;

@Repository
public class ApprovalServiceImpl implements ApprovalService{

	@Inject
	private ApprovalDAO dao;

	@Override
	public void writeApprovalDocument(ApprovalVO vo) throws Exception {
		dao.writeApprovalDocument(vo);
	}

	@Override
	public ApprovalVO selectOneApprovalDocumentContents(int e_documentNum) throws Exception {
		return dao.selectOneApprovalDocumentContents(e_documentNum);
	}

	@Override
	public void modifyApprovalDocument(ApprovalVO vo) throws Exception{
		dao.modifyApprovalDocument(vo);
	}
	@Override
	public void deleteApprovalDocument(int eidx) throws Exception {
		dao.deleteApprovalDocument(eidx);
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
	
}
