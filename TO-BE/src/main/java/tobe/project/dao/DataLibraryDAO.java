package tobe.project.dao;

import java.util.List;
import java.util.Map;

import tobe.project.dto.DataLibraryVO;

public interface DataLibraryDAO {
	//자료실 목록
	public List<DataLibraryVO> selectAllData() throws Exception;
	//자료실 업로드
	public void addData(DataLibraryVO vo) throws Exception;
	//자료실 업로드(fileInfo)
	public void insertFile(Map<String, Object> map) throws Exception;
}
