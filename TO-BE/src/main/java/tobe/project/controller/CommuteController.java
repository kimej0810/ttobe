package tobe.project.controller;

import java.util.Locale;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import tobe.project.service.MemberService;

@Controller
public class CommuteController {
	
	private static final Logger logger = LoggerFactory.getLogger(CommuteController.class);
	
	@Inject
	MemberService service;
	
	//근태현황페이지
	@RequestMapping(value="/commute")
	public String commute(Locale locale, Model model) {
		logger.info("post commute");
		
		return "commute";
	}
	
	//연차일정페이지
		@RequestMapping(value="/leaveCalendar")
		public String leaveCalendar(Locale locale, Model model) {
			logger.info("post leaveCalendar");
			
			return "leaveCalendar";
	}
	
	//연차관리페이지
	@RequestMapping(value="/leaveManagement")
	public String leaveManagement(Locale locale, Model model) {
		logger.info("post leaveManagement");
		
		return "leaveManagement";
	}	
	
}
