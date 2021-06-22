package tobe.project.service;


import java.util.List;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.ApprovalVO;

public interface ApprovalService {
	public void writeApprovalDocument(ApprovalVO vo) throws Exception;
	public ApprovalVO selectOneApprovalDocumentContents(int e_documentNum) throws Exception;
	public void deleteApprovalDocument(int eidx) throws Exception;
	public void modifyApprovalDocument(ApprovalVO vo) throws Exception;
	
	public List<ApprovalVO> selectAllApprovalWaitingDocumentList(SearchCriteria scri) throws Exception;
	public List<ApprovalVO> selectAllApprovalProgressDocumentList(SearchCriteria scri) throws Exception;
	public List<ApprovalVO> selectAllApprovalPaymentCompletedDocumentList(SearchCriteria scri) throws Exception;
	
	public int totalCountApprovalWaitingDocument(SearchCriteria scri) throws Exception;
	public int totalCountApprovalProgressDocument(SearchCriteria scri) throws Exception;
	public int totalCountApprovalPaymentCompletedDocument(SearchCriteria scri) throws Exception;	
}
