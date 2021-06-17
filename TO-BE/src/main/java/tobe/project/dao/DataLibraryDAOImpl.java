package tobe.project.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import tobe.project.dto.DataLibraryVO;

@Repository
public class DataLibraryDAOImpl implements DataLibraryDAO{

	@Inject
    private SqlSession sqlSession;
	private static final String Namespace = "tobe.project.mapper.dataMapper";
	
	//자료실 목록
	@Override
	public List<DataLibraryVO> selectAllData() throws Exception {
		return sqlSession.selectList(Namespace+".selectAllData");
	}

	//자료실 업로드
	@Override
	public void addData(DataLibraryVO vo) throws Exception {
		sqlSession.insert(Namespace+".addData", vo);
		
	}

	//자료실 업로드(fileInfo)
	@Override
	public void insertFile(Map<String, Object> map) throws Exception {
		sqlSession.insert(Namespace+".insertFile", map);
		
	}

}
