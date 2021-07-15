package tobe.project.controller;

import java.util.List;
import java.util.Locale;

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
import tobe.project.dto.ApprovalDTO;
import tobe.project.dto.LeaveDTO;
import tobe.project.dto.MemberDTO;
import tobe.project.dto.MemberVO;
import tobe.project.dto.ScheduleVO;
import tobe.project.service.AdminService;
import tobe.project.service.ApprovalLineService;
import tobe.project.service.ApprovalService;
import tobe.project.service.MemberService;
import tobe.project.service.MyService;
import tobe.project.service.ScheduleService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value="/approval")
public class ApprovalController {
	
	private static final Logger logger = LoggerFactory.getLogger(ApprovalController.class);
	 
	@Inject
	private ApprovalService service;
	
	@Inject
	private AdminService aservice;
	
	@Inject
	private ApprovalLineService lservice;
	
	@Inject
	private MyService myservice;
	
	@Inject
	private MemberService mservice;
	
	@Inject
	private ScheduleService sservice;
	
	@RequestMapping(value = "/documentListMain")
	public String documentMain(Model model, @ModelAttribute("scri")SearchCriteria scri,String t_id) throws Exception{
		System.out.println("ApprovalController");
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.totalCountApprovalDocument(scri));
		
		model.addAttribute("paging",pageMaker);
		model.addAttribute("elist", service.selectAllApprovalDocumentList(scri));
		
		model.addAttribute("wa",service.totalCountWaiting());
		model.addAttribute("pr",service.totalCountProgress());
		model.addAttribute("co",service.totalCountComplete());
		model.addAttribute("no",service.totalCountNo());
		
