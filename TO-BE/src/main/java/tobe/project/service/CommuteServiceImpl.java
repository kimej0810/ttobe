package tobe.project.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import tobe.project.dao.CommuteDAO;
import tobe.project.dto.CommuteVO;
import tobe.project.dto.LeaveVO;

@Service
public class CommuteServiceImpl implements CommuteService{
	
	@Inject
	private CommuteDAO dao;
	
	//출근시간 등록
	@Override
	public void addStartWork(CommuteVO vo) throws Exception {
		dao.addStartWork(vo);
	}
	
	//퇴근시간 등록
	@Override
	public void addEndWork(CommuteVO vo) throws Exception {
		dao.addEndWork(vo);
	}
	
	
	@Override
	public List<CommuteVO> selectAllCommute(int tidx) throws Exception {
		return dao.selectAllCommute(tidx);
	}
	
	//근태목록 조회테스트
	@Override
	public List<CommuteVO> selectAllCommute2(Map<String, Object> map) throws Exception {
		return dao.selectAllCommute2(map);
	}

	//연차 목록
	@Override
	public List<LeaveVO> selectAllLeave(int tidx) throws Exception {
		return dao.selectAllLeave(tidx);
	}
	
	//연차 등록
	@Override
	public void addLeave() throws Exception {
		
		
	}
	//
	@Override
	public void addStartWork2(CommuteVO vo) throws Exception{
		dao.addStartWork2(vo);
		
	}
	
	
}
