package tobe.project.dao;

import java.util.List;
import java.util.Map;

import tobe.project.dto.CommuteVO;
import tobe.project.dto.LeaveVO;

public interface CommuteDAO {
	
	//출근시간 등록
	public void addStartWork(CommuteVO vo) throws Exception;
	
	//퇴근시간 등록
	public void addEndWork(CommuteVO vo) throws Exception;
	
	
	public List<CommuteVO> selectAllCommute(int tidx) throws Exception;
	
	//근태목록 조회테스트
	public List<CommuteVO> selectAllCommute2(Map<String, Object> map) throws Exception;
	
	
	//연차 목록
	public List<LeaveVO> selectAllLeave(int tidx) throws Exception;
	
	//연차 등록
	public void addLeave() throws Exception;
}
