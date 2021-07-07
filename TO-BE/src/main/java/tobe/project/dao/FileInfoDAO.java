package tobe.project.dao;

import java.util.List;
import java.util.Map;

public interface FileInfoDAO {
	//���� 議고��
	public List<Map<String, Object>> selectAllFile(String str, int idx) throws Exception;
	//���� �ㅼ�대���
	public Map<String, Object> selectOneFile(Map<String, Object> map) throws Exception;
	//���� ����
	public void deleteFileDidx(int didx) throws Exception;
	public Map<String, String> selectFileTidx(int tidx) throws Exception;
	
}
