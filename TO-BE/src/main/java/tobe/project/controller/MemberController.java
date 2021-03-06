package tobe.project.controller;

import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.EmailDTO;
import tobe.project.dto.LoginDTO;
import tobe.project.dto.MemberDTO;
import tobe.project.dto.MemberVO;
import tobe.project.service.AdminService;
import tobe.project.service.EmailService;
import tobe.project.service.MemberService;
import tobe.project.service.MyService;

@Controller
@RequestMapping(value = "/member")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Inject
	private MemberService service;
	@Inject
	private MyService myService;
	@Inject
	private AdminService aService;
	@Inject
	private EmailService eService;
	@Inject
	BCryptPasswordEncoder pwdEncoder;
	
	@RequestMapping(value = "/list")
	public String selectListMember(Locale locale, Model model) throws Exception {
		logger.info("사원 리스트", locale);
		List<MemberDTO> selectAllMember = service.selectAllMember2();
		model.addAttribute("selectAllMember",selectAllMember);
		return "/member/list";
	}
	@RequestMapping(value = "/buseolist")
	@ResponseBody
	public Object searchDepartmentMember(Locale locale, Model model, String t_department,HttpServletRequest request) throws Exception {
		logger.info("부서별 사원리스트", locale);
		if(t_department!=null) {
			if(t_department.equals("all")) {
				List<MemberDTO> searchDepartmentMember = service.selectAllMember2();
				model.addAttribute("searchDepartmentMember",searchDepartmentMember);
				return searchDepartmentMember;
			}
			List<MemberDTO> searchDepartmentMember = service.searchDepartmentMember(t_department);
			model.addAttribute("searchDepartmentMember",searchDepartmentMember);
			return searchDepartmentMember;
		}
		return "<script>location.href='"+request.getContextPath()+"/member/login';</script>";
	}
	@RequestMapping(value = "/saoneinfo")
	@ResponseBody
	public Object selectOneMember(Locale locale, Model model, Integer tidx,HttpServletRequest request,HttpSession session) throws Exception {
		logger.info("사원 정보", locale);
		String check = (String)session.getAttribute("userId"); 
		if(check!=null){
			MemberDTO saoneInfo = service.selectOneMemberIdx(tidx);
			model.addAttribute("saoneinfo",saoneInfo);
			return saoneInfo;
		}
		return "<script>location.href='"+request.getContextPath()+"/member/login';</script>";
	}
	@RequestMapping(value = "/search")
	@ResponseBody
	public Object searchMember(Locale locale,Model model,MemberVO vo,HttpServletRequest request,HttpSession session)throws Exception{
		logger.info("사원 검색", locale);
		String check = (String)session.getAttribute("userId"); 
		if(check!=null){
			String department = vo.getT_department();
			String name = vo.getT_name();
			String result[] = department.split("=");
			String department1 = result[1];
			String result2[] = name.split("=");
			String name1 = result2[1];
			if(department1.equals("all")) {
				List<MemberDTO> searchMember = service.searchMember2(name1);
				model.addAttribute("searchMember",searchMember);
				return searchMember;
			}
			vo.setT_department(department1);
			vo.setT_name(name1);
			List<MemberDTO> searchMember = service.searchMember(vo);
			model.addAttribute("searchMember",searchMember);
			return searchMember;
		}
		return "<script>location.href='"+request.getContextPath()+"/member/login';</script>";
	}
	@RequestMapping(value="/logout")
	public String logout(Model model,HttpServletRequest request,Locale locale) {
		logger.info("로그아웃", locale);
		HttpSession session = request.getSession();
		if(session!=null) {
			session.invalidate();
			return "redirect:/member/login";
		}
		return "redirect:/member/login";
	}
	@RequestMapping(value = "/myHome")
	public String myHome(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,Model model,HttpSession session,Locale locale)throws Exception{
		logger.info("내 정보", locale);
		int tidx = 0;
		String check = (String)session.getAttribute("userId"); 
		if(check!=null){
			if(session.getAttribute("userTidx")!=null) {
				tidx = (int)session.getAttribute("userTidx");
			}
			MemberDTO dto = service.selectOneMemberIdx(tidx);
			model.addAttribute("member",dto);
			model.addAttribute("myEmail",myService.selectAllEmail(searchCriteria));
			model.addAttribute("myBoard",myService.selectAllBoard(searchCriteria));
			model.addAttribute("myLeave",myService.selectAllLeave(searchCriteria));
			model.addAttribute("mySchedule",myService.selectAllSchedule(searchCriteria));
			return "/member/myHome";
		}
		model.addAttribute("idnull","null");
		return "/member/checklogin";
	}
	@RequestMapping(value="/emailRead")
	public String emailRead(Model model,HttpSession session,EmailDTO dto,Locale locale) throws Exception {
		logger.info("메일 보기", locale);
		if(dto!=null) {
			EmailDTO reDto = eService.selectOneEmail(dto);
			model.addAttribute("emailRead",reDto);
			return "/member/emailRead";
		}
		model.addAttribute("idnull","null");
		return "/member/checklogin";
	}
	//로그인 페이지불러오기
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public void loginGET(@ModelAttribute("dto") LoginDTO dto,HttpSession session) throws Exception {
		int check = aService.adminCheck();
		session.setAttribute("admin", check);
	}
	//로그인 처리
	@RequestMapping(value="/loginPost", method = RequestMethod.POST)
	public String loginPost(LoginDTO dto,HttpServletRequest request, Model model,HttpSession session) throws Exception{
		MemberDTO vo = service.login(dto); 
		if(vo!=null) {
			boolean check = BCrypt.checkpw(dto.getT_pwd(), vo.getT_pwd());
			if(check) {	
				session.setAttribute("userName", vo.getT_name());
				session.setAttribute("userTidx", vo.getTidx());
				session.setAttribute("userId", vo.getT_id());
				session.setAttribute("userDep",vo.getT_department());
				session.setAttribute("userPosition", vo.getT_position());
				session.setAttribute("userGrade", vo.getT_grade());
				session.setAttribute("userProfile", vo.getF_stored_file_name());
				model.addAttribute("member",vo);
				System.out.println("로그인 성공");
				return "redirect:/main/mainPage";
			}
			model.addAttribute("idnull", "pw_error");
			System.out.println("비밀번호 오류"); //비밀번호 다름
			return "/member/checklogin"; 
		}else {
			model.addAttribute("idnull", "id_error"); //아이디없음
			return "/member/checklogin";
		}
	}
	
	//비밀번호찾기 페이지불러오기
	@RequestMapping(value="/findPwd", method = RequestMethod.GET)
	public String findPwdGET() throws Exception{
		return "/member/findPwd";
	}
	//비밀번호찾기 처리
	@RequestMapping(value="/findPwd", method = RequestMethod.POST)
	public String findPwdPOST(@ModelAttribute MemberVO vo, HttpServletResponse response) throws Exception{
		service.findPwd(response, vo);
		return "/member/findPwd";
	}
	
	//사원정보 페이지불러오기
	@RequestMapping(value="/mypage") 
	public String mypage(Model model, int tidx,HttpSession session) throws Exception{ 
		MemberDTO selectAllMember = service.selectOneMemberIdx(tidx);
		model.addAttribute("member",selectAllMember);
		logger.info("mypage:"+ tidx);
		return "/member/mypage"; 
	}
	 
	//사원정보 수정처리
	@RequestMapping(value="/modifyMember", method = RequestMethod.POST)
	public String modifyMember(@ModelAttribute MemberVO vo,HttpSession session,Model model, MultipartHttpServletRequest mpRequest) throws Exception{	
		
		service.modifyMember(vo, mpRequest);
		model.addAttribute("member", service.selectOneMember(vo.getT_id()));
		return "redirect:/main/mainPage";  
	}
	
	//비밀번호변경 페이지
	@RequestMapping(value="/modifyPwd", method = RequestMethod.GET)
	public String modifyPwd(MemberVO vo,Model model) throws Exception{
		MemberDTO ex = service.selectOneMember(vo.getT_id());
		model.addAttribute("member",ex);
		return "/member/modifyPwd";
	}

	//비밀번호변경
	@RequestMapping(value="/modifyPwdAction", method = RequestMethod.POST)
	public String modifyPwdAction(@ModelAttribute MemberVO vo,Model model) throws Exception{	
		MemberDTO ex = service.selectOneMember(vo.getT_id());
		System.out.println("vo.getT_pwd>>"+vo.getT_pwd());
		if(vo.getT_pwd() == "" || vo.getT_pwd() == null) {
			vo.setT_pwd(ex.getT_pwd());
		}else {
			String repwd = pwdEncoder.encode(vo.getT_pwd());
			vo.setT_pwd(repwd);
			service.modifyPwd(vo);
			System.out.println("repwd>>"+repwd);
			
		}
		return "redirect:/main/mainPage";
	}
}
