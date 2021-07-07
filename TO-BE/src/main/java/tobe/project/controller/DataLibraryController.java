package tobe.project.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import tobe.project.domain.PageMaker;
import tobe.project.domain.SearchCriteria;
import tobe.project.dto.DataLibraryVO;
import tobe.project.service.DataLibraryService;
import tobe.project.service.FileInfoService;

@Controller
@RequestMapping(value = "/data")
public class DataLibraryController extends HttpServlet {

	@Inject
	DataLibraryService service;

	@Inject
	FileInfoService fileInfoService;


	//자료실 출력
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Locale locale, Model model, SearchCriteria scri, String searchType) throws Exception {
		
		System.out.println("searchType->"+searchType);
		System.out.println(scri.toString());
		
		List<DataLibraryVO> list = service.selectAllData(scri);
		
		for(int i=0; i<list.size(); i++) {
			System.out.println(list.get(i).getD_title());
		}
		
		model.addAttribute("dataList", list);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.dataCount(scri));
		
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("scri", scri);
		
		return "/data/dataList";
	}

	//데이터 추가
	@RequestMapping(value = "/transport")
	public String transport(DataLibraryVO vo, MultipartHttpServletRequest mpRequest) throws Exception {
		System.out.println("데이터 추가");

		System.out.println(vo.toString());
		service.addData(vo, mpRequest);
		return "redirect:/data/list";
	}
	
	//데이터 삭제
		@RequestMapping(value = "/transport")
		public String delete(@RequestParam Map<String, String> param) throws Exception {
			//didx릁 통해 파일 삭제
			
			String didx = param.get("didx");
			System.out.println("~~~~~~~~~didx에용~~~~~~~~`"+didx);
			
			return "redirect:/data/list";
		}

	//데이터 다운로드
	@RequestMapping(value = "/fileDown")
	@ResponseBody
	public String fileDown(@RequestParam("didx") int didx, HttpServletResponse response, HttpServletRequest request) throws Exception {

		System.out.println(didx);
		//다운로드수 증가
		service.hitData(didx);
		
		try {
			List<Map<String, Object>> fileList = fileInfoService.selectAllFile("didx", didx);
			String storedFileName = (String) fileList.get(0).get("F_STORED_FILE_NAME");
			String originalFileName = (String) fileList.get(0).get("F_ORG_FILE_NAME");
			
			System.out.println("stored--->" + storedFileName);
			System.out.println("original--->" + originalFileName);
			String filePath = request.getSession().getServletContext().getRealPath("/resources/static/file/");
			
			System.out.println("경로좀보자~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"+filePath);
			
			File f = new File(filePath+storedFileName);
			
			byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File(filePath+storedFileName));
			
			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition",
					"attachment; fileName=\"" + URLEncoder.encode(originalFileName, "UTF-8") + "\";");
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();
			
		}catch(Exception e){
			System.out.println("파일이 없는데요");
		}
		
		return "redirect:/data/list";
	}

}
