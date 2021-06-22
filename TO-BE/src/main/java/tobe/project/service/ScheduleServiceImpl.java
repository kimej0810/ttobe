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
	
	//--------------------Ķ������! -------------------------
	
	//���� ��ü ��ȸ
	@Override
	public List<ScheduleVO> showSchedule() throws Exception{
		return dao.showSchedule();
	}
	
	//���� ���
	@Override
	public void addSchedule(ScheduleVO vo) throws Exception{
		dao.addSchedule(vo);
	}
	
	//���� ��
	@Override
	public ScheduleVO contentsSchedule(int sidx) throws Exception{
		return dao.ContentsSchedule(sidx);
	}
	@Override
	public MemberVO contentmemberSchedule(int tidx) throws Exception {
		return dao.contentmemberSchedule(tidx);
	}
	
	//���� ����
	@Override 
	public void updateSchedule(ScheduleVO vo) throws Exception{
		dao.updateSchedule(vo);
	}
	
	//���� ����
	@Override
	public void deleteSchedule(int sidx) throws Exception{
		dao.deleteSchedule(sidx);
	}
	
	//----------------------- �Խñ���!! ------------------------
	
	//�Խñ� ��� ��ȸ
	@Override
	public List<ScheduleVO> selectSchedule(SearchCriteria scri) throws Exception {
		return dao.selectSchedule(scri);
	}
	
	//���ñ� �� ����
	@Override
	public int countSchedule(SearchCriteria scri) throws Exception {
		return dao.countSchedule(scri);
	}


	
}
