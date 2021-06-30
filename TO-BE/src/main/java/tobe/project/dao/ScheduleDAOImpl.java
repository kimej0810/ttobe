package tobe.project.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.MemberVO;
import tobe.project.dto.ScheduleVO;

@Repository
public class ScheduleDAOImpl implements ScheduleDAO{
	
	@Inject
	private SqlSession sqlSession;
	private static final String Namespace = "tobe.project.mapper.scheduleMapper";		//���� ���
	
	//--------------------Ķ������! -------------------------
	
	//���� ��ü��ȸ
	@Override
	public List<ScheduleVO> showSchedule() throws Exception{
		return sqlSession.selectList(Namespace+".showSchedule");
	}
	
	//���� ���
	@Override
	public void addSchedule(ScheduleVO vo) throws Exception{
		sqlSession.insert(Namespace+".addSchedule",vo);
	}
	
	//���� ��
	@Override
	public ScheduleVO ContentsSchedule(int sidx) throws Exception {
		return sqlSession.selectOne(Namespace+".contentsSchedule",sidx);
		
	}
	@Override
	public MemberVO contentmemberSchedule(int tidx) throws Exception {
		return sqlSession.selectOne(Namespace+".contentmemberSchedule",tidx);
		
	}

	
	//���� ����
	@Override
	public void updateSchedule(ScheduleVO vo) throws Exception {
		sqlSession.update(Namespace+".updateSchedule",vo);
	}
	
	//���� ����
	@Override
	public void deleteSchedule(int sidx) throws Exception{
		sqlSession.delete(Namespace+".deleteSchedule",sidx);
	}

	
	//----------------------- �Խñ���!! ------------------------
	
	//�Խñ� ��� ��ȸ
	@Override
	public List<ScheduleVO> selectSchedule(SearchCriteria scri) throws Exception {
		return sqlSession.selectList(Namespace+".selectSchedule",scri);
	}
	
	//�Խñ� �� ����
	@Override
	public int countSchedule(SearchCriteria scri) throws Exception {
		return sqlSession.selectOne(Namespace+".countSchedule", scri);
	}

}
