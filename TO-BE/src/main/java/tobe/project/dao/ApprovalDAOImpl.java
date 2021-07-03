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
	public void writeApprovalDocument(ApprovalDTO dto) throws Exception {				//��ȵ��
		sqlSession.insert(Namespace+".writeApprovalDocument",dto);
	}
	
	@Override
	public ApprovalVO selectOneApprovalDocumentContents(int eidx) throws Exception {		//�󼼺���
		return sqlSession.selectOne(Namespace+".selectOneApprovalDocumentContents",eidx);
	}
	 
	@Override
	public void modifyApprovalDocument(ApprovalVO vo) throws Exception{
		sqlSession.update(Namespace+".modifyApprovalDocument",vo);
	}
	@Override
	public void deleteApprovalDocument(int eidx) throws Exception {
		sqlSession.delete(Namespace+".deleteApprovalDocument",eidx);
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
	public int totalCountWaiting() throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountWaiting");
	}

	@Override
	public int totalCountProgress() throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountProgress");
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
	public void modifyApprovalStatusOk(int eidx) throws Exception {
		sqlSession.update(Namespace+".modifyApprovalStatusOk",eidx);
	}

	
	
	
}
