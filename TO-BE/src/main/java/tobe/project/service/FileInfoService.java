package tobe.project.service;

import java.util.List;
import java.util.Map;

public interface FileInfoService {

	public List<Map<String, Object>> selectAllFile(String str, int idx) throws Exception;
	public Map<String, Object> selectOneFile(Map<String, Object> map) throws Exception;
}
