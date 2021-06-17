package tobe.project.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import tobe.project.dto.DataLibraryVO;

public interface DataLibraryService {
	public List<DataLibraryVO> selectAllData() throws Exception;
	public void addData(DataLibraryVO vo, MultipartHttpServletRequest mpRequest) throws Exception;
}
