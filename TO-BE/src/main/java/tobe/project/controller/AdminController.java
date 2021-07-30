package tobe.project.controller;
import java.util.Calendar;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import tobe.project.domain.PageMaker;
import tobe.project.domain.SearchCriteria;
import tobe.project.dto.FileVO;
import tobe.project.dto.MemberVO;
import tobe.project.service.AdminService;
import tobe.project.service.EmailService;
@Controller
@RequestMapping(value="/admin")
public class AdminController{
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	@Inject
	private AdminService service;
	@Inject
	private EmailService emailService;
	@Inject
	BCryptPasswordEncoder pwdEncoder;

	@RequestMapping(value="/add")
	public String addMember(Locale locale, Model model,MemberVO vo,HttpSession session) throws Exception {
		logger.info("사원 등록", locale);
		String check = (String)session.getAttribute("userId"); 
		if(check!=null){
			String t_id = service.selectOneId();
			if(t_id.equals("admin")) {
				Calendar cal = Calendar.getInstance();
				int year = cal.get(cal.YEAR)-2000;
				model.addAttribute("tid",year+"-0000");
				return "/admin/add";
			}else {
				String[] tid = t_id.split("-");
				int nextTid = Integer.parseInt(tid[1])+1;
				int length = (int)(Math.log10(nextTid)+1);
				String hipen = "";
				if(length==2) {
					hipen = "-00";
				}else if(length==3) {
					hipen = "-0";
				}else if(length==1) {
					hipen = "-000";
				}else if(length==4){
					hipen = "-";
				}
				String autoNum = tid[0]+hipen+nextTid;
				service.autoNumInsert(autoNum);
				//자동 증가 시키기!
				/*
				 * int chch = Integer.parseInt(service.autoNumSelect());
				 * System.out.println(chch);
				 */
				model.addAttribute("tid",autoNum);
				return "/admin/add";
			}
		}
		model.addAttribute("idnull","null");
		return "/member/checklogin"; 
	}
	@RequestMapping(value="/addAction")
	public String addMemberAction(Locale locale, Model model, MemberVO vo,MultipartHttpServletRequest mpRequest,HttpSession session) throws Exception {
		logger.info("사원 등록 처리", locale);
		String tid = vo.getT_id();
		String pwd = pwdEncoder.encode(tid);
		vo.setT_pwd(pwd);
		service.addMember2(vo,mpRequest);
		int last = service.selectLastPk();
		vo.setTidx(last);
		emailService.joinEmail(vo);
		return "redirect:/admin/memberlist";
	}
	@RequestMapping(value="/delete")
	public String deleteMember(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,Locale locale, Model model,Integer tidx,HttpSession session)throws Exception{
		logger.info("사원 퇴사", locale);
		String check = (String)session.getAttribute("userId"); 
		if(check!=null){
			service.deleteMember(tidx);
			return "redirect:/admin/memberlist";
		}
		model.addAttribute("idnull","null");
		return "/member/checklogin";
	}
	@RequestMapping(value="/info")
	public String selectOneMember(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,Locale locale, Model model,Integer tidx,HttpSession session) throws Exception {
		logger.info("사원 정보", locale);
		String check = (String)session.getAttribute("userId"); 
		if(check!=null){
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(searchCriteria);
			model.addAttribute("pageMaker",pageMaker);
			MemberVO vo = service.selectOneMember(tidx);
			FileVO fileList = service.selectOneFile(tidx);
			model.addAttribute("file",fileList);
			model.addAttribute("member",vo);
			return "/admin/info";
		}
		model.addAttribute("idnull","null");
		return "/member/checklogin"; 
	}
	@RequestMapping(value = "/modifyName")
	@ResponseBody
	public Object modifyName(Locale locale,String reName, Integer tidx, Model model,HttpServletRequest request) throws Exception {
		logger.info("사원 이름 수정", locale);
		if(reName!=null) {
			MemberVO vo = service.selectOneMember(tidx);
			vo.setT_name(reName);
			return service.modifyName(vo);
		}
		return "<script>location.href='"+request.getContextPath()+"/member/login';</script>";
	}
	@RequestMapping(value = "/modifyPosition")
	@ResponseBody
	public Object modifyPosition(Locale locale,String rePosition, Integer tidx, Model model,HttpServletRequest request) throws Exception {
		logger.info("사원 직급 수정", locale);
		if(rePosition!=null) {
			MemberVO vo = service.selectOneMember(tidx);
			vo.setT_position(rePosition);
			return service.modifyPosition(vo);
		}
		return "<script>location.href='"+request.getContextPath()+"/member/login';</script>";
		
	}
	@RequestMapping(value = "/modifyDepartment")
	@ResponseBody
	public Object modifyDepartment(Locale locale,String reDepartment, Integer tidx,HttpServletRequest request) throws Exception {
		logger.info("사원 부서 수정", locale);
		if(reDepartment!=null) {
			MemberVO vo = service.selectOneMember(tidx);
			vo.setT_department(reDepartment);
			return service.modifyDepartment(vo);
		}
		return "<script>location.href='"+request.getContextPath()+"/member/login';</script>";
	}
	@RequestMapping(value="/memberlist")
	public String selectAllMember(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,Locale locale, Model model) throws Exception {
		logger.info("관리자 사원리스트", locale);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(searchCriteria);
		pageMaker.setTotalCount(service.totalCountsearchMember(searchCriteria));
		model.addAttribute("memberList",service.searchMemberList(searchCriteria));
		model.addAttribute("pageMaker",pageMaker);
		return "/admin/list";
	}
	@RequestMapping(value = "/findAdmin")
	public String findAdmin(Locale locale,Model model,HttpSession session)throws Exception{
		logger.info("관리자 조회", locale);
		int check = service.adminCheck();
		if(check==0) {
			model.addAttribute("message","관리자 등록페이지로 이동합니다.");
			model.addAttribute("check","0");
			session.setAttribute("result", "true");
			return "/admin/check";
		}else if(check>=1) {
			model.addAttribute("message","관리자가 존재합니다.");
			model.addAttribute("check","1");
			session.setAttribute("result", "false");
			return "/admin/check";
		}
		return "/member/login";
	}
	@RequestMapping(value = "/join")
	public String joinAdmin(Locale locale,Model model,HttpSession session)throws Exception{
		logger.info("관리자 가입", locale);
		session.getAttribute("result");
		return "/admin/join";
	}
	@RequestMapping(value = "/joinAction")
	public String joinAction(Locale locale,Model model,MemberVO vo,MultipartHttpServletRequest mpRequest,HttpSession session)throws Exception{
		logger.info("관리자 가입 처리", locale);
		if(vo==null) {
			model.addAttribute("idnull","null");
			return "/member/checklogin"; 
		}
		String pwd = pwdEncoder.encode(vo.getT_pwd());
		vo.setT_pwd(pwd);
		service.insertAdmin(vo,mpRequest);
		return "redirect:/member/login";
	}
}
