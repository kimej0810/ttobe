package tobe.project.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import tobe.project.dao.MyDAO;
import tobe.project.domain.SearchCriteria;
import tobe.project.dto.BoardVO;
import tobe.project.dto.EmailDTO;
import tobe.project.dto.LeaveDTO;
import tobe.project.dto.ScheduleVO;

@Repository
public class MyServiceImpl implements MyService{
	
	@Inject
	private MyDAO dao;
	@Override
	public int totalCountEmail(SearchCriteria searchCriteria) throws Exception {
		return dao.totalCountEmail(searchCriteria);
	}
	@Override
	public List<EmailDTO> selectAllEmail(SearchCriteria searchCriteria)throws Exception{
		return dao.selectAllEmail(searchCriteria);
	}
	@Override
	public int totalCountBoard(SearchCriteria searchCriteria) throws Exception {
		return dao.totalCountBoard(searchCriteria);
	}
	@Override
	public List<BoardVO> selectAllBoard(SearchCriteria searchCriteria) throws Exception {
		return dao.selectAllBoard(searchCriteria);
	}
	@Override
	public int totalCountLeave(SearchCriteria searchCriteria) throws Exception {
		return dao.totalCountLeave(searchCriteria);
	}
	@Override
	public List<LeaveDTO> selectAllLeave(SearchCriteria searchCriteria) throws Exception {
		return dao.selectAllLeave(searchCriteria);
	}
	@Override
	public int totalCountSchedule(SearchCriteria searchCriteria) throws Exception {
		return dao.totalCountSchedule(searchCriteria);
	}
	@Override
	public List<ScheduleVO> selectAllSchedule(SearchCriteria searchCriteria) throws Exception {
		return dao.selectAllSchedule(searchCriteria);
	}
	@Override
	public int writeLeave(LeaveDTO dto) throws Exception {
		int result1 = dao.writeApproval(dto);
		int result2 = dao.writeLeave(dto);
		int result3 = dao.writeLine(dto);
		if(result1 == 1 && result2 == 1 && result3 == 1) {
			return 1;
		}
		return 0;
	}
	@Override
	public int updateLeave(LeaveDTO dto) throws Exception {
		return dao.updateLeave(dto);
	}
	@Override
	public LeaveDTO selectOneLeave(int eidx) throws Exception {
		return dao.selectOneLeave(eidx);
	}

	
}
