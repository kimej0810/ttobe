package tobe.project.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import tobe.project.dao.DataLibraryDAO;
import tobe.project.dto.DataLibraryVO;
import tobe.project.util.FileUtils;

@Service
public class DataLibraryServiceImpl implements DataLibraryService{
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Inject
    private DataLibraryDAO dao;
	
	@Override
	public List<DataLibraryVO> selectAllData() throws Exception {
		return dao.selectAllData();
	}
	
	@Override
	public void addData(DataLibraryVO vo, MultipartHttpServletRequest mpRequest) throws Exception {
		dao.addData(vo); //DataLibrary 추가
		
		List<Map<String, Object>> list = fileUtils.parseInsertFileInfoData(vo, mpRequest);
		int size = list.size();
		for(int i=0; i<size; i++) {
			dao.insertFile(list.get(i)); //FileInfo 추가
		}
	}
}
