package tobe.project.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import tobe.project.dto.CommuteVO;
import tobe.project.dto.LeaveVO;
import tobe.project.dto.MemberVO;
import tobe.project.service.CommuteService;
import tobe.project.service.MemberService;

@Controller
public class CommuteController {
	
	private static final Logger logger = LoggerFactory.getLogger(CommuteController.class);
	
	@Inject
	private CommuteService service;
	@Inject
	private MemberService mService;
	
	//목록테스트
	@RequestMapping(value="/commute/commute")
	//@ResponseBody
	public String commuteList(CommuteVO vo, Model model,String t_id) throws Exception{
		logger.info(">>>>>commuteList");
		
		System.out.println("---------------------------");
		System.out.println("t_id------->"+t_id);
		System.out.println("---------------------------");
		
		SimpleDateFormat format1 = new SimpleDateFormat("yy/MM");
		Date time = new Date();
		String time1 = format1.format(time);
		System.out.println(time1);
		
		MemberVO mvo = mService.selectOneMember(t_id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tidx", mvo.getTidx());
		map.put("month", time1);
		List<CommuteVO> list = service.selectAllCommute2(map);
		model.addAttribute("member",mvo);
		model.addAttribute("list",list);
		
		return "/commute/commute";
	}

	//목록테스트
	@RequestMapping(value="/commute/commute2")
	@ResponseBody
	public Object commuteList2(@RequestParam Map<String, String> param, CommuteVO vo, Model model,String t_id) throws Exception{
		logger.info(">>>>>commuteList");
		
		String str = param.get("str");
		System.out.println("---------------------------");
		System.out.println("str------->"+str);
		System.out.println("t_id------->"+t_id);
		System.out.println("---------------------------");
		
		
		MemberVO mvo = mService.selectOneMember(t_id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tidx", mvo.getTidx());
		map.put("month", str);
		List<CommuteVO> list = service.selectAllCommute2(map);
		System.out.println(list.size());
		return list;
	}
	//근태관리 출근 등록 처리
	/*
	 * @RequestMapping(value="/commute/startCommute")
	 * 
	 * @ResponseBody public int startCommute(MemberVO vo) throws Exception{
	 * logger.info(">>>>>startCommute"); CommuteVO cvo; SimpleDateFormat format1 =
	 * new SimpleDateFormat("yy/MM/dd"); SimpleDateFormat format2 = new
	 * SimpleDateFormat("HH:mm"); Date time = new Date(); String time1 =
	 * format1.format(time); return 1; }
	 */
	
	@RequestMapping(value="/commute/startCommute")
	@ResponseBody public List<CommuteVO> startCommute(CommuteVO vo) throws Exception{
		logger.info(">>>>>startCommute");
		SimpleDateFormat format1 = new SimpleDateFormat("yy/MM/dd");
		SimpleDateFormat format2 = new SimpleDateFormat("HH:mm");
		Date time = new Date();
		String time1 = format1.format(time);
		service.addStartWork(vo);
		List<CommuteVO> list = service.selectAllCommute(vo.getTidx());
		return list;
	}
	//근태관리 퇴근 등록 처리
	@RequestMapping(value="/commute/endCommute")
	@ResponseBody
	public List<CommuteVO> endCommute(CommuteVO vo) throws Exception{
		logger.info(">>>>>endCommute");
		service.addEndWork(vo);
		List<CommuteVO> list = service.selectAllCommute(vo.getTidx());
		return list;
	}
	
	//연차관리 페이지
	@RequestMapping(value="/leave/leaveManagement")
	public String leaveManagementList(LeaveVO vo, Model model) throws Exception{
		logger.info(">>>>leaveManagementList");
		
		List<LeaveVO> list = service.selectAllLeave(vo.getTidx());
		model.addAttribute("list",list);
		
		System.out.println(">>>>>>>>>>"+list.get(0).getA_enddate());
		System.out.println(">>>>>>>>>>"+list.get(0).getMemberVO().getT_department());
		return "/leave/leaveManagement";
	}

	
}
