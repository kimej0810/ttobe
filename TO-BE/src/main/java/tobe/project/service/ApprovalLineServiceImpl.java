package tobe.project.service;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import tobe.project.dao.ApprovalLineDAO;
import tobe.project.dto.ApprovalDTO;

@Repository
public class ApprovalLineServiceImpl implements ApprovalLineService{

	@Inject
	private ApprovalLineDAO dao;
	
	@Override
	public void writeApprovalLine(ApprovalDTO dto) throws Exception {
		dao.writeApprovalLine(dto);
	}
	@Override
	public ApprovalDTO selectOneApprovalLine(int eidx) throws Exception {
		return dao.selectOneApprovalLine(eidx);
	}
	 
	//결재승인
	@Override
	public void modifyApprovalTeamLeader(int eidx) throws Exception {
		dao.modifyApprovalTeamLeader(eidx);
	}
	@Override
	public void modifyApprovalDepartmentHead(int eidx) throws Exception {
		dao.modifyApprovalDepartmentHead(eidx);
	}
	@Override
	public void modifyApprovalSectionHead(int eidx) throws Exception {
		dao.modifyApprovalSectionHead(eidx);
	}
	@Override
	public void modifyApprovalLeader(int eidx) throws Exception {
		dao.modifyApprovalLeader(eidx);
	}
	//결재반려
	@Override
	public void modifyApprovalNo(int eidx) throws Exception {
		dao.modifyApprovalNo(eidx);
	}
	//재기안
	@Override
	public void modifyApprovalDocumentAgainLine(ApprovalDTO dto) throws Exception {
		dao.modifyApprovalDocumentAgainLine(dto);
	}
	
	//결제대기문서 (결재순서 도착)
	@Override
	public int totalCountTeamLeaderApprovalToDo(String t_id) throws Exception {	
		return dao.totalCountTeamLeaderApprovalToDo(t_id);
	}
	@Override
	public int totalCountDepartmentHeadApprovalToDo(String t_id) throws Exception {
		return dao.totalCountDepartmentHeadApprovalToDo(t_id);
	}
	@Override
	public int totalCountSectionHeadApprovalToDo(String t_id) throws Exception {
		return dao.totalCountSectionHeadApprovalToDo(t_id);
	}
	@Override
	public int totalCountLeaderApprovalToDo(String t_id) throws Exception {
		return dao.totalCountLeaderApprovalToDo(t_id);
	}
	//결제대기문서 끝

	//결재예정문서(결재순서 미도착)
	@Override
	public int totalCountDepartmentHeadApprovalMust(String t_id) throws Exception {
		return dao.totalCountDepartmentHeadApprovalMust(t_id);
	}
	@Override
	public int totalCountSectionHeadApprovalMust(String t_id) throws Exception {
		return dao.totalCountSectionHeadApprovalMust(t_id);
	}
	@Override
	public int totalCountLeaderApprovalMust(String t_id) throws Exception {
		return dao.totalCountLeaderApprovalMust(t_id);
	}
	//결제예정문서 끝
	
	
}
