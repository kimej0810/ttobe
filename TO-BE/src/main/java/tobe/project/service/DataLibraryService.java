package tobe.project.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.DataLibraryVO;

public interface DataLibraryService {
	public List<DataLibraryVO> selectAllData(SearchCriteria scri) throws Exception;
	public int dataCount(SearchCriteria scri) throws Exception;
	public void addData(DataLibraryVO vo, MultipartHttpServletRequest mpRequest) throws Exception;
	public void hitData(int didx) throws Exception;
	public void deleteData(int didx) throws Exception;
}
