package tobe.project.dao;


import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.ApprovalVO;

@Repository
public class ApprovalDAOImpl implements ApprovalDAO{

	@Inject
	private SqlSession sqlSession;
	private static final String Namespace = "tobe.project.mappers.approvalMapper";
	
	@Override
	public void writeApprovalDocument(ApprovalVO vo) throws Exception {				//��ȵ��
		sqlSession.insert(Namespace+".writeApprovalDocument",vo);
	}
	
	@Override
	public ApprovalVO selectOneApprovalDocumentContents(int e_documentNum) throws Exception {		//�󼼺���
		return sqlSession.selectOne(Namespace+".selectOneApprovalDocumentContents",e_documentNum);
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
	public List<ApprovalVO> selectAllApprovalWaitingDocumentList(SearchCriteria scri) throws Exception {
		return sqlSession.selectList(Namespace+".selectAllApprovalWaitingDocumentList",scri);
	}

	@Override
	public List<ApprovalVO> selectAllApprovalProgressDocumentList(SearchCriteria scri) throws Exception {
		return sqlSession.selectList(Namespace+".selectAllApprovalProgressDocumentList",scri);
	}

	@Override
	public List<ApprovalVO> selectAllApprovalPaymentCompletedDocumentList(SearchCriteria scri) throws Exception {
		return sqlSession.selectList(Namespace+".selectAllApprovalPaymentCompletedDocumentList",scri);
	}

	@Override
	public int totalCountApprovalWaitingDocument(SearchCriteria scri) throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountApprovalWaitingDocument",scri);
	}

	@Override
	public int totalCountApprovalProgressDocument(SearchCriteria scri) throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountApprovalProgressDocument",scri);
	}

	@Override
	public int totalCountApprovalPaymentCompletedDocument(SearchCriteria scri) throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountApprovalPaymentCompletedDocument",scri);
	}

	
	
	
}
