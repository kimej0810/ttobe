package tobe.project.service;

import java.util.List;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.MemberVO;
import tobe.project.dto.ScheduleVO;

public interface ScheduleService {
	
	//--------------------Ķ������! -------------------------

	public List<ScheduleVO> showSchedule() throws Exception;				//���� ������ȸ
	
	public void addSchedule(ScheduleVO vo) throws Exception;				//���� ���
	
	public ScheduleVO contentsSchedule(int sidx) throws Exception;			//���� ��
	public MemberVO contentmemberSchedule(int tidx) throws Exception;
	
	public void updateSchedule(ScheduleVO vo) throws Exception;				//���� ����
	
	public void deleteSchedule(int sidx) throws Exception;					//���� ����
	
	//----------------------- �Խñ���!! ------------------------
	
	public List<ScheduleVO> selectSchedule(SearchCriteria scri) throws Exception;	//�Խñ� ��� ��ȸ
	
	public int countSchedule(SearchCriteria scri) throws Exception;							//�Խñ� �� ����
	
}
