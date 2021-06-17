package tobe.project.dao;

import java.util.List;

import tobe.project.dto.FileVO;

public interface MemberFileDAO {
	//파일리스트
	public List<FileVO> selectAllFile()throws Exception;
	//첨부파일 추가
	public void addFile(String fullName, Integer tidx)throws Exception;
	//첨부파일 조회
	public List<String> selectListFile(Integer tidx)throws Exception;
	//첨부파일 수정
	public void modifyFile(String fullName, Integer tidx)throws Exception;
	//첨부파일 삭제
	public void deleteFile(String fullName, Integer tidx)throws Exception;
}
