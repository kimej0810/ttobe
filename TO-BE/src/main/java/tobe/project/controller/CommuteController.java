<<<<<<< HEAD
package tobe.project.controller;

import java.util.List;
import java.util.Locale;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import tobe.project.dto.CommuteVO;
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
	
	//근태관리 페이지
	@RequestMapping(value="/commute/commute", method=RequestMethod.GET)
	public String commuteGET(CommuteVO vo, Model model,String t_id) throws Exception{
		logger.info(">>>>>commuteGET");
		MemberVO mvo = mService.selectOneMember(t_id);
		model.addAttribute("member",mvo);
		return "/commute/commute";
				
	}
	
	//근태관리 출근 등록 처리
	/*
	@RequestMapping(value="/commute/commuteAction")
	public String commute2(CommuteVO vo) throws Exception{
		logger.info(">>>>>commuteAction");
		
		service.addStartWork(vo);
		
		return "/commute/commute";
	}
	*/
	///*
	@RequestMapping(value="/commute/startCommute")
	public List<CommuteVO> startCommute(CommuteVO vo) throws Exception{
		logger.info(">>>>>startCommute");
		
		service.addStartWork(vo);
		List<CommuteVO> list = service.selectAllCommute(vo.getTidx());
		return list;
		
	}
	//*/
	
	//근태관리 퇴근 등록 처리
	@RequestMapping(value="/commute/endCommute")
	public List<CommuteVO> endCommute(CommuteVO vo) throws Exception{
		logger.info(">>>>>endCommute");
		
		service.addEndWork(vo);
		List<CommuteVO> list = service.selectAllCommute(vo.getTidx());
		return list;
	}
	
	
	//연차일정 페이지
		@RequestMapping(value="/leaveCalendar")
		public String leaveCalendar(Locale locale, Model model) {
			logger.info("post leaveCalendar");
			
			return "leaveCalendar";
	}
	
	//연차관리 페이지
	@RequestMapping(value="/leaveManagement")
	public String leaveManagement(Locale locale, Model model) {
		logger.info("post leaveManagement");
		
		return "leaveManagement";
	}	
	
}
=======
package tobe.project.controller;

import java.util.List;
import java.util.Locale;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import tobe.project.dto.CommuteVO;
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
	
	//근태관리 페이지
	@RequestMapping(value="/commute/commute", method=RequestMethod.GET)
	public String commuteGET(CommuteVO vo, Model model,String t_id) throws Exception{
		logger.info(">>>>>commuteGET");
		MemberVO mvo = mService.selectOneMember(t_id);
		model.addAttribute("member",mvo);
		return "/commute/commute";
				
	}
	
	//근태관리 출근 등록 처리
	/*
	@RequestMapping(value="/commute/commuteAction")
	public String commute2(CommuteVO vo) throws Exception{
		logger.info(">>>>>commuteAction");
		
		service.addStartWork(vo);
		
		return "/commute/commute";
	}
	*/
	///*
	@RequestMapping(value="/commute/startCommute")
	public List<CommuteVO> startCommute(CommuteVO vo) throws Exception{
		logger.info(">>>>>startCommute");
		
		service.addStartWork(vo);
		List<CommuteVO> list = service.selectAllCommute(vo.getTidx());
		return list;
		
	}
	//*/
	
	//근태관리 퇴근 등록 처리
	@RequestMapping(value="/commute/endCommute")
	public List<CommuteVO> endCommute(CommuteVO vo) throws Exception{
		logger.info(">>>>>endCommute");
		
		service.addEndWork(vo);
		List<CommuteVO> list = service.selectAllCommute(vo.getTidx());
		return list;
	}
	
	
	//연차일정 페이지
		@RequestMapping(value="/leaveCalendar")
		public String leaveCalendar(Locale locale, Model model) {
			logger.info("post leaveCalendar");
			
			return "leaveCalendar";
	}
	
	//연차관리 페이지
	@RequestMapping(value="/leaveManagement")
	public String leaveManagement(Locale locale, Model model) {
		logger.info("post leaveManagement");
		
		return "leaveManagement";
	}	
	
}
>>>>>>> branch 'master' of https://github.com/kimej0810/ttobe.git
