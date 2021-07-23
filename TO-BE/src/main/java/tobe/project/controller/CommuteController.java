package tobe.project.controller;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
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

	//출근 등록
	@RequestMapping(value = "/commute/startCommute")
	public String startCommute2(@RequestParam Map<String, String> param, HttpServletResponse response, HttpServletRequest request) throws Exception {
		logger.info("startCommute...");
		
		int tidx = Integer.parseInt(param.get("tidx"));
		System.out.println(tidx);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		boolean test = service.addStartWork(tidx);
		if(test) {
			out.println("<script>alert('이미 출근 처리되었습니다.');</script>");
			out.println("<script>window.location.href='"+request.getContextPath()+"/main/mainPage';</script>"); 
			out.close();
		}else {
			out.println("<script>alert('출근 처리되었습니다.');</script>");
			out.println("<script>window.location.href='"+request.getContextPath()+"/main/mainPage';</script>");
			out.close();
		}
		return "redirect:/main/mainPage";
	}
	
	//퇴근 등록
	@RequestMapping(value = "/commute/endCommute")
	public String endCommute(@RequestParam Map<String, String> param, HttpServletResponse response, HttpServletRequest request) throws Exception {
		logger.info("endCommute...");
		
		int tidx = Integer.parseInt(param.get("tidx"));
		System.out.println(tidx);
		
		response.setContentType("text/html; charset=utf-8"); 
		PrintWriter out = response.getWriter();
		
		boolean test = service.addEndWork(tidx); 
		if(test) {
			out.println("<script>alert('이미 퇴근 처리되었습니다.');</script>");
			out.println("<script>window.location.href='"+request.getContextPath()+"/main/mainPage';</script>");
			out.close();
		}else {
			out.println("<script>alert('퇴근 처리되었습니다.');</script>");
			out.println("<script>window.location.href='"+request.getContextPath()+"/main/mainPage';</script>");
			out.close();
		}
		return "redirect:/main/mainPage";
	}
	
	//근태관리 목록
	@RequestMapping(value = "/commute/commute")
	public String commuteList(Model model, String t_id) throws Exception {
		logger.info("commuteList...");

		System.out.println("t_id: " + t_id);

		SimpleDateFormat format1 = new SimpleDateFormat("yy-MM");
		Date date = new Date();
		String current = format1.format(date);
		System.out.println("current: " + current);

		MemberDTO mvo = mService.selectOneMember(t_id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tidx", mvo.getTidx());
		map.put("month", current);
		List<CommuteVO> list = service.selectAllCommute2(map);
		model.addAttribute("member", mvo);
		model.addAttribute("list", list);

		return "/commute/commute";
	}

	//월별 페이징
	@RequestMapping(value = "/commute/commute2")
	@ResponseBody
	public Object commuteList2(@RequestParam Map<String, String> param, Model model, String t_id) throws Exception {
		logger.info("commuteList2...");

		String str = param.get("str");
		System.out.println("str: " + str);
		System.out.println("t_id: " + t_id);

		MemberDTO mvo = mService.selectOneMember(t_id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tidx", mvo.getTidx());
		map.put("month", str);
		List<CommuteVO> list = service.selectAllCommute2(map);
		System.out.println("list.size: " + list.size());
		return list;
	}
}
