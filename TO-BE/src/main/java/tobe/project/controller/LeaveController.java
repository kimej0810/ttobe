package tobe.project.controller;

import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import tobe.project.dto.ApprovalDTO;
import tobe.project.dto.LeaveDTO;
import tobe.project.dto.MemberDTO;
import tobe.project.service.MemberService;
import tobe.project.service.MyService;

@Controller
@RequestMapping(value = "/leave")
public class LeaveController {
	private static final Logger logger = LoggerFactory.getLogger(LeaveController.class);
	@Inject
	private MemberService service;
	@Inject
	private MyService myService;
	
	@RequestMapping(value="/write", method = RequestMethod.GET)
	public String leave(Model model,HttpSession session,String t_id,Locale locale) throws Exception {
		logger.info("연자 등록", locale);
		MemberDTO vo = service.selectOneMember(t_id);
		List<MemberDTO> dto = service.selectAllMember2();
		model.addAttribute("memberList",dto);
		model.addAttribute("member",vo);
		return "/leave/write";
	}
	@RequestMapping(value="/view", method = RequestMethod.GET)
	public String leave(Model model,HttpSession session,int eidx,Locale locale) throws Exception {
		logger.info("연차 보기", locale);
		LeaveDTO leave = myService.selectOneLeave(eidx);
		Integer tidx = (Integer)session.getAttribute("userTidx");
		model.addAttribute("leave",leave);
		if(tidx!=null) {
			model.addAttribute("member",service.selectOneMemberIdx(leave.getTidx()));
			model.addAttribute("memberList",service.selectAllMember2());
			return "/leave/view";
		}
		return "redirect:/member/login";
	}
	@ResponseBody
	@RequestMapping(value="/no")
	public int leaveNo(Model model,HttpSession session,ApprovalDTO dto,Locale locale) throws Exception {
		logger.info("연차 반려", locale);
		return myService.leaveNo(dto);
	}
	@ResponseBody
	@RequestMapping(value="/writeAction")
	public int leaveAction(Model model,HttpSession session,LeaveDTO dto,Locale locale) throws Exception {
		logger.info("연차 등록 처리", locale);
		return myService.writeLeave(dto); 
	}
	@ResponseBody
	@RequestMapping(value="/delete")
	public int leaveDelete(Model model,int eidx,Locale locale) throws Exception {
		logger.info("연자 삭제 처리", locale);
		return myService.leaveDelete(eidx);
	}
	@RequestMapping(value="/modify")
	public String leaveModify(Model model,HttpSession session,int eidx,Locale locale) throws Exception {
		logger.info("연차 수정", locale);
		LeaveDTO leave = myService.selectOneLeave(eidx);
		Integer tidx = (Integer)session.getAttribute("userTidx");
		model.addAttribute("leave",leave);
		if(tidx!=null) {
			model.addAttribute("member",service.selectOneMemberIdx(tidx));
			model.addAttribute("memberList",service.selectAllMember2());
			return "/leave/modify";
		}
		return "/member/login";
	}
	@ResponseBody
	@RequestMapping(value="/modifyAction")
	public int leaveModifyAction(Model model,HttpSession session,LeaveDTO dto,Locale locale) throws Exception {
		logger.info("연차 수정 처리", locale);
		return myService.modifyLeave(dto);
	}
	@ResponseBody
	@RequestMapping(value="/reModifyAction")
	public int leaveReModifyAction(Model model,HttpSession session,LeaveDTO dto,Locale locale) throws Exception {
		logger.info("연차 재기안 처리", locale);
		return myService.modifyReLeave(dto);
	}
}
