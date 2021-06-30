package tobe.project.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.BoardVO;

public interface BoardService {
	public List<BoardVO> selectAllBoard(SearchCriteria scri) throws Exception; 
	public int totalCount(SearchCriteria scri) throws Exception;
	public void writeBoard(BoardVO vo, MultipartHttpServletRequest mpRequest) throws Exception; 
	public BoardVO selectOneBoard(int bidx)throws Exception; 
	public void modifyBoard(BoardVO vo, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest) throws Exception;
	public String buttonState(String searchType) throws Exception;
	public void deleteBoard(int bidx) throws Exception;
	public List<BoardVO> selectNotice() throws Exception; 
}
