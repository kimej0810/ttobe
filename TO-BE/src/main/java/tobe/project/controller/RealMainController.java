package tobe.project.controller;

import java.io.FileReader;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServlet;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
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
	
	//硫붿씤遺덈윭�샂
	@RequestMapping(value = "/mainPage")
	public String list(Locale locale, Model model, SearchCriteria scri, String searchType) throws Exception {
		System.out.println("�� 硫붿씤�럹�씠吏��떎!");
		
		//�떖�젰 
		Calendar now = Calendar.getInstance(); //�슫�쁺泥댁젣�쓽 TimeZone�쓣 湲곗�
		
		int year = now.get(Calendar.YEAR);
		int month = now.get(Calendar.MONDAY)+1;
		int day = now.get(Calendar.DAY_OF_MONTH);
		int week = now.get(Calendar.DAY_OF_WEEK);
		int lastDay = now.getActualMaximum(Calendar.DATE);

		System.out.println("year->"+year);
		System.out.println("month->"+month);
		System.out.println("day->"+day);
		System.out.println("week->"+week);
		System.out.println("lastDay->"+lastDay);
		
	
		
		//�삤�뒛�쓽 紐낆뼵
		JSONParser parser = new JSONParser();
		//JSONArray jsonArray = (JSONArray)parser.parse(new FileReader("C:\\Users\\bakug\\git\\ttobe\\TO-BE\\src\\main\\webapp\\resources\\static\\data\\maxim.json"));
		JSONArray jsonArray = (JSONArray)parser.parse(new FileReader("C:\\Users\\750\\git\\ttobe\\TO-BE\\src\\main\\webapp\\resources\\static\\data\\maxim.json"));
		int random = (int)(Math.random()*600-6);
		JSONObject jsonObject = (JSONObject)jsonArray.get(random);
				
		String author = (String) jsonObject.get("author");
		String message = (String) jsonObject.get("message");
		
		System.out.println("author->"+author);
		System.out.println("message->"+message);
		
		
		List<BoardVO> boardList = boardService.selectNotice();
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("day", day);
		model.addAttribute("week", week);
		model.addAttribute("lastDay", lastDay);
		model.addAttribute("author", author);
		model.addAttribute("message", message);
		model.addAttribute("boardList", boardList);
		return "/main/realMain";
	}
}
