package tobe.project.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO{

	@Inject
    private SqlSession sqlSession;
	private static final String Namespace = "tobe.project.mapper.boardMapper";
	
	@Override
	public List<BoardVO> selectAllBoard(SearchCriteria scri) throws Exception {
		return sqlSession.selectList(Namespace+".selectAllBoard", scri);
	}
	
	@Override
	public int totalCount(SearchCriteria scri) throws Exception {
		return sqlSession.selectOne(Namespace+".totalCount", scri);
	}

	@Override
	public BoardVO selectOneBoard(int bidx) throws Exception {
		return sqlSession.selectOne(Namespace+".selectOneBoard", bidx);
	}

	@Override
	public void writeBoard(BoardVO vo) throws Exception {
		sqlSession.insert(Namespace+".writeBoard", vo);	
	}
	
	@Override
	public void modifyBoard(BoardVO vo) throws Exception {
		sqlSession.update(Namespace+".modifyBoard", vo);	
	}

	@Override
	public void deleteBoard(int bidx) throws Exception {
		sqlSession.update(Namespace+".deleteBoard", bidx);
	}

	@Override
	public void hitBoard(int bidx) throws Exception {
		sqlSession.update(Namespace+".hitBoard", bidx);	
	}

	@Override
	public void insertFile(Map<String, Object> map) throws Exception {
		sqlSession.insert(Namespace+".insertFile", map);
		
	}
}
