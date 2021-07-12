package tobe.project.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import tobe.project.dao.CommuteDAO;
import tobe.project.dto.CommuteVO;
import tobe.project.dto.LeaveVO;

@Service
public class CommuteServiceImpl implements CommuteService{
	
	@Inject
	private CommuteDAO dao;
	

	//출근시간 등록 메인용
	@Override
	public boolean addStartWork(int tidx) throws Exception {
		
		//현재날짜
		Date today = new Date();
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy/MM/dd");
		String date = format1.format(today);
		System.out.println(">>>>>startCommute2>>>>date>>>>>"+date);
		//출근시작시간
		SimpleDateFormat format2 = new SimpleDateFormat("HH:mm");
		String startTime = format2.format(today);
		System.out.println(">>>>>startCommute2>>>>startTime>>>>>"+startTime);
		//요일
		Calendar cal = Calendar.getInstance();
		String[] weekArr = {"주말", "정상", "정상", "정상", "정상", "정상", "주말"};
		String type = weekArr[cal.get(Calendar.DAY_OF_WEEK)];
		System.out.println(">>>>>startCommute2>>>>type>>>>>"+type);
		
		CommuteVO vo = new CommuteVO();
		
		vo.setC_date(date);
		vo.setC_starttime(startTime);
		vo.setC_type(type);
		vo.setTidx(tidx);
		
		if(dao.selectStartWork(tidx) == null || dao.selectStartWork(tidx).equals("")) {
			dao.addStartWork(vo);
			
			return false;
		}
		else {
			return true;
		}
		
	}
	
	//퇴근시간 등록 메인용
	@Override
	public boolean addEndWork(int tidx) throws Exception {
		
		//현재날짜
		Date today = new Date();
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy/MM/dd");
		String date = format1.format(today);
		System.out.println(">>>>>endCommute2>>>>date>>>>>"+date);
		//퇴근시간
		SimpleDateFormat format2 = new SimpleDateFormat("HH:mm");
		String endTime = format2.format(today);
		System.out.println(">>>>>endCommute2>>>>startTime>>>>>"+endTime);
		//근무시간
		
		
		CommuteVO vo = new CommuteVO();
		
		vo.setC_endtime(endTime);
		vo.setTidx(tidx);
		
		if(dao.selectEndWork(tidx).equals("0")) {
			
			String start = dao.selectStartWork(tidx);
			System.out.println("시간"+start);
			
			int stime1 = Integer.parseInt(start.split(":")[0]);
			int stime2 = Integer.parseInt(start.split(":")[1]);
			int stimeresult = (stime1*60)+stime2;
			System.out.println("출근시간 분으로"+stimeresult);
			
			Calendar cal = Calendar.getInstance();
			int hour = cal.get(Calendar.HOUR_OF_DAY);
			int min = cal.get(Calendar.MINUTE);
			System.out.println("시간"+hour);
			int etimeresult = (hour*60)+min;
			System.out.println("퇴근시간 분으로"+etimeresult);
			
			String result = (etimeresult - stimeresult)+"";
			vo.setC_worktime(result);
			
			dao.addEndWork(vo);
			
			return false;
		}
		else {
			return true;
		}
		
	}
	
	@Override
	public List<CommuteVO> selectAllCommute(int tidx) throws Exception {
		return dao.selectAllCommute(tidx);
	}
	
	//근태목록 조회테스트
	@Override
	public List<CommuteVO> selectAllCommute2(Map<String, Object> map) throws Exception {
		return dao.selectAllCommute2(map);
	}

	//출근기록조회
	@Override
	public String selectStartWork(int tidx) throws Exception {
		return dao.selectStartWork(tidx);
	}
	
	//퇴근기록조회
	@Override
	public String selectEndWork(int tidx) throws Exception {
		return dao.selectEndWork(tidx);
	}
	
}
