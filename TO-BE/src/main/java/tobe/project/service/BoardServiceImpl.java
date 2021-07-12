package tobe.project.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import tobe.project.dao.BoardDAO;
import tobe.project.dao.FileInfoDAO;
import tobe.project.domain.SearchCriteria;
import tobe.project.dto.BoardVO;
import tobe.project.util.FileUtils;
import tobe.project.util.RemoveHtml;

@Service
public class BoardServiceImpl implements BoardService{
	@Resource(name="removeHtml")
	private RemoveHtml removeHtml;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Inject
    private BoardDAO dao;
	
	@Inject
	private FileInfoDAO fdao;
	
	@Override
	public List<BoardVO> selectAllBoard(SearchCriteria scri) throws Exception {
		return dao.selectAllBoard(scri);
	}
	
	@Override
	public int totalCount(SearchCriteria scri) throws Exception {
		return dao.totalCount(scri);
	}

	@Override
	public void writeBoard(BoardVO vo, MultipartHttpServletRequest mpRequest) throws Exception {
		
		vo.setB_content(removeHtml.removeHtml(vo.getB_content()));
		dao.writeBoard(vo);
		
		System.out.println("----------------------------------");
		System.out.println("vo의 bidx->"+vo.getBidx());
		System.out.println("----------------------------------");
		
		List<Map<String, Object>> list = fileUtils.parseInsertFileInfoBoard(vo, mpRequest); 
		int size = list.size();
		for(int i=0; i<size; i++) {
			System.out.println("----------------------------------");
			System.out.println(list.get(i).get("ORG_FILE_NAME"));
			System.out.println("----------------------------------");
			dao.insertFile(list.get(i));
		}
	}

	@Override
	public BoardVO selectOneBoard(int bidx) throws Exception {
		dao.hitBoard(bidx);
		return dao.selectOneBoard(bidx);
	}

	@Override
	public void modifyBoard(BoardVO vo, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest) throws Exception {
		dao.modifyBoard(vo);
		
		List<Map<String, Object>> list = fileUtils.parseUpdateFileInfo(vo, files, fileNames, mpRequest);
		Map<String, Object> tempMap = null;
		int size = list.size();
		for(int i = 0; i<size; i++) {
			tempMap = list.get(i);
			if(tempMap.get("IS_NEW").equals("Y")) {
				dao.insertFile(tempMap);
			}else {
				dao.modifyFile(tempMap);
			}
		}
	}

	@Override
	public void deleteBoard(int bidx) throws Exception {
		dao.deleteBoard(bidx);
	}

	@Override
	public String buttonState(String searchType) throws Exception {

		return null;
	}

	@Override
	public List<BoardVO> selectNotice(Map<String, String> search) throws Exception {
		return dao.selectNotice(search);
	}
}
