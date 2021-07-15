package tobe.project.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.BoardVO;
import tobe.project.dto.EmailDTO;
import tobe.project.dto.LeaveDTO;
import tobe.project.dto.ScheduleVO;

@Repository
public class MyDAOImpl implements MyDAO{
	@Inject
	private SqlSession sqlSession;
	private static final String Namespace = "tobe.project.mapper.myMapper";
	
	@Override
	public int totalCountEmail(SearchCriteria searchCriteria) throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountEmail",searchCriteria);
	}
	@Override
	public List<EmailDTO> selectAllEmail(SearchCriteria searchCriteria) throws Exception {
		return sqlSession.selectList(Namespace+".searchEmailList",searchCriteria);
	}
	@Override
	public int totalCountBoard(SearchCriteria searchCriteria) throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountBoard",searchCriteria);
	}
	@Override
	public List<BoardVO> selectAllBoard(SearchCriteria searchCriteria) throws Exception {
		return sqlSession.selectList(Namespace+".selectAllBoard",searchCriteria);
	}
	@Override
	public int totalCountLeave(SearchCriteria searchCriteria) throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountLeave",searchCriteria);
	}
	@Override
	public List<LeaveDTO> selectAllLeave(SearchCriteria searchCriteria) throws Exception {
		return sqlSession.selectList(Namespace+".selectAllLeave",searchCriteria);
	}
	@Override
	public int totalCountSchedule(SearchCriteria searchCriteria) throws Exception {
		return sqlSession.selectOne(Namespace+".totalCountSchedule",searchCriteria);
	}
	@Override
	public List<ScheduleVO> selectAllSchedule(SearchCriteria searchCriteria) throws Exception {
		return sqlSession.selectList(Namespace+".selectAllSchedule",searchCriteria);
	}
	@Override
	public int writeApproval(LeaveDTO dto) throws Exception {
		return sqlSession.insert(Namespace+".writeApproval",dto);
	}
	@Override
	public int writeLeave(LeaveDTO dto) throws Exception {
		return sqlSession.insert(Namespace+".writeLeave",dto);
	}
	@Override
	public int writeLine(LeaveDTO dto) throws Exception {
		return sqlSession.insert(Namespace+".writeLine",dto);
	}
	@Override
	public int updateLeave(LeaveDTO dto) throws Exception {
		return sqlSession.update(Namespace+".updateLeave",dto);
	}
	@Override
	public LeaveDTO selectOneLeave(int eidx) throws Exception {
		return sqlSession.selectOne(Namespace+".selectOneLeave",eidx);
	}
	@Override
	public int leaveDelete(int eidx) throws Exception {
		return sqlSession.update(Namespace+".leaveDelete",eidx);
	}
	@Override
	public int modifyLeave(LeaveDTO dto) throws Exception {
		return sqlSession.update(Namespace+".modifyLeave",dto);
	}
	@Override
	public int modifyLine(LeaveDTO dto) throws Exception {
		return sqlSession.update(Namespace+".modifyLine",dto);
	}
	@Override
	public int modifyApproval(LeaveDTO dto) throws Exception {
		return sqlSession.update(Namespace+".modifyApproval",dto);
	}
	
}
