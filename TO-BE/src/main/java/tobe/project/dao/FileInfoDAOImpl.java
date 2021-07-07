package tobe.project.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class FileInfoDAOImpl implements FileInfoDAO{
	
	@Inject
	private SqlSession sqlSession;
	private static final String Namespace = "tobe.project.mapper.fileInfoMapper";
	
	@Override
	public List<Map<String, Object>> selectAllFile(String str, int idx) throws Exception {
		
		if(str.equals("tidx")) {
			return sqlSession.selectList(Namespace+".selectAllFileTidx", idx);
			
		}else if(str.equals("bidx")) {
			return sqlSession.selectList(Namespace+".selectAllFileBidx", idx);
			
		}else if(str.equals("eidx")){
			return sqlSession.selectList(Namespace+".selectAllFileEidx", idx);
			
		}else if(str.equals("aidx")) {
			return sqlSession.selectList(Namespace+".selectAllFileAidx", idx);
			
		}else if(str.equals("didx")) {
			return sqlSession.selectList(Namespace+".selectAllFileDidx", idx);
		}
		
		return null;
	}

	@Override
	public Map<String, Object> selectOneFile(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne(Namespace+".selectOneFile", map);
	}

	@Override
	public void deleteFileDidx(int didx) throws Exception {
		sqlSession.update(Namespace+".deleteFileDidx", didx);
		
	}

	@Override
	public Map<String, String> selectFileTidx(int tidx) throws Exception {
		return sqlSession.selectOne(Namespace+".selectFileTidx", tidx);
	}

}
