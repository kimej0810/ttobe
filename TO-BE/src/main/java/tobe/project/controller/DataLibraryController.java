package tobe.project.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
	
	//자료실 목록 
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Locale locale, Model model, SearchCriteria scri, String searchType) throws Exception {
		
		model.addAttribute("dataList", service.selectAllData());
		
		return "/data/dataList";
	}
	
	//자료실 업로드
	@RequestMapping(value = "/transport")
	public String transport(DataLibraryVO vo, MultipartHttpServletRequest mpRequest) throws Exception {
		 System.out.println("데이터 전송 테스트");
		 
		 System.out.println(vo.toString());
		 service.addData(vo, mpRequest);
		 return "redirect:/data/dataListss";
	}
	
	//첨부파일 다운로드 테스트
	@RequestMapping(value = "/download")
	public void fileDown(@RequestParam(value="valArray[]") List<String> valArray, HttpServletResponse response) throws Exception {
		System.out.println("---------------------------------");
		for(int i=0; i<valArray.size(); i++) {
			System.out.println(valArray.get(i));
		}
		System.out.println("---------------------------------");
		
		List<Map<String, Object>> tidxList = fileInfoService.selectAllFile("didx", Integer.parseInt(valArray.get(0)));
		String storedFileName = (String) tidxList.get(0).get("F_STORED_FILE_NAME");
		String originalFileName = (String) tidxList.get(0).get("F_ORG_FILE_NAME");
		
		System.out.println("storedFileName->"+storedFileName+" originalFileName->"+originalFileName);
		
		byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:\\git\\ttobe\\TO-BE\\src\\main\\webapp\\resources\\static\\file\\"+storedFileName));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\""+URLEncoder.encode(originalFileName, "UTF-8")+"\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}	
	
	
}
