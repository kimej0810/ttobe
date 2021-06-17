package tobe.project.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import tobe.project.dao.FileInfoDAO;

@Service
public class FileInfoServiceImpl implements FileInfoService {

	@Inject
	FileInfoDAO dao;
	
	@Override
	public List<Map<String, Object>> selectAllFile(String str, int idx) throws Exception{
		return dao.selectAllFile(str, idx);
	}

	@Override
	public Map<String, Object> selectOneFile(Map<String, Object> map) throws Exception {
		return dao.selectOneFile(map);
	}

}
