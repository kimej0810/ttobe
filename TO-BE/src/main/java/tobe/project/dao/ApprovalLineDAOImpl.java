package tobe.project.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import tobe.project.dto.ApprovalDTO;

@Repository
public class ApprovalLineDAOImpl implements ApprovalLineDAO{

	@Inject
	private SqlSession sqlSession;
	private static final String Namespace = "tobe.project.mappers.approvalMapper";
	
	@Override
	public void writeApprovalLine(ApprovalDTO dto) throws Exception {
		sqlSession.insert(Namespace+".writeApprovalLine",dto);
	}

}
