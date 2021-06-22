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
	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws Exception 
	 */
	@RequestMapping(value = "/documentListMain")
	public String documentMain(Model model, @ModelAttribute("scri")SearchCriteria scri) throws Exception{
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.totalCountApprovalWaitingDocument(scri));
		
		model.addAttribute("paging",pageMaker);
		model.addAttribute("elist", service.selectAllApprovalWaitingDocumentList(scri));
		return "/approval/documentListMain";
	} 	
	
	//���ڰ��� ��⸮��Ʈ
	@RequestMapping(value = "/documentWaitingList")
	public String documentWaiting(Model model, @ModelAttribute("scri")SearchCriteria scri) throws Exception{
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.totalCountApprovalWaitingDocument(scri));
		
		model.addAttribute("paging", pageMaker);
		model.addAttribute("waiting", service.selectAllApprovalWaitingDocumentList(scri));
		
		
		return "/approval/documentWaitingList";
	}
	
	//���ڰ��� �����߸���Ʈ
	@RequestMapping(value = "/documentInProgress")
	public String documentInProgress(Model model, @ModelAttribute("scri")SearchCriteria scri) throws Exception{
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.totalCountApprovalProgressDocument(scri));
		
		model.addAttribute("paging", pageMaker);
		model.addAttribute("progress", service.selectAllApprovalProgressDocumentList(scri));
		return "/approval/documentInProgress";
	}
	
	//���ڰ��� �ϷḮ��Ʈ
	@RequestMapping(value = "/documentPaymentCompleted")
	public String documentPaymentCompleted(Model model, @ModelAttribute("scri")SearchCriteria scri) throws Exception{
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.totalCountApprovalPaymentCompletedDocument(scri));
		
		model.addAttribute("paging",pageMaker);
		model.addAttribute("completed", service.selectAllApprovalPaymentCompletedDocumentList(scri));
		return "/approval/documentPaymentCompleted";
	}
	
	//��ȼ� �ۼ� 
	@ResponseBody
	@RequestMapping(value = "/addDocumentWite", method = RequestMethod.POST)
	public Map<Object,Object> addDocumentWite(@RequestBody ApprovalVO vo,Locale locale) throws Exception {
		logger.info("Welcome home! addDocumentWite", locale);
		Map<Object,Object> map = new HashMap<Object,Object>();
		service.writeApprovalDocument(vo);
		return map;
				
	}
	
	//�������� �󼼺���
	@RequestMapping(value = "/documentContents")
	public ApprovalVO documentContents(Model model,int e_documentNum) throws Exception{
		
		ApprovalVO vo = service.selectOneApprovalDocumentContents(e_documentNum);
		
		model.addAttribute("contents",vo);
		return vo;
	}
	//�������� ����
	@RequestMapping(value = "/documentModify")
	public ApprovalVO documentModify(Model model,int e_documentNum) throws Exception{
		ApprovalVO vo = service.selectOneApprovalDocumentContents(e_documentNum);
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
	//�������� ����
	@RequestMapping(value = "/documentDelete")
	public String documentDelete(int eidx) throws Exception{
		service.deleteApprovalDocument(eidx);
		return "redirect:/documentContents";
	}
	
	//��ȼ� ������
	@RequestMapping(value = "/documentWrite")
	public String documentWite(Locale locale) throws Exception {
		logger.info("Welcome home! addDocumentWite", locale);
		return "/approval/documentWrite";
	}
	
	
	
	
	//��ȼ���
	@RequestMapping(value = "/remainder/gianWrite")
	public String gianWrite(Locale locale, Model model) throws Exception {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "approval/gianWrite";
	}
	
	//������Ǽ� ������
	@RequestMapping(value = "/remainder/Expense")
	public String Expense(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "/approval/remainder/Expense";
	}
	
	//�ް� ��û��
	@RequestMapping(value = "/remainder/leave")
	public String leave(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "/approval/remainder/leave";
	}
	
	//���� ��û��
	@RequestMapping(value = "/remainder/businessTripApplication")
	public String businessTripApplication(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "/approval/remainder/businessTripApplication";
	}
	@RequestMapping(value = "/remainder/businessTripExpensesBill")
	public String businessTripExpensesBil(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "/approval/remainder/businessTripExpensesBill";
	}
}
