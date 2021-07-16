package tobe.project.service;

import java.util.List;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.MemberVO;
import tobe.project.dto.ScheduleVO;

public interface ScheduleService {
	
	//--------------------캘占쏙옙占쏙옙占쏙옙! -------------------------

	public List<ScheduleVO> showSchedule() throws Exception;				//占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙회
	
	public void addSchedule(ScheduleVO vo) throws Exception;				//占쏙옙占쏙옙 占쏙옙占�
	
	public ScheduleVO contentsSchedule(int sidx) throws Exception;			//占쏙옙占쏙옙 占쏙옙
	public MemberVO contentmemberSchedule(int tidx) throws Exception;
	
	public void updateSchedule(ScheduleVO vo) throws Exception;				//占쏙옙占쏙옙 占쏙옙占쏙옙
	
	public void deleteSchedule(int sidx) throws Exception;					//占쏙옙占쏙옙 占쏙옙占쏙옙
	 
	//----------------------- 占쌉시깍옙占쏙옙!! ------------------------
	
	public List<ScheduleVO> selectSchedule(SearchCriteria scri) throws Exception;	//占쌉시깍옙 占쏙옙占� 占쏙옙회
	
	public int countSchedule(SearchCriteria scri) throws Exception;							//占쌉시깍옙 占쏙옙 占쏙옙占쏙옙
	
}
 