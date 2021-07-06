package tobe.project.controller;

import java.io.FileReader;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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

	// 硫��명���댁�
	@RequestMapping(value = "/mainPage")
	public String list(Locale locale, Model model, HttpServletRequest request, @RequestParam Map<String, String> param) throws Exception {
		System.out.println("~~~~~~~메인 컨트롤러~~~~~~");
		
		List<BoardVO> boardList;
		Map<String, String> search = new HashMap<String, String>();
		String search1 = "";
		String search2 = "";

		Calendar cal = Calendar.getInstance();
		int year = cal.get(cal.YEAR);
		int month = cal.get(cal.MONTH);
		
		if(param.get("year")!=null) { //파라미터로 달력 값을 받음
			int paramYear = Integer.parseInt(param.get("year"));
			int paramMonth = Integer.parseInt(param.get("month"));
			cal.set(paramYear, paramMonth-1, 1);
			int maxDay = cal.getActualMaximum(cal.DAY_OF_MONTH);
			
			if((paramMonth/10)<1) {
				search1 = paramYear+"/"+"0"+paramMonth+"/01";
				search2 = paramYear+"/"+"0"+paramMonth+"/"+maxDay;
				
			}else { 
				search1 = paramYear+"/"+paramMonth+"/01";
				search2 = paramYear+"/"+paramMonth+"/"+maxDay;
			}
			search.put("search1", search1);
			search.put("search2", search2);
			boardList = boardService.selectNotice(search);
		}else { //파라미터로 달력 값을 못받음
			int maxDay = cal.getActualMaximum(cal.DAY_OF_MONTH);
			if((month/10)<1) {
				search1 = year+"/"+"0"+(month+1)+"/01";
				search2 = year+"/"+"0"+(month+1)+"/"+maxDay;
				
			}else { 
				search1 = year+"/"+(month+1)+"/01";
				search2 = year+"/"+(month+1)+"/"+maxDay;
			}
			
			search.put("search1", search1);
			search.put("search2", search2);
			boardList = boardService.selectNotice(search);
		}
		
		
		// 오늘의명언
		JSONParser parser = new JSONParser();
		String path = request.getSession().getServletContext().getRealPath("/resources/static/data/");
		String path2 = "maxim.json";
		String resultPath = path + path2;
		JSONArray jsonArray = (JSONArray) parser.parse(new FileReader(resultPath));

		int size = jsonArray.size();
		System.out.println("size-------------->" + size); // 52

		int random = (int) (Math.random() * 52); // 0~51 ��������
		JSONObject jsonObject = (JSONObject) jsonArray.get(random);

		String author = (String) jsonObject.get("author");
		String message = (String) jsonObject.get("message");

		System.out.println("author->" + author);
		System.out.println("message->" + message);

		// 전자결재 다섯개만 뽑아옴
		SearchCriteria scri = new SearchCriteria();
		scri.setPage(1);
		scri.setPerPageNum(5);
		scri.setSearchType("");
		List<ApprovalVO> approvalList = approvalService.selectAllApprovalDocumentList(scri);
		
		// 넘겨주자
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("author", author);
		model.addAttribute("message", message);
		model.addAttribute("boardList", boardList);
		model.addAttribute("approvalList", approvalList);
		return "/main/realMain";
	}

	// 전자결재 버튼 눌렸을때 오는곳
	@RequestMapping(value = "/approval", produces = "application/json; charset=utf8")
	@ResponseBody
	public List<ApprovalVO> approval(@RequestParam Map<String, String> param) throws Exception {

		String state = param.get("state");

		System.out.println("전자결재 상태를 말해라~~~~~~~~"+state);
		
		SearchCriteria scri = new SearchCriteria();
		scri.setPage(1);
		scri.setPerPageNum(5);
		
		if(state.equals("wating")) {
			scri.setSearchType("결재대기");
		}else if(state.equals("progress")) {
			scri.setSearchType("결재진행");
		}else if(state.equals("completed")) {
			scri.setSearchType("결재완료");
		}else {
			scri.setSearchType("");
		}
		
		List<ApprovalVO> approvalList = approvalService.selectAllApprovalDocumentList(scri);
		return approvalList;
	}

	// 달력인데 쓸지 안쓸지 모르겠음
	@RequestMapping(value = "/calendar")
	public String writeReply(@RequestParam Map<String, String> param, Model model) throws Exception {

		int year = Integer.parseInt(param.get("year"));
		int month = Integer.parseInt(param.get("month"));
		String function = param.get("function");

		if (function.equals("yearMinus")) {
			year--;
		} else if (function.equals("monthMinus")) {
			if (month == 0) {
				month = 12;
			} else {
				month--;
			}
		} else if (function.equals("yearPlus")) {
			year++;
		} else {
			if (month == 12) {
				month = 1;
			} else {
				month++;
			}
		}

		System.out.println("year-------------->" + year);
		System.out.println("month-------------->" + month);
		System.out.println("function-------------->" + function);

		model.addAttribute("year", year);
		model.addAttribute("month", month);

		return "redirect:/board/list";
	}
}
