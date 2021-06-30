package tobe.project.dao;

import java.util.List;
import java.util.Map;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.BoardVO;

public interface BoardDAO {
	//게시글 목록 조회
	public List<BoardVO> selectAllBoard(SearchCriteria scri) throws Exception;
	//게시글 총 갯수
	public int totalCount(SearchCriteria scri) throws Exception;
	//메인페이지 공지사항 조회
	public List<BoardVO> selectNotice() throws Exception;
	//조회수
	public void hitBoard(int bidx) throws Exception;
	//게시글 작성
	public void writeBoard(BoardVO vo) throws Exception; 
	//게시글 상세보기
	public BoardVO selectOneBoard(int bidx) throws Exception; 
	//게시글 수정
	public void modifyBoard(BoardVO vo) throws Exception;
	//게시글 삭제
	public void deleteBoard(int bidx) throws Exception;
	//첨부파일
	public void insertFile(Map<String, Object> map) throws Exception;
	//첨부파일 수정
	public void modifyFile(Map<String, Object> map) throws Exception;
}
