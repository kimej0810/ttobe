package tobe.project.controller;

import java.io.FileReader;
import java.util.Calendar;
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
	
	//硫��명���댁�
	@RequestMapping(value = "/mainPage")
	public String list(Locale locale, Model model,HttpServletRequest request) throws Exception {
		System.out.println("�� 硫��� 而⑦�몃·�щ��!");
		
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		
		//�ㅻ���� 紐���
		JSONParser parser = new JSONParser();
		String path = request.getSession().getServletContext().getRealPath("/resources/static/data/");
		String path2 = "maxim.json";
		String resultPath = path+path2;
		JSONArray jsonArray = (JSONArray)parser.parse(new FileReader(resultPath));
		
		
		int size = jsonArray.size();
		System.out.println("size-------------->"+size); //52
		
		int random = (int)(Math.random()*52); //0~51 ��������
		JSONObject jsonObject = (JSONObject)jsonArray.get(random);
				
		String author = (String) jsonObject.get("author");
		String message = (String) jsonObject.get("message");
		
		System.out.println("author->"+author);
		System.out.println("message->"+message);
		
		
		//����寃곗��
		SearchCriteria scri = new SearchCriteria();
		scri.setPage(1);
		scri.setPerPageNum(10);
		scri.setSearchType("");
		
		List<ApprovalVO> approvalList = approvalService.selectAllApprovalDocumentList(scri);
		
		System.out.println("전자결재석고대죄인조인간달프라이머리키위->"+approvalList.get(0).getE_textTitle());
		
		
		List<BoardVO> boardList = boardService.selectNotice();
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("author", author);
		model.addAttribute("message", message);
		model.addAttribute("boardList", boardList);
		model.addAttribute("approvalList", approvalList);
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
