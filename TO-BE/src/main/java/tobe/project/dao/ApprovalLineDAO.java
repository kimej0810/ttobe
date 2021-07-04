package tobe.project.dao;

import tobe.project.dto.ApprovalDTO;

public interface ApprovalLineDAO {
	public void writeApprovalLine(ApprovalDTO dto) throws Exception;
	public ApprovalDTO selectOneApprovalLine(int eidx) throws Exception;
	
	public void modifyApprovalTeamLeader(int eidx) throws Exception;
	public void modifyApprovalDepartmentHead(int eidx) throws Exception;
	public void modifyApprovalSectionHead(int eidx) throws Exception;
	public void modifyApprovalLeader(int eidx) throws Exception;
	
	//결제대기문서 (결재순서 도착)
	public int totalCountTeamLeaderApprovalToDo(String t_id) throws Exception;
	public int totalCountDepartmentHeadApprovalToDo(String t_id) throws Exception;
	public int totalCountSectionHeadApprovalToDo(String t_id) throws Exception;
	public int totalCountLeaderApprovalToDo(String t_id) throws Exception;
	//결재예정문서(결재순서 미도착)
	public int totalCountDepartmentHeadApprovalMust(String t_id) throws Exception;
	public int totalCountSectionHeadApprovalMust(String t_id) throws Exception;
	public int totalCountLeaderApprovalMust(String t_id) throws Exception;
	
}
