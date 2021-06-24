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
import org.springframework.web.bind.annotation.ResponseBody;
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

	// 자료실 목록
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Locale locale, Model model, SearchCriteria scri, String searchType) throws Exception {
		
		System.out.println("searchType->"+searchType);
		System.out.println(scri.toString());
		
		List<DataLibraryVO> list = service.selectAllData(scri);
		model.addAttribute("");
		
		return "/data/dataList";
	}

	// 자료실 업로드
	@RequestMapping(value = "/transport")
	public String transport(DataLibraryVO vo, MultipartHttpServletRequest mpRequest) throws Exception {
		System.out.println("데이터 전송 테스트");

		System.out.println(vo.toString());
		service.addData(vo, mpRequest);
		return "redirect:/data/list";
	}

	@RequestMapping(value = "/fileDown")
	@ResponseBody
	public void fileDown(@RequestParam("didx") int didx, HttpServletResponse response) throws Exception {

		System.out.println(didx);
		List<Map<String, Object>> fileList = fileInfoService.selectAllFile("didx", didx);
		String storedFileName = (String) fileList.get(0).get("F_STORED_FILE_NAME");
		String originalFileName = (String) fileList.get(0).get("F_ORG_FILE_NAME");

		System.out.println("stored--->" + storedFileName);
		System.out.println("original--->" + originalFileName);

		byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:\\Users\\bakug\\ttobe\\TO-BE\\src\\main\\webapp\\resources\\static\\file\\"+storedFileName));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition",
				"attachment; fileName=\"" + URLEncoder.encode(originalFileName, "UTF-8") + "\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();

	}

}
