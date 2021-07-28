package tobe.project.service;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import tobe.project.dao.CommuteDAO;
import tobe.project.dto.CommuteVO;

@Service
public class CommuteServiceImpl implements CommuteService{
	
	@Inject
	private CommuteDAO dao;
	//출근 등록
	@Override
	public boolean addStartWork(int tidx) throws Exception {
		
		Date today = new Date();
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy/MM/dd");
		String date = format1.format(today);
		
		SimpleDateFormat format2 = new SimpleDateFormat("HH:mm");
		String startTime = format2.format(today);
		
		Calendar cal = Calendar.getInstance();
		String[] weekArr = {"", "주말", "정상", "정상", "정상", "정상", "정상", "주말"};
		String type = weekArr[cal.get(Calendar.DAY_OF_WEEK)];
		
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
	//퇴근등록
	@Override
	public boolean addEndWork(int tidx, HttpServletResponse response) throws Exception {
		try {
		Date today = new Date();
		
		SimpleDateFormat format2 = new SimpleDateFormat("HH:mm");
		String endTime = format2.format(today);

		CommuteVO vo = new CommuteVO();
		vo.setC_endtime(endTime);
		vo.setTidx(tidx);
		
		if(dao.selectEndWork(tidx).equals("0")) {
			
			String start = dao.selectStartWork(tidx);
			
			int stime1 = Integer.parseInt(start.split(":")[0]);
			int stime2 = Integer.parseInt(start.split(":")[1]);
			int stimeresult = (stime1*60)+stime2;
			
			Calendar cal = Calendar.getInstance();
			int hour = cal.get(Calendar.HOUR_OF_DAY);
			int min = cal.get(Calendar.MINUTE);
			int etimeresult = (hour*60)+min;
			String result = (etimeresult - stimeresult)+"";
			vo.setC_worktime(result);
			
			dao.addEndWork(vo);
			
			return false;
		}
		else {
			return true;
		}
		}catch(Exception e) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('출근 기록이 없습니다.');history.back();</script>");
			out.close();
		}
		return false;
	}
	//출근 기록 조회
	@Override
	public String selectStartWork(int tidx) throws Exception {
		return dao.selectStartWork(tidx);
	}
	//퇴근 기록 조회
	@Override
	public String selectEndWork(int tidx) throws Exception {
		return dao.selectEndWork(tidx);
	}
	//근태 목록
	@Override
	public List<CommuteVO> selectAllCommute2(Map<String, Object> map) throws Exception {
		return dao.selectAllCommute2(map);
	}

}
