package tobe.project.dao;

import tobe.project.dto.ApprovalDTO;

public interface ApprovalLineDAO {
	public void writeApprovalLine(ApprovalDTO dto) throws Exception;
	
}
