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
import tobe.project.dto.LoginDTO;
import tobe.project.dto.MemberVO;
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
	private MemberService mservice;
	
	//전자결재 메인(대기목록)
	@RequestMapping(value = "/documentListMain")
	public String documentMain(HttpServletRequest request, LoginDTO dto, Model model, @ModelAttribute("scri")SearchCriteria scri) throws Exception{
		System.out.println("ApprovalController");
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.totalCountApprovalWaitingDocument(scri));
		
		model.addAttribute("paging",pageMaker);
		model.addAttribute("elist", service.selectAllApprovalWaitingDocumentList(scri));

		//로그인 정보
		System.out.println(dto);
		MemberVO vo = mservice.login(dto);
		System.out.println(vo);
		
		
		
		return "/approval/documentListMain";
	} 	
	
	//전자결재 대기리스트
	@RequestMapping(value = "/documentWaitingList")
	public String documentWaiting(LoginDTO dto, String t_id,Model model, @ModelAttribute("scri")SearchCriteria scri) throws Exception{
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.totalCountApprovalWaitingDocument(scri));
		
		model.addAttribute("paging", pageMaker);
		model.addAttribute("waiting", service.selectAllApprovalWaitingDocumentList(scri));
		
		//로그인정보
		MemberVO vo = mservice.login(dto);
		model.addAttribute("info",vo);
		System.out.println(t_id);
		
		return "/approval/documentWaitingList";
	}
	
	//전자결재 진행중 리스트
	@RequestMapping(value = "/documentInProgress")
	public String documentInProgress(LoginDTO dto, String t_id, Model model, @ModelAttribute("scri")SearchCriteria scri) throws Exception{
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.totalCountApprovalProgressDocument(scri));
		
		model.addAttribute("paging", pageMaker);
		model.addAttribute("progress", service.selectAllApprovalProgressDocumentList(scri));
		
		//로그인정보
		MemberVO vo = mservice.login(dto);
		model.addAttribute("info",vo);
		System.out.println(t_id);
		
		return "/approval/documentInProgress";
	}
	
	//전자결재 완료리스트
	@RequestMapping(value = "/documentPaymentCompleted")
	public String documentPaymentCompleted(LoginDTO dto, String t_id, Model model, @ModelAttribute("scri")SearchCriteria scri) throws Exception{
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.totalCountApprovalPaymentCompletedDocument(scri));
		
		model.addAttribute("paging",pageMaker);
		model.addAttribute("completed", service.selectAllApprovalPaymentCompletedDocumentList(scri));
		
		//로그인정보
		MemberVO vo = mservice.login(dto);
		model.addAttribute("info",vo);
		System.out.println(t_id);
		
		return "/approval/documentPaymentCompleted";
	}
	
	//기안서 작성페이지
	@RequestMapping(value = "/documentWite")
	public String documentWite(LoginDTO dto,String t_id,Locale locale) throws Exception {
		logger.info("Welcome home! addDocumentWite", locale);
		MemberVO vo = mservice.login(dto);
		System.out.println(vo);
		System.out.println(t_id);
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
	public ApprovalVO documentContents(Model model,int e_documentNum) throws Exception{
		
		ApprovalVO vo = service.selectOneApprovalDocumentContents(e_documentNum);
		
		model.addAttribute("contents",vo);
		return vo;
	}
	//결재문서 수제
	@RequestMapping(value = "/documentModify")
	public ApprovalVO documentModify(Model model,int e_documentNum) throws Exception{
		ApprovalVO vo = service.selectOneApprovalDocumentContents(e_documentNum);
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