		return "/approval/documentListMain";
	}
	@RequestMapping(value = "/documentListMy")
	public String documentListMy(Model model,@ModelAttribute("scri")SearchCriteria scri,String t_id) throws Exception {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.totalCountApprovalDocument(scri));
		
		model.addAttribute("paging",pageMaker);
		model.addAttribute("elist", service.selectAllApprovalDocumentList(scri));
		
		model.addAttribute("wa",service.totalCountWaiting());
		model.addAttribute("pr",service.totalCountProgress());
		model.addAttribute("co",service.totalCountComplete());
		model.addAttribute("no",service.totalCountNo());
		return "/approval/documentListMy";
	}
	
	@RequestMapping(value = "/documentWite")
	public String documentWite(Model model,Locale locale) throws Exception {
		List<MemberVO> vo = aservice.selectAllMember();
		model.addAttribute("allMember",vo);
		
		return "/approval/documentWite";
	} 
	
	@ResponseBody
	@RequestMapping(value = "/addDocumentWite", method = RequestMethod.POST)
	public ApprovalDTO addDocumentWite(@RequestBody ApprovalDTO dto,Locale locale) throws Exception {
		logger.info("Welcome home! addDocumentWite", locale);
		System.out.println("dto="+dto);
		if(dto.getT_position().equals("팀장")) {
			dto.setStatus("0300");
			dto.setE_status("결재대기");
		}else if(dto.getT_position().equals("부장")) {
			dto.setStatus("0030");
			dto.setTeamLeader("결재권한없음");
			dto.setE_status("결재대기");
		}else if(dto.getT_position().equals("과장")) {
			dto.setStatus("0003");
			dto.setTeamLeader("결재권한없음");
			dto.setDepartmentHead("결재권한없음");
			dto.setE_status("결재대기");
		}else if(dto.getT_position().equals("대표")) {
			dto.setStatus("0000");
			dto.setTeamLeader("결재권한없음");
			dto.setDepartmentHead("결재권한없음");
			dto.setSectionHead("결재권한없음");
			dto.setE_status("결재완료");
		}
		service.writeApprovalDocument(dto);
		lservice.writeApprovalLine(dto);
		return dto;
	}
	
	@RequestMapping(value = "/documentContents")
	public ApprovalDTO documentContents(Model model,int eidx, int tidx) throws Exception{
		ApprovalDTO dto = lservice.selectOneApprovalLine(eidx);
		List<MemberVO> vo = aservice.selectAllMember();
		
		model.addAttribute("vo",vo);
		model.addAttribute("to",dto);
		model.addAttribute("mo",aservice.selectOneMember(tidx));
		model.addAttribute("contents",service.selectOneApprovalDocumentContents(eidx));
		return dto;
	}
	
	@RequestMapping(value = "/documentOk")
	public ApprovalDTO documentOK(Model model,int eidx) throws Exception{
		ApprovalDTO to = service.selectOneApprovalDocumentContents(eidx);
		ApprovalDTO to2 = lservice.selectOneApprovalLine(eidx);
		LeaveDTO dto = myservice.selectOneLeave(eidx);
		ScheduleVO vo = new ScheduleVO();
		ScheduleVO vo2 = new ScheduleVO();
		MemberDTO memb = mservice.selectOneMemberIdx(to2.getTidx());
		int checkLeave = memb.getT_leave_get() - dto.getA_useddays();
		
		if(to2.getStatus().equals("3000")) {
			lservice.modifyApprovalTeamLeader(eidx);
			service.modifyApprovalStatusProgress(eidx);
		}else if(to2.getStatus().equals("0300")){
			lservice.modifyApprovalDepartmentHead(eidx);
			service.modifyApprovalStatusProgress(eidx);
		}else if(to2.getStatus().equals("0030")){
			lservice.modifyApprovalSectionHead(eidx);
			service.modifyApprovalStatusProgress(eidx);
		}else{
			if(to.getStatus().equals("0000")){
				vo.setS_type(to.getE_type());
				vo.setS_title(to.getE_textTitle());
				vo.setS_startDate(to.getE_draftDate());
				vo.setS_endDate(to.getE_startDay());
				vo.setS_content(to.getE_textContent());
				vo.setTidx(to.getTidx());
			}
			dto.setA_useddays(checkLeave);
			int mySchedule = myservice.updateLeave(dto);
			if(mySchedule == 1) {
				vo2.setS_type(dto.getE_type());
				vo2.setS_title(dto.getE_texttitle());
				vo2.setS_startDate(dto.getA_startdate());
				vo2.setS_endDate(dto.getA_enddate());
				vo2.setS_content(dto.getE_textcontent());
				vo2.setTidx(dto.getTidx());
			}
			sservice.addSchedule(vo);
			sservice.addSchedule(vo2);
			lservice.modifyApprovalLeader(eidx);
			service.modifyApprovalStatusOk(eidx);
		}
		return to2;
	}
	
	@RequestMapping(value = "/documentNo")
	public ApprovalDTO documentNo(Model model,ApprovalDTO dto,int eidx) throws Exception{
		System.out.println("반려 사유 = "+dto);
		ApprovalDTO to = service.selectOneApprovalDocumentContents(eidx);
		lservice.modifyApprovalNo(eidx);
		service.modifyApprovalStatusNo(dto);
		return to;
	}
	
	@RequestMapping(value = "/documentModify")
	public ApprovalDTO documentModify(Model model,int eidx,int tidx) throws Exception{
		ApprovalDTO dto = service.selectOneApprovalDocumentContents(eidx);
		model.addAttribute("mo",aservice.selectOneMember(tidx));
		model.addAttribute("contents",dto);
		return dto;
	}
	@ResponseBody
	@RequestMapping(value = "/ModifyDocumentWite", method = RequestMethod.POST)
	public ApprovalDTO modifyApprovalDocument(@RequestBody ApprovalDTO dto) throws Exception {
		service.modifyApprovalDocument(dto);
		return dto;
	}
	
	@RequestMapping(value = "/documentApprovalAgain")
	public ApprovalDTO documentApprovalAgain(Model model,int eidx,int tidx) throws Exception{
		ApprovalDTO dto = service.selectOneApprovalDocumentContents(eidx);
		List<MemberVO> vo = aservice.selectAllMember();
		
		model.addAttribute("allMember",vo);
		model.addAttribute("mo",aservice.selectOneMember(tidx));
		model.addAttribute("contents",dto);
		return dto;
	}
	@ResponseBody
	@RequestMapping(value = "/documentApprovalAgainOk")
	public ApprovalDTO documentApprovalAgainOk(Model model,@RequestBody ApprovalDTO dto) throws Exception{
		service.modifyApprovalDocumentAgain(dto);
		lservice.modifyApprovalDocumentAgainLine(dto);
		return dto;
	}
	
	@RequestMapping(value = "/documentDelete")
	public String documentDelete(int eidx) throws Exception{
		service.deleteApprovalDocument(eidx);
		return "redirect:/documentContents";
	}
}
