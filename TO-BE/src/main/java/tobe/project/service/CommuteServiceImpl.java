package tobe.project.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import tobe.project.dao.CommuteDAO;
import tobe.project.dto.CommuteVO;

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
	
	//근태목록 조회
	@Override
	public List<CommuteVO> selectAllCommute(int tidx) throws Exception {
		return dao.selectAllCommute(tidx);
	}
	
}
