package tobe.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
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
import tobe.project.dto.ApprovalDTO;
import tobe.project.dto.ApprovalLineVO;
import tobe.project.dto.ApprovalVO;
import tobe.project.dto.MemberVO;
import tobe.project.service.AdminService;
import tobe.project.service.ApprovalLineService;
import tobe.project.service.ApprovalService;

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
	public String documentMain(Model model, @ModelAttribute("scri")SearchCriteria scri, String searchType,String t_id) throws Exception{
		System.out.println("ApprovalController");
		System.out.println("searchType->"+searchType);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.totalCountApprovalDocument(scri));
		
		model.addAttribute("paging",pageMaker);
		model.addAttribute("elist", service.selectAllApprovalDocumentList(scri));
		
		model.addAttribute("re",service.totalCountWaiting());
		model.addAttribute("pr",service.totalCountProgress());
		model.addAttribute("co",service.totalCountComplete());
		
		model.addAttribute("ma",lservice.totalCountMyApprovalToDo(t_id));
		return "/approval/documentListMain";
	}
	
	@RequestMapping(value = "/documentApprovalLine")
	public String documentApprovalLine() {
		
		return "/approval/documentApprovalLine";
	}
	@RequestMapping(value = "/documentWite")
	public String documentWite(Model model,Locale locale) throws Exception {
		List<MemberVO> vo = aservice.selectAllMember();
		model.addAttribute("allMember",vo);
		logger.info("Welcome home! DocumentWite", locale);
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
		ApprovalVO vo = service.selectOneApprovalDocumentContents(eidx);
		MemberVO mo = service.selectOneMember(tidx);
		ApprovalDTO to = lservice.selectOneApprovalLine(eidx);
		System.out.println("to="+ to);
		
		model.addAttribute("to",to);
		model.addAttribute("mo",mo);
		model.addAttribute("contents",vo);
		return to;
	}
	
	@RequestMapping(value = "/documentOk")
	public ApprovalDTO documentOK(Model model,int eidx) throws Exception{
		System.out.println("마 이게 eidx다 ! "+eidx);
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
	
	
	@RequestMapping(value = "/documentModify")
	public ApprovalVO documentModify(Model model,int e_documentNum,int tidx) throws Exception{
		ApprovalVO vo = service.selectOneApprovalDocumentContents(e_documentNum);
		MemberVO mo = service.selectOneMember(tidx);
		System.out.println("member"+mo);
		model.addAttribute("mo",mo);
		model.addAttribute("contents",vo);
		return vo;
	}
	
	@ResponseBody
	@RequestMapping(value = "/ModifyDocumentWite", method = RequestMethod.POST)
	public Map<Object,Object> modifyApprovalDocument(@RequestBody ApprovalVO vo) throws Exception {
		Map<Object,Object> map = new HashMap<Object,Object>();
		service.modifyApprovalDocument(vo);
		return map;
				
	}
	
	@RequestMapping(value = "/documentDelete")
	public String documentDelete(int eidx) throws Exception{
		service.deleteApprovalDocument(eidx);
		return "redirect:/documentContents";
	}
}
