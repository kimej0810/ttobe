package tobe.project.service;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import tobe.project.dao.ApprovalLineDAO;
import tobe.project.domain.SearchCriteria;
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

	@Override
	public int totalCountMyApprovalToDo(String t_id) throws Exception {	
		return dao.totalCountMyApprovalToDo(t_id);
	}

}
