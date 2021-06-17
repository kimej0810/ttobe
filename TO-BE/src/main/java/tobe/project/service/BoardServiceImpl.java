package tobe.project.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import tobe.project.dao.BoardDAO;
import tobe.project.domain.SearchCriteria;
import tobe.project.dto.BoardVO;
import tobe.project.util.FileUtils;

@Service
public class BoardServiceImpl implements BoardService{
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Inject
    private BoardDAO dao;
	
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
		dao.writeBoard(vo);
		
		System.out.println("----------------------------------");
		System.out.println("vo의 bidx->"+vo.getBidx());
		System.out.println("----------------------------------");
		
		List<Map<String, Object>> list = fileUtils.parseInsertFileInfoBoard(vo, mpRequest);
		int size = list.size();
		for(int i=0; i<size; i++) {
			System.out.println("----------------------------------");
			System.out.println("list의 bidx->"+list.get(i).get("bidx"));
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
	public void modifyBoard(BoardVO vo) throws Exception {
		dao.modifyBoard(vo);
	}

	@Override
	public void deleteBoard(int bidx) throws Exception {
		dao.deleteBoard(bidx);
	}

	@Override
	public String buttonState(String searchType) throws Exception {

		return null;
	}
}
