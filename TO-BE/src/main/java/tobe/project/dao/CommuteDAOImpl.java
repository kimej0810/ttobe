package tobe.project.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import tobe.project.dto.CommuteVO;

@Repository
public class CommuteDAOImpl implements CommuteDAO{

	@Inject
	private SqlSession sqlSession;
	private static final String Namespace = "tobe.project.mapper.commuteMapper";
	
	//출근시간 등록
	@Override
	public void addStartWork(CommuteVO vo) throws Exception {
		sqlSession.insert(Namespace+".addStartWork", vo);
		
	}

	//퇴근시간 등록
	@Override
	public void addEndWork(CommuteVO vo) throws Exception {
		sqlSession.update(Namespace+".addEndWork", vo);
		
	}
	
	//근태목록 조회
	@Override
	public List<CommuteVO> selectAllCommute(int tidx) throws Exception {
		return sqlSession.selectList(Namespace+"selectAllCommute", tidx);
	}
	
}
