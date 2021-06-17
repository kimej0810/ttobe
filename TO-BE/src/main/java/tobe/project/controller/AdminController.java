package tobe.project.controller;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import tobe.project.domain.PageMaker;
import tobe.project.domain.SearchCriteria;
import tobe.project.dto.EmailVO;
import tobe.project.dto.FileVO;
import tobe.project.dto.MemberVO;
import tobe.project.service.AdminService;
import tobe.project.service.EmailService;
import tobe.project.service.MemberFileService;
import tobe.project.service.MemberService;
import tobe.project.util.MediaUtils;
import tobe.project.util.UploadFileUtils;

/**
 * Servlet implementation class mainController
 */

@Controller
@RequestMapping(value="/admin")
public class AdminController{
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Inject
	private AdminService service;
	
	@Inject
	private EmailService emailService;
	
	@Inject
	private MemberFileService fileService;
	
	@Inject
	private MemberService memberService;
	
	//06-15 시큐리티
	@Inject
	BCryptPasswordEncoder pwdEncoder;
	
	//파일 저장 기본 경로 bean 등록
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@RequestMapping(value="/add")
	public String addMember(Locale locale, Model model) throws Exception {
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
		}
		else if(length==1) {
			hipen = "-000";
		}
		model.addAttribute("tid",tid[0]+hipen+nextTid);
		return "/admin/add";
	}
	@RequestMapping(value="/add2")
	public String addMember2(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		return "/admin/add2";
	}

	/*
	 * @RequestMapping(value="/addAction") public String addMemberAction(Locale
	 * locale, Model model, MemberVO vo) throws Exception { service.addMember(vo);
	 * model.addAttribute("member",vo); System.out.println("가입완료"); return
	 * "redirect:/admin/list"; }
	 */
	//파일 업로드 테스트
	@RequestMapping(value="/addAction")
	public String addMemberAction(Locale locale, Model model, MemberVO vo,MultipartHttpServletRequest mpRequest) throws Exception {
		String tid = vo.getT_id();
		System.out.println("tid>>>>>>>>"+tid);
		String pwd = pwdEncoder.encode(tid);
		System.out.println("암호화된 비번"+pwd);
		vo.setT_pwd(pwd);
		service.addMember2(vo,mpRequest);
		System.out.println("가입완료");
		return "redirect:/admin/memberlist";
	}
	
	////////////////////파일테스트///////////////////////////////////////
	//업로드파일 https://cameldev.tistory.com/68
	@RequestMapping(value="/upload", produces = "text/pliain;charset=UTF-8")
	public ResponseEntity<String> uploadFile(MultipartFile file) throws Exception{
		logger.info("=================[ FILE UPLOAD ]=================");
		logger.info("ORIGINAL FILE NAME : "+file.getOriginalFilename());
		logger.info("FILE SIZE : "+ file.getSize());
		logger.info("CONTENT TYPE : "+file.getContentType());
		logger.info("=================[ FILE UPLOAD END ]=================");
		return new ResponseEntity<String>(UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(),file.getBytes()),HttpStatus.CREATED);
	}
	//업로드 파일 보여주기
	@RequestMapping(value = "/display")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception{
		//InputStream 바이트 단위로 데이터를 읽는다. 외부로부터 읽어 들이는 기능관련 클래스
		InputStream inputStream = null;
		ResponseEntity<byte[]> entity = null;
		logger.info("file name : "+fileName);
		try {
			//파일 확장자 추출
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			//이미지 파일 여부 확인, 이미지 파일일 경우 이미지 MINEType 지정
			MediaType mediaType = MediaUtils.getMediaType(formatName);
			//HttpHeaders 객체 생성
			HttpHeaders httpHeaders = new HttpHeaders();
			//실제 경로의 파일을 읽어들이고 InputStream 객체 생성
			inputStream = new FileInputStream(uploadPath+fileName);
			//이미지 파일일 경우
			if(mediaType != null) {
				httpHeaders.setContentType(mediaType);
				//이미지파일이 아닐 경우
			}else {
				//디렉토리+UUID 제거
				fileName = fileName.substring(fileName.indexOf("_")+1);
				//다운로트 MINE Type 지정
				httpHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				//한글이름의 파일 인코딩처리
				httpHeaders.add("Content-Disposition","attachment; filename=\""+new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+"\"");
			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(inputStream),httpHeaders,HttpStatus.CREATED);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}finally {
			inputStream.close();
		}
		return entity;
	}
	
	/////////////////////////////////////////////////////////////////////
	@RequestMapping(value="/info")
	public String selectOneMember(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,Locale locale, Model model,int tidx) throws Exception {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(searchCriteria);
		pageMaker.setTotalCount(service.totalCountsearchMember(searchCriteria));
		model.addAttribute("memberList",service.searchMemberList(searchCriteria));
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
	@RequestMapping(value="/modifyAction")
	public String modifyMemberAction(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,Locale locale, Model model,MemberVO vo) throws Exception {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(searchCriteria);
		pageMaker.setTotalCount(service.totalCountsearchMember(searchCriteria));
		model.addAttribute("memberList",service.searchMemberList(searchCriteria));
		model.addAttribute("pageMaker",pageMaker);
		service.modifyMember(vo);
		System.out.println("수정완료");
		return "redirect:/admin/list";
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
	//email
	@RequestMapping(value = "/emaillist")
	public String list(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria, Model model) throws Exception {
		logger.info("search list() caller..");
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(searchCriteria);
		pageMaker.setTotalCount(emailService.totalCountsearchEmail(searchCriteria));
		model.addAttribute("articles",emailService.searchEmailList(searchCriteria));
		model.addAttribute("pageMaker",pageMaker);
		return "/email/list";
	}
	@RequestMapping(value="/memberList")
	public String memberList(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,Locale locale, Model model) throws Exception{
		List<MemberVO> selectAllMember = memberService.selectAllMember();
		model.addAttribute("selectAllMember",selectAllMember);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(searchCriteria);
		pageMaker.setTotalCount(emailService.totalCountsearchEmail(searchCriteria));
		model.addAttribute("articles",emailService.searchEmailList(searchCriteria));
		model.addAttribute("pageMaker",pageMaker);
		return "/email/memberList";
	}
	@RequestMapping(value="/email")
	public String adminEmail(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,int tidx,Locale locale, Model model) throws Exception{
		MemberVO vo = service.selectOneMember(tidx);
		model.addAttribute("member",vo);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(searchCriteria);
		pageMaker.setTotalCount(emailService.totalCountsearchEmail(searchCriteria));
		model.addAttribute("articles",emailService.searchEmailList(searchCriteria));
		model.addAttribute("pageMaker",pageMaker);
		return "/email/email";
	}
	@RequestMapping(value="/emailAction")
	public String adminEmailAction(Locale locale, Model model,EmailVO evo) {
		try {
			System.out.println("받는사람"+evo.getM_addressee());
			System.out.println("제목"+evo.getM_title());
			System.out.println("내용"+evo.getM_content());
			emailService.sendEmail(evo);
			emailService.writeEmail(evo);
			model.addAttribute("message","발송완료");
		}catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("message","발송실패");
		}
		return "redirect:/admin/emaillist";
	}
	@RequestMapping(value="/emailread")
	public String emailRead(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,Locale locale, Model model,int midx) throws Exception {
		EmailVO evo = emailService.selectOneEmail(midx);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(searchCriteria);
		pageMaker.setTotalCount(emailService.totalCountsearchEmail(searchCriteria));
		model.addAttribute("articles",emailService.searchEmailList(searchCriteria));
		model.addAttribute("pageMaker",pageMaker);
		model.addAttribute("emailRead",evo);
		return "/email/read";
	}
	//test
	
	
}