package tobe.project.controller;

import java.io.FileReader;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServlet;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.ApprovalVO;
import tobe.project.dto.BoardVO;
import tobe.project.service.ApprovalService;
import tobe.project.service.BoardService;

@Controller
@RequestMapping(value = "/main")
public class RealMainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	@Inject
	private BoardService boardService;
	
	@Inject
	private ApprovalService approvalService;
	
	//메인페이지
	@RequestMapping(value = "/mainPage")
	public String list(Locale locale, Model model) throws Exception {
		System.out.println("와 메인 컨트롤러다!");
		
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		
		//오늘의 명언
		JSONParser parser = new JSONParser();
		JSONArray jsonArray = (JSONArray)parser.parse(new FileReader("C:\\Users\\bakug\\git\\ttobe\\TO-BE\\src\\main\\webapp\\resources\\static\\data\\maxim.json"));
		//JSONArray jsonArray = (JSONArray)parser.parse(new FileReader("C:\\Users\\750\\git\\ttobe\\TO-BE\\src\\main\\webapp\\resources\\static\\data\\maxim.json"));
		//JSONArray jsonArray = (JSONArray)parser.parse(new FileReader("D:\\kio\\git\\ttobe\\TO-BE\\src\\main\\webapp\\resources\\static\\data\\maxim.json"));
		//JSONArray jsonArray = (JSONArray)parser.parse(new FileReader("C:\\Users\\767\\git\\ttobe\\TO-BE\\src\\main\\webapp\\resources\\static\\data\\maxim.json")); 륜광
		
		
		int size = jsonArray.size();
		System.out.println("size-------------->"+size); //52
		
		int random = (int)(Math.random()*52); //0~51 난수생성
		JSONObject jsonObject = (JSONObject)jsonArray.get(random);
				
		String author = (String) jsonObject.get("author");
		String message = (String) jsonObject.get("message");
		
		System.out.println("author->"+author);
		System.out.println("message->"+message);
		
		
		//전자결제
		SearchCriteria scri = new SearchCriteria();
		scri.setPage(10);
		List<ApprovalVO> alist = approvalService.selectAllApprovalDocumentList(scri);
		
		
		
		List<BoardVO> boardList = boardService.selectNotice();
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("author", author);
		model.addAttribute("message", message);
		model.addAttribute("boardList", boardList);
		return "/main/realMain";
	}
	
	@RequestMapping(value = "/calendar")
	public String writeReply(@RequestParam Map<String, String> param, Model model) throws Exception {

		int year = Integer.parseInt(param.get("year"));
		int month = Integer.parseInt(param.get("month"));
		String function = param.get("function");
		
		if(function.equals("yearMinus")) {
			year--;
		}else if(function.equals("monthMinus")){
			if(month==0) {
				month=12;
			}else {
				month--;
			}
		}else if(function.equals("yearPlus")) {
			year++;
		}else {
			if(month==12) {
				month=1;
			}else {
				month++;
			}
		}
		
		System.out.println("year-------------->"+year);
		System.out.println("month-------------->"+month);
		System.out.println("function-------------->"+function);
		
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		
	    return "redirect:/board/list";
	}
}