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
		
		if(dto.getT_position().equals("사원")) { 
			dto.setE_status("결재대기"); 
			dto.setStatus("3000");
		}else if(dto.getT_position().equals("팀장")) {
			dto.setStatus("0300");
			dto.setE_status("결재대기");
		}else if(dto.getT_position().equals("과장")) {
			dto.setStatus("0030");
			dto.setTeamLeader("결재권한없음");
			dto.setE_status("결재대기");
		}else if(dto.getT_position().equals("부장")) {
			dto.setStatus("0003");
			dto.setTeamLeader("결재권한없음");
			dto.setSectionHead("결재권한없음");
			dto.setE_status("결재대기");
		}
		
		service.writeApprovalDocument(dto);
		lservice.writeApprovalLine(dto);
		return dto;
	}
	
	@RequestMapping(value = "/documentContents")
	public ApprovalDTO documentContents(Model model,ApprovalDTO dto) throws Exception{
		ApprovalDTO dto2 = lservice.selectOneApprovalLine(dto.getEidx());
		List<MemberVO> vo = aservice.selectAllMember();
		
		model.addAttribute("vo",vo);
		model.addAttribute("to",dto2);
		model.addAttribute("mo",aservice.selectOneMember(dto2.getTidx()));
		model.addAttribute("contents",service.selectOneApprovalDocumentContents(dto2.getEidx()));
		return dto;
	}
	
	@RequestMapping(value = "/documentOk")
	public ApprovalDTO documentOK(Model model,int eidx) throws Exception{
		ApprovalDTO to = service.selectOneApprovalDocumentContents(eidx);
		ApprovalDTO to2 = lservice.selectOneApprovalLine(eidx);
		LeaveDTO dto = myservice.selectOneLeave(eidx);
		int approvalOk = service.modifyApprovalStatusOk(eidx);
		
		if(to2.getStatus().equals("3000")) {
			lservice.modifyApprovalTeamLeader(eidx);
			service.modifyApprovalStatusProgress(eidx);
		}else if(to2.getStatus().equals("0300")){
			lservice.modifyApprovalSectionHead(eidx);
			service.modifyApprovalStatusProgress(eidx);
		}else if(to2.getStatus().equals("0030")){
			lservice.modifyApprovalDepartmentHead(eidx);
			service.modifyApprovalStatusProgress(eidx);
		}else{
			lservice.modifyApprovalLeader(eidx);
			if(!to.getE_type().equals("연차") && !to.getE_type().equals("월차") && !to.getE_type().equals("병가") && !to.getE_type().equals("반차")){
				if(approvalOk == 1){
					ScheduleVO vo = new ScheduleVO();
					vo.setS_type(to.getE_type());
					vo.setS_title(to.getE_textTitle());
					vo.setS_startDate(to.getE_startDay());
					vo.setS_endDate(to.getE_endDay());
					vo.setS_content(to.getE_textContent());
					vo.setTidx(to.getTidx());
					sservice.addSchedule(vo);
				}
			}else {
				MemberDTO memb = mservice.selectOneMemberIdx(to2.getTidx());
				double checkLeave = memb.getT_leave_get() - dto.getA_useddays();
				dto.setA_useddays(checkLeave);
				int mySchedule = myservice.updateLeave(dto);
				if(mySchedule == 1) {
					ScheduleVO vo = new ScheduleVO();
					vo.setS_type(dto.getE_type());
					vo.setS_title(dto.getE_texttitle());
					vo.setS_startDate(dto.getE_startday());
					vo.setS_endDate(dto.getE_endday());
					vo.setS_content(dto.getE_textcontent());
					vo.setTidx(dto.getTidx());
					sservice.addSchedule(vo);
				}
			}
		}
		return to2;
	}
	@RequestMapping(value = "/documentNo")
	public ApprovalDTO documentNo(Model model,ApprovalDTO dto) throws Exception{
 		service.selectOneApprovalDocumentContents(dto.getEidx());
		dto.setE_approvalNoPerson(service.selectOneMember(dto.getTidx()).getT_name());
		lservice.modifyApprovalNo(dto.getEidx());
		service.modifyApprovalStatusNo(dto);
		return dto;
	}
	@RequestMapping(value = "/documentModify")
	public ApprovalDTO documentModify(Model model, ApprovalDTO dto) throws Exception{
		ApprovalDTO dto2 = service.selectOneApprovalDocumentContents(dto.getEidx());
		List<MemberVO> vo = aservice.selectAllMember();
		
		model.addAttribute("allMember",vo);
		model.addAttribute("mo",aservice.selectOneMember(dto2.getTidx()));
		model.addAttribute("contents",dto2);
		return dto2;
	}
	@ResponseBody
	@RequestMapping(value = "/ModifyDocumentWite", method = RequestMethod.POST)
	public ApprovalDTO modifyApprovalDocument(@RequestBody ApprovalDTO dto) throws Exception {
		service.modifyApprovalDocument(dto);
		lservice.modifyApprovalLine(dto);
		return dto;
	}
	
	@RequestMapping(value = "/documentApprovalAgain")
	public ApprovalDTO documentApprovalAgain(Model model,ApprovalDTO dto) throws Exception{
		ApprovalDTO dto2 = service.selectOneApprovalDocumentContents(dto.getEidx());
		List<MemberVO> vo = aservice.selectAllMember();
		
		model.addAttribute("allMember",vo);
		model.addAttribute("mo",aservice.selectOneMember(dto2.getTidx()));
		model.addAttribute("contents",dto2);
		return dto2;
	}
	@ResponseBody
	@RequestMapping(value = "/documentApprovalAgainOk")
	public ApprovalDTO documentApprovalAgainOk(Model model,@RequestBody ApprovalDTO dto) throws Exception{
		MemberDTO mo = mservice.selectOneMemberIdx(dto.getTidx());
		
		if(mo.getT_position().equals("팀장")) {
			dto.setStatus("0300");
		}else if(mo.getT_position().equals("과장")) {
			dto.setStatus("0030");
		}else if(mo.getT_position().equals("부장")) {
			dto.setStatus("0003");
		}else {
			dto.setStatus("3000");
		}
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
