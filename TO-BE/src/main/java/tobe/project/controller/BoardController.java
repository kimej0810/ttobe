package tobe.project.controller;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import tobe.project.domain.PageMaker;
import tobe.project.domain.SearchCriteria;
import tobe.project.dto.BoardVO;
import tobe.project.dto.ReplyVO;
import tobe.project.service.BoardService;
import tobe.project.service.FileInfoService;
import tobe.project.service.ReplyService;

@Controller
@RequestMapping(value = "/board")
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Inject
	private BoardService service;

	@Inject
	private ReplyService replyService;

	@Inject
	private FileInfoService fileInfoService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Locale locale, Model model, SearchCriteria scri) throws Exception {
		logger.info("BoardList");

		List<BoardVO> list;

		String keyword = scri.getKeyword();
		String searchType = scri.getSearchType();
		
		if(scri.getRowStartBoard()!=0) {
			scri.setPageNumBoard(7);
		}else {
			scri.setPageNumBoard(8);
		}

		if ((keyword == "" || keyword == null) && (searchType == "" || searchType == null)) {
			list = service.selectAllBoard(scri);
		} else if ((searchType == "w" || searchType == "t" || searchType == "c")
				&& (keyword == "" || keyword == null)) {
			list = service.selectAllBoard(scri);
		} else {
			list = service.selectSearch(scri);
		}
		model.addAttribute("boardList", list);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.totalCount(scri));

		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("scri", scri);
		model.addAttribute("flag", searchType);
		return "/board/boardList";
	}

	@RequestMapping(value = "/listSearch", method = RequestMethod.GET)
	public List<BoardVO> listSearch(Locale locale, SearchCriteria scri, String searchType) throws Exception {

		List<BoardVO> list = service.selectSearch(scri);
		return list;

	}

	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(int bidx, @ModelAttribute("scri") SearchCriteria scri, Model model, String pagePort)
			throws Exception {
		logger.info("BoardWrite");

		BoardVO vo = service.selectOneBoard(bidx);
		vo.setB_content(vo.getB_content().replace("\r\n", "<br>"));
		model.addAttribute("boardVO", vo);
		model.addAttribute("scri", scri);

		List<ReplyVO> replyList = replyService.listReply(vo.getBidx());
		model.addAttribute("replyList", replyList);

		List<Map<String, Object>> fileList = fileInfoService.selectAllFile("bidx", bidx);
		model.addAttribute("file", fileList);

		model.addAttribute("pagePort", pagePort);
		if (pagePort.equals("board")) {
			return "/board/boardView";
		} else {
			return "/board/myBoardView";
		}

	}

	@RequestMapping(value = "/fileDown")
	public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		
		try {
			Map<String, Object> resultMap = fileInfoService.selectOneFile(map);
			String storedFileName = (String) resultMap.get("F_STORED_FILE_NAME");
			String originalFileName = (String) resultMap.get("F_ORG_FILE_NAME");
			String filePath = request.getSession().getServletContext().getRealPath("/resources/static/file/");
			byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File(filePath + storedFileName));

			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition",
					"attachment; fileName=\"" + URLEncoder.encode(originalFileName, "UTF-8") + "\";");
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}catch(Exception e) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('해당 파일이 존재하지 않습니다.');history.back();</script>");
			out.flush();
		}
		
	}

	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String write(Locale locale, Model model) throws Exception {
		logger.info("BoardWrite");
		return "/board/boardWrite";
	}

	@RequestMapping(value = "/writeAction")
	public String writeAction(BoardVO vo, String grade, HttpServletRequest request,
			MultipartHttpServletRequest mpRequest) throws Exception {
		logger.info("BoardWriteAction");
		BoardVO bvo = vo;
		if (grade.equals("Z")) {
			bvo.setB_type("G");
			service.writeBoard(bvo, mpRequest);
			return "redirect:/board/list";
		} else if (grade.equals("A")) {
			bvo.setB_type("N");
			service.writeBoard(bvo, mpRequest);
			return "redirect:/board/list";
		}
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}

	@RequestMapping(value = "/modify")
	public String modify(int bidx, @ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception {
		logger.info("BoardModifyView");
		BoardVO vo = service.selectOneBoard(bidx);
		model.addAttribute("boardVO", vo);
		model.addAttribute("scri", scri);

		List<Map<String, Object>> fileList = fileInfoService.selectAllFile("bidx", bidx);
		model.addAttribute("file", fileList);

		return "/board/boardModify";
	}

	@RequestMapping(value = "/modifyAction")
	public String modifyAction(BoardVO vo, @ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr,
			@RequestParam(value = "fileNoDel[]") String[] files,
			@RequestParam(value = "fileNameDel[]") String[] fileNames, MultipartHttpServletRequest mpRequest)
			throws Exception {

		logger.info("BoardModifyAction");

		service.modifyBoard(vo, files, fileNames, mpRequest);

		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		return "redirect:/board/list";
	}

	@RequestMapping(value = "/delete")
	public String delete(int bidx, @ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr)
			throws Exception {
		logger.info("BoardDelete");
		service.deleteBoard(bidx);
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		return "redirect:/board/list";
	}

	@RequestMapping(value = "/writeReply")
	public String writeReply(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		logger.info("writeReply");

		replyService.addReply(vo);
		rttr.addAttribute("bidx", vo.getBidx());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());

		return "redirect:/board/list";
	}
}
