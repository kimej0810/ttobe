package tobe.project.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.EmailDTO;
import tobe.project.dto.EmailVO;

@Repository
public class EmailDAOImpl implements EmailDAO{
	@Inject
	private SqlSession sqlSession;
	private static final String Namespace = "tobe.project.mapper.emailMapper";
	@Override
	public int writeEmail(EmailDTO emailVO) throws Exception {
		return sqlSession.insert(Namespace+".writeEmail", emailVO);
	}
	@Override
	public int totalCountEmail(String keyword) throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountEmail",keyword);
	}
	@Override
	public List<EmailDTO> searchEmailList(SearchCriteria searchCriteria) throws Exception {
		return sqlSession.selectList(Namespace+".searchEmailList",searchCriteria);
	}
	@Override
	public int totalCountsearchEmail(SearchCriteria searchCriteria) throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountsearchEmail",searchCriteria);
	}
	@Override
	public EmailDTO selectOneEmail(EmailDTO dto) throws Exception {
		return sqlSession.selectOne(Namespace+".selectOneEmail",dto);
	}
	@Override
	public int searchMember(EmailDTO dto)throws Exception{
		return sqlSession.selectOne(Namespace+".searchMember",dto);
	}
	@Override
	public int deleteEmail(int eidx)throws Exception{
		return sqlSession.update(Namespace+".deleteEmail",eidx);
	}
}
