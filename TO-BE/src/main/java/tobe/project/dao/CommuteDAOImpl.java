package tobe.project.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import tobe.project.dto.CommuteVO;
import tobe.project.dto.LeaveVO;

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
	
	@Override
	public List<CommuteVO> selectAllCommute(int tidx) throws Exception {
		return sqlSession.selectList(Namespace+".selectAllCommute", tidx);
	}
	
	//근태목록 조회테스트
	@Override
	public List<CommuteVO> selectAllCommute2(Map<String, Object> map) throws Exception {
		return sqlSession.selectList(Namespace+".selectAllCommute2", map);
	}

	//출근기록조회
	@Override
	public String selectStartWork(int tidx) throws Exception {
		return sqlSession.selectOne(Namespace+".selectStartWork", tidx);
	}
	
	//퇴근기록조회
	@Override
	public String selectEndWork(int tidx) throws Exception {
		return sqlSession.selectOne(Namespace+".selectEndWork", tidx);
	}
	
}
