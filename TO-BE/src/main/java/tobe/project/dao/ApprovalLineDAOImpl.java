package tobe.project.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.ApprovalDTO;

@Repository
public class ApprovalLineDAOImpl implements ApprovalLineDAO{

	@Inject
	private SqlSession sqlSession;
	private static final String Namespace = "tobe.project.mappers.approvalLineMapper";
	
	@Override
	public void writeApprovalLine(ApprovalDTO dto) throws Exception {
		sqlSession.insert(Namespace+".writeApprovalLine",dto);
	}

	@Override
	public ApprovalDTO selectOneApprovalLine(int eidx) throws Exception {
		return sqlSession.selectOne(Namespace+".selectOneApprovalLine",eidx);
	}

	@Override
	public void modifyApprovalTeamLeader(int eidx) throws Exception {
		sqlSession.update(Namespace+".modifyApprovalTeamLeader",eidx);
		
	}

	@Override
	public void modifyApprovalDepartmentHead(int eidx) throws Exception {
		sqlSession.update(Namespace+".modifyApprovalDepartmentHead",eidx);
	}

	@Override
	public void modifyApprovalSectionHead(int eidx) throws Exception {
		sqlSession.update(Namespace+".modifyApprovalSectionHead",eidx);
	}

	@Override
	public void modifyApprovalLeader(int eidx) throws Exception {
		sqlSession.update(Namespace+".modifyApprovalLeader",eidx);
	}

	@Override
	public int totalCountMyApprovalToDo(String t_id) throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountMyApprovalToDo",t_id);
	}
}
