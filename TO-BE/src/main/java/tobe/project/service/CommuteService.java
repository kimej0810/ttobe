package tobe.project.service;

import java.util.List;
import java.util.Map;

import tobe.project.dto.CommuteVO;

public interface CommuteService {
	
	public boolean addStartWork(int tidx) throws Exception;
	
	public boolean addEndWork(int tidx) throws Exception;
	
	public String selectStartWork(int tidx) throws Exception;
	
	public String selectEndWork(int tidx) throws Exception;
	
	public List<CommuteVO> selectAllCommute2(Map<String, Object> map) throws Exception;
	
}
