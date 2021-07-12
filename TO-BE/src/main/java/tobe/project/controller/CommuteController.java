package tobe.project.controller;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import tobe.project.dto.CommuteVO;
import tobe.project.dto.MemberDTO;
import tobe.project.service.CommuteService;
import tobe.project.service.MemberService;

@Controller
public class CommuteController {

	private static final Logger logger = LoggerFactory.getLogger(CommuteController.class);

	@Inject
	private CommuteService service;
	@Inject
	private MemberService mService;

	// 목록테스트
	@RequestMapping(value = "/commute/commute")
	// @ResponseBody
	public String commuteList(CommuteVO vo, Model model, String t_id) throws Exception {
		logger.info(">>>>>commuteList");

		System.out.println("---------------------------");
		System.out.println("t_id------->" + t_id);
		System.out.println("---------------------------");

		SimpleDateFormat format1 = new SimpleDateFormat("yy/MM");
		Date time = new Date();
		String time1 = format1.format(time);
		System.out.println(time1);

		MemberDTO mvo = mService.selectOneMember(t_id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tidx", mvo.getTidx());
		map.put("month", time1);
		List<CommuteVO> list = service.selectAllCommute2(map);
		model.addAttribute("member", mvo);
		model.addAttribute("list", list);

		return "/commute/commute";
	}

	// 목록테스트
	@RequestMapping(value = "/commute/commute2")
	@ResponseBody
	public Object commuteList2(@RequestParam Map<String, String> param, CommuteVO vo, Model model, String t_id)
			throws Exception {
		logger.info(">>>>>commuteList");

		String str = param.get("str");
		System.out.println("---------------------------");
		System.out.println("str------->" + str);
		System.out.println("t_id------->" + t_id);
		System.out.println("---------------------------");

		MemberDTO mvo = mService.selectOneMember(t_id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tidx", mvo.getTidx());
		map.put("month", str);
		List<CommuteVO> list = service.selectAllCommute2(map);
		System.out.println(list.size());
		return list;
	}
	
	//메인 출근
	@RequestMapping(value = "/commute/startCommute")
	public String startCommute2(@RequestParam Map<String, String> param, HttpServletResponse response) throws Exception {
		logger.info("!!!!!!!!!!!!startCommute2!!!!!!!!!!");
		
		int tidx = Integer.parseInt(param.get("tidx"));
		System.out.println(tidx);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		boolean test = service.addStartWork(tidx);
		if(test) {
			out.println("<script>alert('이미 출근 처리되었습니다.');</script>");
			out.println("<script>window.location.href='/main/mainPage';</script>");
			out.close();
		}else {
			out.println("<script>alert('출근 처리되었습니다.');</script>");
			out.println("<script>window.location.href='/main/mainPage';</script>");
			out.close();
		}
		
		return "redirect:/main/mainPage";
		
	}
	
	//근태관리 퇴근 등록 처리 메인
	@RequestMapping(value = "/commute/endCommute")
	public String endCommute(@RequestParam Map<String, String> param, HttpServletResponse response) throws Exception {
		logger.info(">>>>>endCommute");
		
		int tidx = Integer.parseInt(param.get("tidx"));
		System.out.println(tidx);
		
		response.setContentType("text/html; charset=utf-8"); 
		PrintWriter out = response.getWriter();
		
		boolean test = service.addEndWork(tidx); 
		if(test) {
			out.println("<script>alert('이미 퇴근 처리되었습니다.');</script>");
			out.println("<script>window.location.href='/main/mainPage';</script>");
			out.close();
		}else {
			out.println("<script>alert('퇴근 처리되었습니다.');</script>");
			out.println("<script>window.location.href='/main/mainPage';</script>");
			out.close();
		}
		
		
		return "redirect:/main/mainPage";
	}
	
}
