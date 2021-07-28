package tobe.project.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import tobe.project.dto.CommuteVO;

public interface CommuteService {
	
	//출근 등록
	public boolean addStartWork(int tidx) throws Exception;
	//퇴근 등록
	public boolean addEndWork(int tidx, HttpServletResponse response) throws Exception;
	//출근 기록 조회
	public String selectStartWork(int tidx) throws Exception;
	//퇴근 기록 조회
	public String selectEndWork(int tidx) throws Exception;
	//근태 목록
	public List<CommuteVO> selectAllCommute2(Map<String, Object> map) throws Exception;
	
}
