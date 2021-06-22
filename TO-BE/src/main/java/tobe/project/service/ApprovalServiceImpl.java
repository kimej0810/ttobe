package tobe.project.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import tobe.project.domain.SearchCriteria;
import tobe.project.dao.ApprovalDAO;
import tobe.project.dto.ApprovalVO;

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
	public List<ApprovalVO> selectAllApprovalWaitingDocumentList(SearchCriteria scri) throws Exception {
		return dao.selectAllApprovalWaitingDocumentList(scri);
	}

	@Override
	public List<ApprovalVO> selectAllApprovalProgressDocumentList(SearchCriteria scri) throws Exception {
		return dao.selectAllApprovalProgressDocumentList(scri);
	}

	@Override
	public List<ApprovalVO> selectAllApprovalPaymentCompletedDocumentList(SearchCriteria scri) throws Exception {
		return dao.selectAllApprovalPaymentCompletedDocumentList(scri);
	}

	@Override
	public int totalCountApprovalWaitingDocument(SearchCriteria scri) throws Exception {
		return dao.totalCountApprovalWaitingDocument(scri);
	}

	@Override
	public int totalCountApprovalProgressDocument(SearchCriteria scri) throws Exception {
		return dao.totalCountApprovalProgressDocument(scri);
	}

	@Override
	public int totalCountApprovalPaymentCompletedDocument(SearchCriteria scri) throws Exception {
		return dao.totalCountApprovalPaymentCompletedDocument(scri);
	}

	
}
