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

}
