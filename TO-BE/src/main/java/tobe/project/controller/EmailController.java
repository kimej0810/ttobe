package tobe.project.controller;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import tobe.project.domain.PageMaker;
import tobe.project.domain.SearchCriteria;
import tobe.project.dto.EmailDTO;
import tobe.project.dto.MemberDTO;
import tobe.project.dto.MemberVO;
import tobe.project.service.AdminService;
import tobe.project.service.EmailService;
import tobe.project.service.MemberService;
@Controller
@RequestMapping(value="/email")
public class EmailController{
	private static final Logger logger = LoggerFactory.getLogger(EmailController.class);
	@Inject
	private EmailService emailService;
	@Inject
	private AdminService service;
	@Inject
	private MemberService memberService;
	
	@RequestMapping(value = "/list")
	public String list(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria, Model model,Locale locale) throws Exception {
		logger.info("메일 리스트", locale);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(searchCriteria);
		pageMaker.setTotalCount(emailService.totalCountsearchEmail(searchCriteria));
		model.addAttribute("articles",emailService.searchEmailList(searchCriteria));
		model.addAttribute("pageMaker",pageMaker);
		return "/email/list";
	}
	@RequestMapping(value="/email")
	public String adminEmail(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,Integer tidx,Locale locale, Model model) throws Exception{
		logger.info("메일작성페이지", locale);
		if(tidx!=null) {
			MemberVO vo = service.selectOneMember(tidx);
			model.addAttribute("member",vo);
		}
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(searchCriteria);
		pageMaker.setTotalCount(emailService.totalCountsearchEmail(searchCriteria));
		model.addAttribute("articles",emailService.searchEmailList(searchCriteria));
		model.addAttribute("pageMaker",pageMaker);
		return "/email/email";
	}
	@RequestMapping(value="/emailAction")
	public String adminEmailAction(Locale locale, Model model,EmailDTO evo) {
		logger.info("메일전송처리", locale);
		try {
			if(evo.getTidx()==0) {
				int tidx = emailService.searchMember(evo);
				EmailDTO rto = evo;
				rto.setTidx(tidx);
				emailService.sendEmail(rto);
				emailService.writeEmail(rto);
			}else {
				emailService.sendEmail(evo);
				emailService.writeEmail(evo);
			}
			model.addAttribute("message","발송완료");
		}catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("message","발송실패");
		}
		return "redirect:/email/list";
	}
	@RequestMapping(value="/read")
	public String emailRead(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,Locale locale, Model model,EmailDTO dto) throws Exception {
		logger.info("메일 읽기", locale);
		EmailDTO evo = emailService.selectOneEmail(dto);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(searchCriteria);
		pageMaker.setTotalCount(emailService.totalCountsearchEmail(searchCriteria));
		model.addAttribute("articles",emailService.searchEmailList(searchCriteria));
		model.addAttribute("pageMaker",pageMaker);
		model.addAttribute("emailRead",evo);
		return "/email/read";
	}
	@RequestMapping(value="/delete")
	@ResponseBody
	public Object emailDelete(@RequestParam(value="eidxList")String eidxList,Locale locale,HttpServletRequest request) throws Exception {
		logger.info("메일 삭제", locale);
		if(eidxList!=null) {
			String[] eidx = eidxList.split(",");
			if(eidx.length>0) {
				for(int i=0;i<eidx.length;i++) {
					int result = Integer.parseInt(eidx[i]);
					emailService.deleteEmail(result);
				}
				return 1;
			}
		}
		return "<script>location.href='"+request.getContextPath()+"/member/login';</script>";
	}
	@RequestMapping(value="/memberList")
	public String memberList(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,Locale locale, Model model) throws Exception{
		logger.info("사원 리스트", locale);
		List<MemberDTO> selectAllMember = memberService.selectAllMember2();
		model.addAttribute("selectAllMember",selectAllMember);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(searchCriteria);
		pageMaker.setTotalCount(emailService.totalCountsearchEmail(searchCriteria));
		model.addAttribute("articles",emailService.searchEmailList(searchCriteria));
		model.addAttribute("pageMaker",pageMaker);
		return "/email/memberList";
	}
}
