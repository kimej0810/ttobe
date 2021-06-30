package tobe.project.controller;

import java.util.HashMap;
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
import tobe.project.dto.ApprovalVO;
import tobe.project.dto.MemberVO;
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
	
	//�쟾�옄寃곗옱 硫붿씤
	@RequestMapping(value = "/documentListMain")
	public String documentMain(Model model, @ModelAttribute("scri")SearchCriteria scri, String searchType) throws Exception{
		System.out.println("ApprovalController");
		System.out.println("searchType->"+searchType);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.totalCountApprovalDocument(scri));
		
		model.addAttribute("paging",pageMaker);
		model.addAttribute("elist", service.selectAllApprovalDocumentList(scri));
		
		model.addAttribute("wa",service.totalCountWaiting());
		model.addAttribute("pr",service.totalCountProgress());
		model.addAttribute("co",service.totalCountComplete());
		
		return "/approval/documentListMain";
	}
	
	@RequestMapping(value = "/documentApprovalLine")
	public String documentApprovalLine() {
		
		return "/approval/documentApprovalLine";
	}
	//湲곗븞�꽌 �옉�꽦�럹�씠吏�
	@RequestMapping(value = "/documentWite")
	public String documentWite(Locale locale) throws Exception {
		logger.info("Welcome home! addDocumentWite", locale);
		return "/approval/documentWite";
	}
	
	//湲곗븞�꽌 �옉�꽦 ajax�샇異�
	@ResponseBody
	@RequestMapping(value = "/addDocumentWite", method = RequestMethod.POST)
	public Map<Object,Object> addDocumentWite(@RequestBody ApprovalVO vo,Locale locale) throws Exception {
		logger.info("Welcome home! addDocumentWite", locale);
		Map<Object,Object> map = new HashMap<Object,Object>();
		service.writeApprovalDocument(vo);
		return map;
				
	}
	
	//寃곗옱臾몄꽌 �긽�꽭蹂닿린
	@RequestMapping(value = "/documentContents")
	public ApprovalVO documentContents(Model model,int e_documentNum, int tidx) throws Exception{
		ApprovalVO vo = service.selectOneApprovalDocumentContents(e_documentNum);
		MemberVO mo = service.selectOneMember(tidx);
		model.addAttribute("mo",mo);
		model.addAttribute("contents",vo);
		return vo;
	}
	//寃곗옱臾몄꽌 �닔�젣
	@RequestMapping(value = "/documentModify")
	public ApprovalVO documentModify(Model model,int e_documentNum,int tidx) throws Exception{
		ApprovalVO vo = service.selectOneApprovalDocumentContents(e_documentNum);
		MemberVO mo = service.selectOneMember(tidx);
		System.out.println("臾몄꽌踰덊샇"+e_documentNum);
		System.out.println("member"+mo);
		model.addAttribute("mo",mo);
		model.addAttribute("contents",vo);
		return vo;
	}
	
	//寃곗옱臾몄꽌 �닔�젙 ajax
	@ResponseBody
	@RequestMapping(value = "/ModifyDocumentWite", method = RequestMethod.POST)
	public Map<Object,Object> modifyApprovalDocument(@RequestBody ApprovalVO vo) throws Exception {
		Map<Object,Object> map = new HashMap<Object,Object>();
		service.modifyApprovalDocument(vo);
		return map;
				
	}
	//寃곗옱臾몄꽌 �궘�젣
	@RequestMapping(value = "/documentDelete")
	public String documentDelete(int eidx) throws Exception{
		service.deleteApprovalDocument(eidx);
		return "redirect:/documentContents";
	}
}
