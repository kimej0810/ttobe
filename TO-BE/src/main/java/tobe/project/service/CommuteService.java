package tobe.project.service;

import java.util.List;

import tobe.project.dto.CommuteVO;

public interface CommuteService {
	
	//출근시간 등록
	public void addStartWork(CommuteVO vo) throws Exception;
	
	//퇴근시간 등록
	public void addEndWork(CommuteVO vo) throws Exception;
	
	//근태목록 조회
	public List<CommuteVO> selectAllCommute(int tidx) throws Exception;
}
