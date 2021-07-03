package tobe.project.service;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.ApprovalDTO;

public interface ApprovalLineService {
	public void writeApprovalLine(ApprovalDTO dto) throws Exception;
	public ApprovalDTO selectOneApprovalLine(int eidx) throws Exception;
	
	public void modifyApprovalTeamLeader(int eidx) throws Exception;
	public void modifyApprovalDepartmentHead(int eidx) throws Exception;
	public void modifyApprovalSectionHead(int eidx) throws Exception;
	public void modifyApprovalLeader(int eidx) throws Exception;
	
	public int totalCountMyApprovalToDo(String t_id) throws Exception;
}
