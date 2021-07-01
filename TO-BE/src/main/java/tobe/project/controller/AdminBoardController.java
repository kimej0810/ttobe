package tobe.project.controller;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import tobe.project.domain.PageMaker;
import tobe.project.domain.SearchCriteria;
import tobe.project.dto.BoardVO;
import tobe.project.service.BoardService;
import tobe.project.service.MemberService;
@Controller
@RequestMapping(value="/admin/board")
public class AdminBoardController{
	private static final Logger logger = LoggerFactory.getLogger(AdminBoardController.class);
	
	@Inject
	private MemberService memberService;
	@Inject
	private BoardService bService;
	
	@RequestMapping(value="/list")
	public String deleteMember(Locale locale, Model model, SearchCriteria scri, String searchType,HttpSession session)throws Exception{
		Integer tidx = (Integer) session.getAttribute("userTidx");
		String grade = (String) session.getAttribute("userGrade");
		List<BoardVO> list = bService.selectAllBoard(scri);
		model.addAttribute("boardList", list);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(bService.totalCount(scri));
		
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("scri", scri);
		model.addAttribute("flag", searchType);
		return "/adminBoard/boardList";
	}
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String write(Locale locale, Model model) throws Exception {
		 return "/adminBoard/boardWrite";
	}
	@RequestMapping(value = "/writeAction")
	public String writeAction(BoardVO vo, MultipartHttpServletRequest mpRequest,HttpSession session) throws Exception {
		String grade = (String) session.getAttribute("userGrade");
		if(grade.equals("A")) {
			vo.setB_type("n");
		}
		bService.writeBoard(vo, mpRequest);
		return "redirect:/admin/board/list";
	}
}