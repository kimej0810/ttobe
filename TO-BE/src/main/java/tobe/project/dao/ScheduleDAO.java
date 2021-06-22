package tobe.project.dao;

import java.util.List;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.MemberVO;
import tobe.project.dto.ScheduleVO;

public interface ScheduleDAO {
	
	//--------------------Ķ������! -------------------------
	public List<ScheduleVO> showSchedule() throws Exception; 			//���� ��ü ��ȸ
	
	public void addSchedule(ScheduleVO vo) throws Exception;			//���� ���
	
	public ScheduleVO ContentsSchedule(int sidx) throws Exception;		//���� ��	
	
	public void updateSchedule(ScheduleVO vo) throws Exception;			//���� ����
	
	public void deleteSchedule(int sidx) throws Exception;				//���� ����
	
	public MemberVO contentmemberSchedule(int tidx) throws Exception;
	//----------------------- �Խñ���!! ------------------------
	
	public List<ScheduleVO> selectSchedule(SearchCriteria scri) throws Exception;		//�Խñ� ��� ��ȸ
	
	public int countSchedule(SearchCriteria scri) throws Exception;								//�Խñ� �� ����
}
