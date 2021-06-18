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

import tobe.project.dto.LoginDTO;
import tobe.project.dto.MemberDTO;
import tobe.project.dto.MemberVO;
import tobe.project.service.MemberFileService;
import tobe.project.service.MemberService;

@Controller
@RequestMapping(value = "/member")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Inject
	private MemberService service;
	@Inject
	private MemberFileService fileService;
	
	//06-15 시큐리티
	@Inject
	BCryptPasswordEncoder pwdEncoder;
	
	@RequestMapping(value = "/list")
	public String selectListMember(Locale locale, Model model) throws Exception {
		System.out.println("MemberController");
		//List<FileVO> selectAllFile = fileService.selectAllFile();
		//List<MemberVO> selectAllMember = service.selectAllMember();
		//model.addAttribute("fileList",selectAllFile);
		//model.addAttribute("selectAllMember",selectAllMember);
		List<MemberDTO> selectAllMember = service.selectAllMember2();
		model.addAttribute("selectAllMember",selectAllMember);
		return "/member/list";
	}
	@RequestMapping(value = "/buseolist")
	@ResponseBody
	public Object searchDepartmentMember(Locale locale, Model model, String t_department) throws Exception {
		if(t_department.equals("all")) {
			//List<MemberVO> searchDepartmentMember = service.selectAllMember();
			List<MemberDTO> searchDepartmentMember = service.selectAllMember2();
			model.addAttribute("searchDepartmentMember",searchDepartmentMember);
			return searchDepartmentMember;
		}
		//List<MemberVO> searchDepartmentMember = service.searchDepartmentMember(t_department);
		List<MemberDTO> searchDepartmentMember = service.searchDepartmentMember(t_department);
		model.addAttribute("searchDepartmentMember",searchDepartmentMember);
		return searchDepartmentMember;
	}
	@RequestMapping(value = "/saoneinfo")
	@ResponseBody
	public Object selectOneMember(Locale locale, Model model, int tidx) throws Exception {
		//MemberVO saoneInfo = service.selectOneMemberIdx(tidx);
		MemberDTO saoneInfo = service.selectOneMemberIdx(tidx);
		model.addAttribute("saoneinfo",saoneInfo);
		return saoneInfo;
	}
	@RequestMapping(value = "/insertSaone")
	@ResponseBody
	public Object addMember(Locale locale, Model model, int tidx) throws Exception {
		//MemberVO saoneInfo = service.selectOneMemberIdx(tidx);
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
	//----------------------가람 시작!
	
	//로그인
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public void loginGET(@ModelAttribute("dto") LoginDTO dto) {
	}
	@RequestMapping(value="/loginPost", method = RequestMethod.POST)
	public String loginPost(LoginDTO dto,HttpServletRequest request, Model model) throws Exception{
		MemberVO vo = service.login(dto);
		if(vo!=null) {
			boolean check = BCrypt.checkpw(dto.getT_pwd(), vo.getT_pwd());
			if(check) {	//	"1234" , "$2a$10$NuKJxnN.O7W0xvhFZZedMeFPqZtmwYVOWABefqex62oIQv3ftbOyi"
				model.addAttribute("member",vo);
				System.out.println("로그인 성공");
				return "/main/main";
			}
			return "/member/login";
		}else {
			System.out.println("비밀번호 오류");
			return "/member/login";
		}
	}
	
	//비밀번호 찾기
	@RequestMapping(value="/findPwd", method = RequestMethod.GET)
	public String findPwdGET() throws Exception{
		return "/member/findPwd";
	}
	@RequestMapping(value="/findPwd", method = RequestMethod.POST)
	public String findPwdPOST(@ModelAttribute MemberVO vo, HttpServletResponse response) throws Exception{
		service.findPwd(response, vo);
		return "/member/findPwd";
	}
	
	//사원정보페이지
	@RequestMapping(value="/mypage") 
	public String mypage(Model model, String t_id,HttpSession session) throws Exception{ 
		model.addAttribute("member", service.selectOneMember(t_id));
		logger.info("mypage:"+ t_id);
		return "/member/mypage"; 
	}
	
	//사원정보 수정처리
	@RequestMapping(value="/modifyMember", method = RequestMethod.POST)
	public String modifyMember(@ModelAttribute MemberVO vo,HttpSession session,Model model) throws Exception{	
		MemberVO ex = service.selectOneMember(vo.getT_id());
		System.out.println("vo.getT_pwd>>"+vo.getT_pwd());
		if(vo.getT_pwd() == "" || vo.getT_pwd() == null) {
			vo.setT_pwd(ex.getT_pwd());
		}else {
			String repwd = pwdEncoder.encode(vo.getT_pwd());
			vo.setT_pwd(repwd);
			System.out.println("repwd>>"+repwd);
		}
		service.modifyMember(vo);
		model.addAttribute("member", service.selectOneMember(vo.getT_id()));
		return "/main/main";  
	}
	//----------------------------------------------------------------//
}
