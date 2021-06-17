package tobe.project.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import tobe.project.dao.MemberFileDAO;
import tobe.project.dto.FileVO;

@Repository
public class MemberFileServiceImpl implements MemberFileService{
	
	@Inject
	private MemberFileDAO dao;
	@Override
	public List<FileVO> selectAllFile()throws Exception{
		return dao.selectAllFile();
	}
	@Override
	public void addFile(String fullName, Integer tidx) throws Exception {
		dao.addFile(fullName, tidx);
	}

	@Override
	public List<String> selectListFile(Integer tidx) throws Exception {
		return dao.selectListFile(tidx);
	}

	@Override
	public void modifyFile(String fullName, Integer tidx) throws Exception {
		dao.modifyFile(fullName, tidx);
	}

	@Override
	public void deleteFile(String fullName, Integer tidx) throws Exception {
		dao.deleteFile(fullName, tidx);
	}

}
