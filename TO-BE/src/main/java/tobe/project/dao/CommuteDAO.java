package tobe.project.dao;

import java.util.List;
import java.util.Map;

import tobe.project.dto.CommuteVO;

public interface CommuteDAO {
	
	public void addStartWork(CommuteVO vo) throws Exception;
	
	public void addEndWork(CommuteVO vo) throws Exception;
	
	public String selectStartWork(int tidx) throws Exception;
	
	public String selectEndWork(int tidx) throws Exception;
	
	public List<CommuteVO> selectAllCommute2(Map<String, Object> map) throws Exception;
	
}
