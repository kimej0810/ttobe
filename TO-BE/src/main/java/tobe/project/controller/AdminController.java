package tobe.project.controller;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;

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
@Controller
@RequestMapping(value="/admin")
public class AdminController{
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	@Inject
	private AdminService service;
	@Inject
	BCryptPasswordEncoder pwdEncoder;

	@RequestMapping(value="/add")
	public String addMember(Locale locale, Model model,MemberVO vo) throws Exception {
		logger.info("Welcome home! The client locale is {}.", locale);
		String t_id = service.selectOneId();
		String[] tid = t_id.split("-");
		int nextTid = Integer.parseInt(tid[1])+1;
		int length = (int)(Math.log10(nextTid)+1);
		System.out.println("nextTid>>>>>>>>>>>>"+nextTid);
		System.out.println("length>>>>>>>>>>>>"+length);
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
		model.addAttribute("tid",tid[0]+hipen+nextTid);
		model.addAttribute("member");
		return "/admin/add";
	}
	@RequestMapping(value="/addAction")
	public String addMemberAction(Locale locale, Model model, MemberVO vo,MultipartHttpServletRequest mpRequest) throws Exception {
		String tid = vo.getT_id();
		String pwd = pwdEncoder.encode(tid);
		vo.setT_pwd(pwd);
		service.addMember2(vo,mpRequest);
		return "redirect:/admin/memberlist";
	}
	@RequestMapping(value="/delete")
	public String deleteMember(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,Locale locale, Model model,int tidx)throws Exception{
		service.deleteMember(tidx);
		return "redirect:/admin/memberlist";
	}
	@RequestMapping(value="/info")
	public String selectOneMember(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,Locale locale, Model model,int tidx) throws Exception {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(searchCriteria);
		model.addAttribute("pageMaker",pageMaker);
		MemberVO vo = service.selectOneMember(tidx);
		//파일조회
		FileVO fileList = service.selectOneFile(tidx);
		model.addAttribute("file",fileList);
		model.addAttribute("member",vo);
		return "/admin/info";
	}
	@RequestMapping(value="/modify")
	public String modifyMember(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,Locale locale, Model model,int tidx) throws Exception {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(searchCriteria);
		pageMaker.setTotalCount(service.totalCountsearchMember(searchCriteria));
		model.addAttribute("memberList",service.searchMemberList(searchCriteria));
		model.addAttribute("pageMaker",pageMaker);
		MemberVO vo = service.selectOneMember(tidx);
		model.addAttribute("member",vo);
		return "/admin/modify";
	}
	@RequestMapping(value = "/modifyName")
	@ResponseBody
	public int modifyName(String reName, Integer tidx) throws Exception {
		MemberVO vo = service.selectOneMember(tidx);
		vo.setT_name(reName);
		return service.modifyName(vo);
	}
	@RequestMapping(value = "/modifyPosition")
	@ResponseBody
	public int modifyPosition(String rePosition, Integer tidx) throws Exception {
		MemberVO vo = service.selectOneMember(tidx);
		vo.setT_position(rePosition);
		return service.modifyPosition(vo);
	}
	@RequestMapping(value = "/modifyDepartment")
	@ResponseBody
	public int modifyDepartment(String reDepartment, Integer tidx) throws Exception {
		MemberVO vo = service.selectOneMember(tidx);
		vo.setT_department(reDepartment);
		return service.modifyDepartment(vo);
	}
	@RequestMapping(value="/memberlist")
	public String selectAllMember(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,Locale locale, Model model) throws Exception {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(searchCriteria);
		pageMaker.setTotalCount(service.totalCountsearchMember(searchCriteria));
		model.addAttribute("memberList",service.searchMemberList(searchCriteria));
		model.addAttribute("pageMaker",pageMaker);
		return "/admin/list";
	}
	@RequestMapping(value = "/findAdmin")
	public String findAdmin(Model model)throws Exception{
		
		return "";
	}
	//ajax test
	@RequestMapping(value="/test")
	@ResponseBody
	public Object testAdmin(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,Locale locale, Model model) throws Exception {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(searchCriteria);
		pageMaker.setTotalCount(service.totalCountsearchMember(searchCriteria));
		List<MemberVO> mvo = service.searchMemberList(searchCriteria);
		return mvo;
	}
}
