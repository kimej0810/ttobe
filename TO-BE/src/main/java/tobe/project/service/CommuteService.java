package tobe.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import tobe.project.dto.CommuteVO;
import tobe.project.dto.LeaveVO;

public interface CommuteService {
	
	//출근시간 등록
	public boolean addStartWork(int tidx) throws Exception;
	
	//퇴근시간 등록
	public boolean addEndWork(int tidx) throws Exception;
	
	//근태목록 조회
	public List<CommuteVO> selectAllCommute(int tidx) throws Exception;
	
	//근태목록 조회 테스트
	public List<CommuteVO> selectAllCommute2(Map<String, Object> map) throws Exception;
	
	//출근기록조회
	public String selectStartWork(int tidx) throws Exception;
	//퇴근기록조회
	public String selectEndWork(int tidx) throws Exception;
}
