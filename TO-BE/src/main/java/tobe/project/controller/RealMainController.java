package tobe.project.controller;

import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServlet;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.BoardVO;
import tobe.project.service.BoardService;

@Controller
@RequestMapping(value = "/main")
public class RealMainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	@Inject
	private BoardService boardService;
	
	//메인불러옴
	@RequestMapping(value = "/mainPage")
	public String list(Locale locale, Model model, SearchCriteria scri, String searchType) throws Exception {
		System.out.println("와 메인페이지다!");
		
		List<BoardVO> boardList = boardService.selectNotice();
		model.addAttribute("boardList", boardList);
		return "/main/realMain";
	}
}
