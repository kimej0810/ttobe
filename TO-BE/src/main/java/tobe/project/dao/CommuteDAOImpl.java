package tobe.project.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import tobe.project.dto.CommuteVO;

@Repository
public class CommuteDAOImpl implements CommuteDAO{

	@Inject
	private SqlSession sqlSession;
	private static final String Namespace = "tobe.project.mapper.commuteMapper";
	
	@Override
	public void addStartWork(CommuteVO vo) throws Exception {
		sqlSession.insert(Namespace+".addStartWork", vo);
	}

	@Override
	public void addEndWork(CommuteVO vo) throws Exception {
		sqlSession.update(Namespace+".addEndWork", vo);	
	}
	
	@Override
	public String selectStartWork(int tidx) throws Exception {
		return sqlSession.selectOne(Namespace+".selectStartWork", tidx);
	}
	
	@Override
	public String selectEndWork(int tidx) throws Exception {
		return sqlSession.selectOne(Namespace+".selectEndWork", tidx);
	}
	
	@Override
	public List<CommuteVO> selectAllCommute2(Map<String, Object> map) throws Exception {
		return sqlSession.selectList(Namespace+".selectAllCommute2", map);
	}

	
}
