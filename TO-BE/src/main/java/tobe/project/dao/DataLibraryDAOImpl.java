package tobe.project.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.DataLibraryVO;

@Repository
public class DataLibraryDAOImpl implements DataLibraryDAO{

	@Inject
    private SqlSession sqlSession;
	private static final String Namespace = "tobe.project.mapper.dataMapper";
	
	//��猷��� 紐⑸�
	@Override
	public List<DataLibraryVO> selectAllData(SearchCriteria scri) throws Exception {
		return sqlSession.selectList(Namespace+".selectAllData", scri);
	}
	
	//��猷��� ��濡���
	@Override
	public void addData(DataLibraryVO vo) throws Exception {
		sqlSession.insert(Namespace+".addData", vo);
		
	}

	//��猷��� ��濡���(fileInfo)
	@Override
	public void insertFile(Map<String, Object> map) throws Exception {
		sqlSession.insert(Namespace+".insertFile", map);
	}

	@Override
	public int dataCount(SearchCriteria scri) throws Exception {
		return sqlSession.selectOne(Namespace+".dataCount", scri);
	}

	//議고���� 利�媛�
	@Override
	public void hitData(int didx) throws Exception {
		sqlSession.insert(Namespace+".hitData", didx);
	}

	@Override
	public void deleteData(int didx) throws Exception {
		sqlSession.update(Namespace+".deleteData", didx);
		
	}

}
