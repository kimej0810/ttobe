package tobe.project.dao;


import java.util.List;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.ApprovalVO;
import tobe.project.dto.MemberVO;

public interface ApprovalDAO {
	public void writeApprovalDocument(ApprovalVO vo) throws Exception;
	public ApprovalVO selectOneApprovalDocumentContents(int e_documentNum) throws Exception;
	public void deleteApprovalDocument(int eidx) throws Exception;
	public void modifyApprovalDocument(ApprovalVO vo) throws Exception;
	public MemberVO selectOneMember(int tidx) throws Exception;
	
	public List<ApprovalVO> selectAllApprovalDocumentList(SearchCriteria scri) throws Exception;
	
	public int totalCountApprovalDocument(SearchCriteria scri) throws Exception;

	
}
