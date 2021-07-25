package tobe.project.dao;


import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.ApprovalDTO;
import tobe.project.dto.ApprovalVO;
import tobe.project.dto.MemberVO;

@Repository
public class ApprovalDAOImpl implements ApprovalDAO{

	@Inject
	private SqlSession sqlSession;
	private static final String Namespace = "tobe.project.mappers.approvalMapper";
	
	@Override
	public void writeApprovalDocument(ApprovalDTO dto) throws Exception {				
		sqlSession.insert(Namespace+".writeApprovalDocument",dto);
	} 
	
	@Override
	public ApprovalDTO selectOneApprovalDocumentContents(int eidx) throws Exception {		
		return sqlSession.selectOne(Namespace+".selectOneApprovalDocumentContents",eidx);
	}
	 
	@Override
	public void modifyApprovalDocument(ApprovalDTO dto) throws Exception{
		sqlSession.update(Namespace+".modifyApprovalDocument",dto);
	}
	@Override
	public void deleteApprovalDocument(int eidx) throws Exception {
		sqlSession.delete(Namespace+".deleteApprovalDocument",eidx);
	}
	
	@Override
	public List<ApprovalVO> selectAllApprovalDocumentListNormal(SearchCriteria scri) throws Exception {
		return sqlSession.selectList(Namespace+".selectAllApprovalDocumentListNormal",scri);
	}

	@Override
	public int totalCountApprovalDocumentNormal(SearchCriteria scri) throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountApprovalDocumentNormal",scri);
	}
	
	@Override
	public List<ApprovalVO> selectAllApprovalDocumentList(SearchCriteria scri) throws Exception {
		return sqlSession.selectList(Namespace+".selectAllApprovalDocumentList",scri);
	}

	@Override
	public int totalCountApprovalDocument(SearchCriteria scri) throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountApprovalDocument",scri);
	}

	@Override
	public MemberVO selectOneMember(int tidx) throws Exception {
		return sqlSession.selectOne(Namespace+".selectOneMember",tidx);
	}
	@Override
	public MemberVO selectOneMemberId(String t_id) throws Exception {
		return sqlSession.selectOne(Namespace+".selectOneMemberId",t_id);
	}

	@Override
	public int totalCountWaiting() throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountWaiting");
	}

	@Override
	public int totalCountProgress() throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountProgress");
	}
	
	@Override
	public int totalCountNo() throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountNo");
	}

	@Override
	public int totalCountComplete() throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountComplete");
	}

	@Override
	public void modifyApprovalStatusProgress(int eidx) throws Exception {
		sqlSession.update(Namespace+".modifyApprovalStatusProgress",eidx);
		
	}

	@Override
	public int modifyApprovalStatusOk(int eidx) throws Exception {
		return sqlSession.update(Namespace+".modifyApprovalStatusOk",eidx);
	}

	@Override
	public void modifyApprovalStatusNo(ApprovalDTO dto) throws Exception {
		sqlSession.update(Namespace+".modifyApprovalStatusNo",dto);
		
	}

	@Override
	public void modifyApprovalDocumentAgain(ApprovalDTO dto) throws Exception {
		sqlSession.update(Namespace+".modifyApprovalDocumentAgain",dto);		
	}
}
