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
import tobe.project.dto.MemberVO;
import tobe.project.service.AdminService;
import tobe.project.service.ApprovalLineService;
import tobe.project.service.ApprovalService;
import tobe.project.service.MemberService;

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
		service.writeApprovalDocument(dto);
		lservice.writeApprovalLine(dto);
		return dto;
	}
	
	@RequestMapping(value = "/documentContents")
	public ApprovalDTO documentContents(Model model,int eidx, int tidx) throws Exception{
		ApprovalDTO dto = lservice.selectOneApprovalLine(eidx);
//		mservice.selectOneMember(to.getTeamLeader());
//		mservice.selectOneMember(to.getDepartmentHead());
//		mservice.selectOneMember(to.getSectionHead());
//		mservice.selectOneMember(to.getLeader());
		
		model.addAttribute("to",dto);
		model.addAttribute("mo",aservice.selectOneMember(tidx));
		model.addAttribute("contents",service.selectOneApprovalDocumentContents(eidx));
		return dto;
	}
	
	@RequestMapping(value = "/documentOk")
	public ApprovalDTO documentOK(Model model,int eidx) throws Exception{
		ApprovalDTO to = lservice.selectOneApprovalLine(eidx);
		
		if(to.getStatus().equals("3000")) {
			lservice.modifyApprovalTeamLeader(eidx);
			service.modifyApprovalStatusProgress(eidx);
		}else if(to.getStatus().equals("0300")){
			lservice.modifyApprovalDepartmentHead(eidx);
		}else if(to.getStatus().equals("0030")){
			lservice.modifyApprovalSectionHead(eidx);
		}else{
			lservice.modifyApprovalLeader(eidx);
			service.modifyApprovalStatusOk(eidx);
		}
		return to;
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
