package tobe.project.dao;

import java.util.List;
import java.util.Map;

public interface FileInfoDAO {
	//파일 조회
	public List<Map<String, Object>> selectAllFile(String str, int idx) throws Exception;
	//파일 다운로드
	public Map<String, Object> selectOneFile(Map<String, Object> map) throws Exception;
	
}
