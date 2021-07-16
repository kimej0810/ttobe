package tobe.project.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import tobe.project.dao.ScheduleDAO;
import tobe.project.domain.SearchCriteria;
import tobe.project.dto.MemberVO;
import tobe.project.dto.ScheduleVO;

@Repository
public class ScheduleServiceImpl implements ScheduleService{

	@Inject
	private ScheduleDAO dao;
	
	//--------------------캘占쏙옙占쏙옙占쏙옙! -------------------------
	
	//占쏙옙占쏙옙 占쏙옙체 占쏙옙회
	@Override
	public List<ScheduleVO> showSchedule() throws Exception{
		return dao.showSchedule();
	}
	 
	//占쏙옙占쏙옙 占쏙옙占�
	@Override
	public void addSchedule(ScheduleVO vo) throws Exception{
		dao.addSchedule(vo);
	} 
	
	//占쏙옙占쏙옙 占쏙옙
	@Override
	public ScheduleVO contentsSchedule(int sidx) throws Exception{
		return dao.ContentsSchedule(sidx);
	}
	@Override
	public MemberVO contentmemberSchedule(int tidx) throws Exception {
		return dao.contentmemberSchedule(tidx);
	}
	
	//占쏙옙占쏙옙 占쏙옙占쏙옙
	@Override 
	public void updateSchedule(ScheduleVO vo) throws Exception{
		dao.updateSchedule(vo);
	}
	
	//占쏙옙占쏙옙 占쏙옙占쏙옙
	@Override
	public void deleteSchedule(int sidx) throws Exception{
		dao.deleteSchedule(sidx);
	}
	
	//----------------------- 占쌉시깍옙占쏙옙!! ------------------------
	
	//占쌉시깍옙 占쏙옙占� 占쏙옙회
	@Override
	public List<ScheduleVO> selectSchedule(SearchCriteria scri) throws Exception {
		return dao.selectSchedule(scri);
	}
	
	//占쏙옙占시깍옙 占쏙옙 占쏙옙占쏙옙
	@Override
	public int countSchedule(SearchCriteria scri) throws Exception {
		return dao.countSchedule(scri);
	}


	
}
