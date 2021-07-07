package tobe.project.dao;

import java.util.List;
import java.util.Map;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.DataLibraryVO;

public interface DataLibraryDAO {
	//��猷��� 紐⑸�
	public List<DataLibraryVO> selectAllData(SearchCriteria scri) throws Exception;
	//��猷��� ���댁�
	public int dataCount(SearchCriteria scri) throws Exception;
	//��猷��� ��濡���
	public void addData(DataLibraryVO vo) throws Exception;
	//��猷��� ��濡���(fileInfo)
	public void insertFile(Map<String, Object> map) throws Exception;
	//��猷��� �ㅼ�대����� ��
	public void hitData(int didx) throws Exception;
	//데이터 삭제
	public void deleteData(int didx) throws Exception;
}
