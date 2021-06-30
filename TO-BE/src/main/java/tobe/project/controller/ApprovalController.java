package tobe.project.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

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
	
	//전자결재 메인
	@RequestMapping(value = "/documentListMain")
	public String documentMain(Model model, @ModelAttribute("scri")SearchCriteria scri, String searchType) throws Exception{
		System.out.println("ApprovalController");
		System.out.println("searchType->"+searchType);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.totalCountApprovalDocument(scri));
		
		model.addAttribute("paging",pageMaker);
		model.addAttribute("elist", service.selectAllApprovalDocumentList(scri));
		
		return "/approval/documentListMain";
	}
	//기안서 작성페이지
	@RequestMapping(value = "/documentWite")
	public String documentWite(Locale locale) throws Exception {
		logger.info("Welcome home! addDocumentWite", locale);
		return "/approval/documentWite";
	}
	
	//기안서 작성 ajax호출
	@ResponseBody
	@RequestMapping(value = "/addDocumentWite", method = RequestMethod.POST)
	public Map<Object,Object> addDocumentWite(@RequestBody ApprovalVO vo,Locale locale) throws Exception {
		logger.info("Welcome home! addDocumentWite", locale);
		Map<Object,Object> map = new HashMap<Object,Object>();
		service.writeApprovalDocument(vo);
		return map;
				
	}
	
	//결재문서 상세보기
	@RequestMapping(value = "/documentContents")
	public ApprovalVO documentContents(Model model,int e_documentNum, int tidx) throws Exception{
		ApprovalVO vo = service.selectOneApprovalDocumentContents(e_documentNum);
		MemberVO mo = service.selectOneMember(tidx);
		model.addAttribute("mo",mo);
		model.addAttribute("contents",vo);
		return vo;
	}
	//결재문서 수제
	@RequestMapping(value = "/documentModify")
	public ApprovalVO documentModify(Model model,int e_documentNum,int tidx) throws Exception{
		ApprovalVO vo = service.selectOneApprovalDocumentContents(e_documentNum);
		MemberVO mo = service.selectOneMember(tidx);
		System.out.println("문서번호"+e_documentNum);
		System.out.println("member"+mo);
		model.addAttribute("mo",mo);
		model.addAttribute("contents",vo);
		return vo;
	}
	
	//결재문서 수정 ajax
	@ResponseBody
	@RequestMapping(value = "/ModifyDocumentWite", method = RequestMethod.POST)
	public Map<Object,Object> modifyApprovalDocument(@RequestBody ApprovalVO vo) throws Exception {
		Map<Object,Object> map = new HashMap<Object,Object>();
		service.modifyApprovalDocument(vo);
		return map;
				
	}
	//결재문서 삭제
	@RequestMapping(value = "/documentDelete")
	public String documentDelete(int eidx) throws Exception{
		service.deleteApprovalDocument(eidx);
		return "redirect:/documentContents";
	}
}
