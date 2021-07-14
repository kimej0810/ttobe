package tobe.project.dao;

import java.util.List;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.BoardVO;
import tobe.project.dto.EmailDTO;
import tobe.project.dto.LeaveDTO;
import tobe.project.dto.ScheduleVO;

public interface MyDAO {
	public int totalCountEmail(SearchCriteria searchCriteria)throws Exception;
	public List<EmailDTO> selectAllEmail(SearchCriteria searchCriteria)throws Exception;
	public int totalCountBoard(SearchCriteria searchCriteria)throws Exception;
	public List<BoardVO> selectAllBoard(SearchCriteria searchCriteria)throws Exception;
	public int totalCountLeave(SearchCriteria searchCriteria)throws Exception;
	public List<LeaveDTO> selectAllLeave(SearchCriteria searchCriteria)throws Exception;
	public int totalCountSchedule(SearchCriteria searchCriteria)throws Exception;
	public List<ScheduleVO> selectAllSchedule(SearchCriteria searchCriteria)throws Exception;
	public int writeApproval(LeaveDTO dto)throws Exception;
	public int writeLeave(LeaveDTO dto)throws Exception;
	public int writeLine(LeaveDTO dto)throws Exception;
	public int updateLeave(LeaveDTO dto)throws Exception;
	public LeaveDTO selectOneLeave(int eidx) throws Exception;
}
