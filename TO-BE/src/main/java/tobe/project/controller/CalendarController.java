package tobe.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import tobe.project.domain.PageMaker;
import tobe.project.domain.SearchCriteria;
import tobe.project.dto.MemberVO;
import tobe.project.dto.ScheduleVO;
import tobe.project.service.ScheduleService;

@Controller
@RequestMapping(value = "/schedule")
public class CalendarController {
	private static final Logger logger = LoggerFactory.getLogger(CalendarController.class);
	@Inject
	private ScheduleService service;
 
	//筌��꼶�뵛占쎈쐭
	@RequestMapping(value = "/fullcalendar")
	public String list(Model model, @ModelAttribute("scri")SearchCriteria scri) throws Exception {
		logger.info("fullcalendar");
		 //野껊슣�뻻占쎈솇 占쎈읂占쎌뵠筌욌벡荑귞뵳占� start
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.countSchedule(scri));
		 
		model.addAttribute("viewAll",service.selectSchedule(scri));	
		model.addAttribute("paging",pageMaker);
		//野껊슣�뻻占쎈솇占쎈읂占쎌뵠筌욌벡荑귞뵳占� end
		List<ScheduleVO> schedule = service.showSchedule();
		model.addAttribute("scri",scri);
		model.addAttribute("schedule",schedule);
		return "/schedule/fullcalendar";
	}
	
	// 占쎌뵬占쎌젟�빊遺쏙옙 占쎈솚占쎈씜
	@RequestMapping(value = "/schedulePopup")
	public String schedulePopup() throws Exception {
		return "/schedule/schedulePopup";
	}
	//占쎌뵬占쎌젟 �빊遺쏙옙 ajax 占쎌깈�빊占�
	@ResponseBody
	@RequestMapping(value = "/addSchedule", method = RequestMethod.POST) 
	public Map<Object,Object> addSchedule(@RequestBody ScheduleVO vo) throws Exception{
		 Map<Object,Object> map = new HashMap<Object,Object>();
		 service.addSchedule(vo); 
		 return map; 
	}
	 
	//占쎌뵬占쎌젟 占쎌읈筌ｏ옙 
	@ResponseBody
	@RequestMapping(value = "/showSchedule")
	public List<ScheduleVO> show() throws Exception {
		List<ScheduleVO> list = service.showSchedule();
		return list;
	}
	
	//占쎌뵬占쎌젟 占쎄맒占쎄쉭
	@RequestMapping(value = "/scheduleContents")
	public ScheduleVO Contents(Model model, int sidx, int tidx) throws Exception {
		System.out.println(sidx);
		System.out.println(tidx);
		ScheduleVO vo = service.contentsSchedule(sidx);
		MemberVO mo = service.contentmemberSchedule(tidx);
		System.out.println(vo);
		model.addAttribute("vo",vo);
		model.addAttribute("mo",mo);
		
		return vo;
	}
	
	//占쎌뵬占쎌젟 占쎈땾占쎌젟
	@RequestMapping(value = "/scheduleModify")
	public ScheduleVO modifyPopup(Model model,int sidx, int tidx) throws Exception{
		ScheduleVO vo = service.contentsSchedule(sidx);
		MemberVO mo = service.contentmemberSchedule(tidx);
		model.addAttribute("vo",vo);
		model.addAttribute("mo",mo);
		return vo;
	}
	
	//占쎌뵬占쎌젟 占쎈땾占쎌젟 ajax 占쎌깈�빊占�
	@ResponseBody
	@RequestMapping(value = "/updateSchedule") 
	public Map<Object,Object> updateSchedule(@RequestBody ScheduleVO vo) throws Exception{ 
		Map<Object,Object> map = new HashMap<Object,Object>();
		service.updateSchedule(vo); 
		return map;
	 }
	
	//占쎌뵬占쎌젟 占쎄텣占쎌젫
	@RequestMapping(value = "/scheduleDelete")
	public String deleteSchedule(int sidx) throws Exception{ 
		service.deleteSchedule(sidx);
		return "redirect:/scheduleContents";
	 }
	
}
