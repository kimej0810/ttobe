package tobe.project.dao;

import java.util.List;
import java.util.Map;

import tobe.project.dto.CommuteVO;

public interface CommuteDAO {
	
	//출근 등록
	public void addStartWork(CommuteVO vo) throws Exception;
	//퇴근 등록
	public void addEndWork(CommuteVO vo) throws Exception;
	//출근 기록 조회
	public String selectStartWork(int tidx) throws Exception;
	//퇴근 기록 조회
	public String selectEndWork(int tidx) throws Exception;
	//근태 목록
	public List<CommuteVO> selectAllCommute2(Map<String, Object> map) throws Exception;
	
}
