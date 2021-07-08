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

import tobe.project.domain.PageMaker;
import tobe.project.domain.SearchCriteria;
import tobe.project.dto.LoginDTO;
import tobe.project.dto.MemberDTO;
import tobe.project.dto.MemberVO;
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
	BCryptPasswordEncoder pwdEncoder;
	
	@RequestMapping(value = "/list")
	public String selectListMember(Locale locale, Model model) throws Exception {
		List<MemberDTO> selectAllMember = service.selectAllMember2();
		model.addAttribute("selectAllMember",selectAllMember);
		return "/member/list";
	}
	@RequestMapping(value = "/buseolist")
	@ResponseBody
	public Object searchDepartmentMember(Locale locale, Model model, String t_department) throws Exception {
		if(t_department.equals("all")) {
			List<MemberDTO> searchDepartmentMember = service.selectAllMember2();
			model.addAttribute("searchDepartmentMember",searchDepartmentMember);
			return searchDepartmentMember;
		}
		List<MemberDTO> searchDepartmentMember = service.searchDepartmentMember(t_department);
		model.addAttribute("searchDepartmentMember",searchDepartmentMember);
		return searchDepartmentMember;
	}
	@RequestMapping(value = "/saoneinfo")
	@ResponseBody
	public Object selectOneMember(Locale locale, Model model, int tidx) throws Exception {
		MemberDTO saoneInfo = service.selectOneMemberIdx(tidx);
		model.addAttribute("saoneinfo",saoneInfo);
		return saoneInfo;
	}
	@RequestMapping(value = "/insertSaone")
	@ResponseBody
	public Object addMember(Locale locale, Model model, int tidx) throws Exception {
		MemberDTO saoneInfo = service.selectOneMemberIdx(tidx);
		model.addAttribute("saoneinfo",saoneInfo);
		return saoneInfo;
	}
	@RequestMapping(value = "/search")
	@ResponseBody
	public Object searchMember(Model model,MemberVO vo)throws Exception{
		String department = vo.getT_department();
		String name = vo.getT_name();
		String result[] = department.split("=");
		String department1 = result[1];
		System.out.println(department1);
		String result2[] = name.split("=");
		String name1 = result2[1];
		System.out.println(name1);
		if(department1.equals("all")) {
			List<MemberVO> searchMember = service.searchMember2(name1);
			model.addAttribute("searchMember",searchMember);
			return searchMember;
		}
		vo.setT_department(department1);
		vo.setT_name(name1);
		List<MemberVO> searchMember = service.searchMember(vo);
		model.addAttribute("searchMember",searchMember);
		return searchMember;
	}
	@RequestMapping(value="/logout")
	public String logout(Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		if(session!=null) {
			session.invalidate();
			return "/member/login";
		}
		return "";
	}
	@RequestMapping(value = "/myHome")
	public String myHome(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,Model model)throws Exception{
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(searchCriteria);
		pageMaker.setTotalCount(myService.totalCountEmail(searchCriteria));
		model.addAttribute("myEmail",myService.selectAllEmail(searchCriteria));
		model.addAttribute("pageMaker",pageMaker);
		PageMaker pageMaker2 = new PageMaker();
		pageMaker2.setCri(searchCriteria);
		pageMaker2.setTotalCount(myService.totalCountBoard(searchCriteria));
		model.addAttribute("myBoard",myService.selectAllBoard(searchCriteria));
		model.addAttribute("pagemaker2",pageMaker2);
		PageMaker pageMaker3 = new PageMaker();
		pageMaker3.setCri(searchCriteria);
		pageMaker3.setTotalCount(myService.totalCountLeave(searchCriteria));
		model.addAttribute("myLeave",myService.selectAllLeave(searchCriteria));
		model.addAttribute("pagemaker3",pageMaker3);
		PageMaker pageMaker4 = new PageMaker();
		pageMaker4.setCri(searchCriteria);
		pageMaker4.setTotalCount(myService.totalCountSchedule(searchCriteria));
		model.addAttribute("mySchedule",myService.selectAllSchedule(searchCriteria));
		model.addAttribute("pagemaker4",pageMaker4);
		
		
		
		//List<EmailDTO> emailList = myService.selectAllEmail(tidx);
		return "/member/myHome";
	}
	//로그인 페이지불러오기
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public void loginGET(@ModelAttribute("dto") LoginDTO dto) {
	}
	//로그인 처리
	@RequestMapping(value="/loginPost", method = RequestMethod.POST)
	public String loginPost(LoginDTO dto,HttpServletRequest request, Model model,HttpSession session) throws Exception{
		MemberDTO vo = service.login(dto); 
		if(vo!=null) {
			boolean check = BCrypt.checkpw(dto.getT_pwd(), vo.getT_pwd());
			if(check) {	//	"1234" , "$2a$10$NuKJxnN.O7W0xvhFZZedMeFPqZtmwYVOWABefqex62oIQv3ftbOyi"
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
			System.out.println("비밀번호 오류"); //비밀번호가 다를경우
			return "/member/checklogin"; 
		}else {
			model.addAttribute("idnull", "id_error");//아이디없음
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
		return "/main/main";  
	}
	
	//비밀번호변경 페이지
	@RequestMapping(value="/modifyPwd", method = RequestMethod.GET)
	public String modifyPwd(MemberVO vo,Model model) throws Exception{
		MemberVO ex = service.selectOneMember(vo.getT_id());
		model.addAttribute("member",ex);
		return "/member/modifyPwd";
	}

	//비밀번호변경
	@RequestMapping(value="/modifyPwdAction", method = RequestMethod.POST)
	
	public String modifyPwdAction(@ModelAttribute MemberVO vo,Model model) throws Exception{	
		MemberVO ex = service.selectOneMember(vo.getT_id());
		System.out.println("vo.getT_pwd>>"+vo.getT_pwd());
		/*if(vo.getT_pwd() == "" || vo.getT_pwd() == null) {
			vo.setT_pwd(ex.getT_pwd());
		}else {*/
			String repwd = pwdEncoder.encode(vo.getT_pwd());
			vo.setT_pwd(repwd);
			service.modifyPwd(vo);
			System.out.println("repwd>>"+repwd);
			return "/main/main";
		//}
		
	}
}
