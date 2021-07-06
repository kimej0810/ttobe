package tobe.project.dao;

import java.util.List;
import java.util.Map;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.BoardVO;

public interface BoardDAO {
	//寃���湲� 紐⑸� 議고��
	public List<BoardVO> selectAllBoard(SearchCriteria scri) throws Exception;
	//寃���湲� 珥� 媛���
	public int totalCount(SearchCriteria scri) throws Exception;
	//硫��명���댁� 怨듭��ы�� 議고��
	public List<BoardVO> selectNotice(Map<String, String> search) throws Exception;
	//議고����
	public void hitBoard(int bidx) throws Exception;
	//寃���湲� ����
	public void writeBoard(BoardVO vo) throws Exception; 
	//寃���湲� ���몃낫湲�
	public BoardVO selectOneBoard(int bidx) throws Exception; 
	//寃���湲� ����
	public void modifyBoard(BoardVO vo) throws Exception;
	//寃���湲� ����
	public void deleteBoard(int bidx) throws Exception;
	//泥⑤�����
	public void insertFile(Map<String, Object> map) throws Exception;
	//泥⑤����� ����
	public void modifyFile(Map<String, Object> map) throws Exception;
}
