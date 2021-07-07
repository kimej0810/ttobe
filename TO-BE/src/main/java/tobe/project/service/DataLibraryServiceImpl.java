package tobe.project.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import tobe.project.dao.DataLibraryDAO;
import tobe.project.domain.SearchCriteria;
import tobe.project.dto.DataLibraryVO;
import tobe.project.util.FileUtils;

@Service
public class DataLibraryServiceImpl implements DataLibraryService{
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Inject
    private DataLibraryDAO dao;
	
	@Override
	public List<DataLibraryVO> selectAllData(SearchCriteria scri) throws Exception {
		return dao.selectAllData(scri);
	}
	
	@Override
	public int dataCount(SearchCriteria scri) throws Exception {
		// TODO Auto-generated method stub
		return dao.dataCount(scri);
	}
	
	@Override
	public void addData(DataLibraryVO vo, MultipartHttpServletRequest mpRequest) throws Exception {
		dao.addData(vo); //DataLibrary 異�媛�
		
		List<Map<String, Object>> list = fileUtils.parseInsertFileInfoData(vo, mpRequest);
		int size = list.size();
		for(int i=0; i<size; i++) {
			dao.insertFile(list.get(i)); //FileInfo 異�媛�
		}
	}

	@Override
	public void hitData(int didx) throws Exception {
		dao.hitData(didx);
	}

	@Override
	public void deleteData(int didx) throws Exception {
		dao.deleteData(didx);
		
	}

	
}
