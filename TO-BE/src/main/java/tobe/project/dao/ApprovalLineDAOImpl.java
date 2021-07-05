package tobe.project.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.mysql.cj.Session;

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
	//승인
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
	//반려
	@Override
	public void modifyApprovalNo(int eidx) throws Exception {
		sqlSession.update(Namespace+".modifyApprovalNo",eidx);
	}
	//재기안
	@Override
	public void modifyApprovalDocumentAgainLine(ApprovalDTO dto) throws Exception {
		sqlSession.update(Namespace+".modifyApprovalDocumentAgainLine",dto);
	}
	//결제대기문서 (결재순서 도착)
	@Override
	public int totalCountTeamLeaderApprovalToDo(String t_id) throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountTeamLeaderApprovalToDo",t_id);
	}
	@Override
	public int totalCountDepartmentHeadApprovalToDo(String t_id) throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountDepartmentHeadApprovalToDo",t_id);
	}
	@Override
	public int totalCountSectionHeadApprovalToDo(String t_id) throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountSectionHeadApprovalToDo",t_id);
	}
	@Override
	public int totalCountLeaderApprovalToDo(String t_id) throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountLeaderApprovalToDo",t_id);
	}
	//결제대기문서 끝

	//결재예정문서(결재순서 미도착)
	@Override
	public int totalCountDepartmentHeadApprovalMust(String t_id) throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountDepartmentHeadApprovalMust",t_id);
	}
	@Override
	public int totalCountSectionHeadApprovalMust(String t_id) throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountSectionHeadApprovalMust",t_id);
	}
	@Override
	public int totalCountLeaderApprovalMust(String t_id) throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountLeaderApprovalMust",t_id);
	}
	//결제예정문서 끝
	
	
}
