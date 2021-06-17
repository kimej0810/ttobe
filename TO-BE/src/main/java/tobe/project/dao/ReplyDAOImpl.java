package tobe.project.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import tobe.project.dto.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO{

	@Inject
    private SqlSession sqlSession;
	private static final String Namespace = "tobe.project.mapper.replyMapper";
	
	@Override
	public List<ReplyVO> list(int bidx) throws Exception {
		return sqlSession.selectList(Namespace+".list", bidx);
	}

	@Override
	public void create(ReplyVO vo) throws Exception {
		sqlSession.insert(Namespace+".create", vo);
		
	}

	@Override
	public void update(ReplyVO vo) throws Exception {
		sqlSession.update(Namespace+".update", vo);
		
	}

	@Override
	public void delete(int ridx) throws Exception {
		sqlSession.update(Namespace+".delete", ridx);	
	}
	
}
