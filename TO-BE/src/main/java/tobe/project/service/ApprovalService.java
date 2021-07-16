package tobe.project.service;


import java.util.List;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.ApprovalDTO;
import tobe.project.dto.ApprovalVO;
import tobe.project.dto.MemberVO;

public interface ApprovalService {
	public void writeApprovalDocument(ApprovalDTO dto) throws Exception;
	public ApprovalDTO selectOneApprovalDocumentContents(int eidx) throws Exception;
	public void deleteApprovalDocument(int eidx) throws Exception;
	public void modifyApprovalDocument(ApprovalDTO dto) throws Exception;
	public MemberVO selectOneMember(int tidx) throws Exception;
	
	public void modifyApprovalStatusProgress(int eidx) throws Exception;
	public int modifyApprovalStatusOk(int eidx) throws Exception;
	public void modifyApprovalStatusNo(ApprovalDTO dto) throws Exception;
	public void modifyApprovalDocumentAgain(ApprovalDTO dto) throws Exception;
	
	public List<ApprovalVO> selectAllApprovalDocumentList(SearchCriteria scri) throws Exception;
	public int totalCountApprovalDocument(SearchCriteria scri) throws Exception;
	 
	public int totalCountWaiting() throws Exception;
	public int totalCountProgress() throws Exception;
	public int totalCountComplete() throws Exception;
	public int totalCountNo() throws Exception;
}
 