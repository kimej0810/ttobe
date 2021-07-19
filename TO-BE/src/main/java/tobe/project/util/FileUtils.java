package tobe.project.util;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import tobe.project.dto.BoardVO;
import tobe.project.dto.DataLibraryVO;
import tobe.project.dto.MemberVO;

@Component("fileUtils")
public class FileUtils {
	
	public List<Map<String, Object>> parseInsertFileInfoProfile(MemberVO memberVO, MultipartHttpServletRequest mpRequest) throws IllegalStateException, IOException{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder
			      .getRequestAttributes()).getRequest();
		String profilePath = request.getSession().getServletContext().getRealPath("/resources/static/profile/");
		Iterator<String> iterator = mpRequest.getFileNames();
		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;
		int tidx = memberVO.getTidx();
		System.out.println("파일유틸에서"+tidx);
		String type = "profile";
		File file = new File(profilePath);
		System.out.println("FileUtils  file>>>>>>>>>>>>>>"+file);
		if(file.exists()==false) {
			file.mkdirs();
		}
		while(iterator.hasNext()) {
			multipartFile = mpRequest.getFile(iterator.next());
			if(multipartFile.isEmpty() == false) {
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = getRandomString() + originalFileExtension;
				file = new File(profilePath+storedFileName);
				multipartFile.transferTo(file);
				listMap = new HashMap<String, Object>();
				listMap.put("tidx", tidx);
				System.out.println("tidx>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+tidx);
				listMap.put("F_TYPE", type);
				listMap.put("F_ORG_FILE_NAME", originalFileName);
				listMap.put("F_STORED_FILE_NAME",storedFileName);
				listMap.put("F_FILE_SIZE", multipartFile.getSize());
				list.add(listMap);
			}
		}
		return list;
	}
	public List<Map<String, Object>> parseInsertFileInfoBoard(BoardVO boardVO, 
			MultipartHttpServletRequest mpRequest) throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder
			      .getRequestAttributes()).getRequest();
		String filePath = request.getSession().getServletContext().getRealPath("/resources/static/file/");
		Iterator<String> iterator = mpRequest.getFileNames();
		
		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> listMap = null;
		
		int bidx = boardVO.getBidx();
		
		File file = new File(filePath);
		if(file.exists() == false) {
			file.mkdirs();
		}
		
		while(iterator.hasNext()) {
			multipartFile = mpRequest.getFile(iterator.next());
			if(multipartFile.isEmpty() == false) {
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = getRandomString() + originalFileExtension;
				
				file = new File(filePath + storedFileName);
				multipartFile.transferTo(file);
				
				System.out.println("bidx->"+bidx);
				System.out.println("ORG_FILE_NAME->"+originalFileName);
				System.out.println("STORED_FILE_NAME->"+storedFileName);
				System.out.println("FILE_SIZE->"+multipartFile.getSize());
				
				String extension = StringUtils.getFilenameExtension(originalFileName);
				listMap = new HashMap<String, Object>();
				listMap.put("bidx", bidx);
				listMap.put("F_TYPE", extension);
				listMap.put("ORG_FILE_NAME", originalFileName);
				listMap.put("STORED_FILE_NAME", storedFileName);
				listMap.put("FILE_SIZE", multipartFile.getSize());
				list.add(listMap);
			}
		}
		return list;
	}
	
	public List<Map<String, Object>> parseInsertFileInfoData(DataLibraryVO dataVO, 
			MultipartHttpServletRequest mpRequest) throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder
			      .getRequestAttributes()).getRequest();
		String filePath = request.getSession().getServletContext().getRealPath("/resources/static/file/");
		Iterator<String> iterator = mpRequest.getFileNames();
		
		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> listMap = null;
		
		int didx = dataVO.getDidx();
		
		File file = new File(filePath);
		if(file.exists() == false) {
			file.mkdirs();
		}
		
		while(iterator.hasNext()) {
			multipartFile = mpRequest.getFile(iterator.next());
			if(multipartFile.isEmpty() == false) {
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = getRandomString() + originalFileExtension;
				
				file = new File(filePath + storedFileName);
				multipartFile.transferTo(file);
				
				System.out.println("didx->"+didx);
				System.out.println("ORG_FILE_NAME->"+originalFileName);
				System.out.println("STORED_FILE_NAME->"+storedFileName);
				System.out.println("FILE_SIZE->"+multipartFile.getSize());
				
				String extension = StringUtils.getFilenameExtension(originalFileName);
				listMap = new HashMap<String, Object>();
				listMap.put("didx", didx);
				listMap.put("F_TYPE", extension);
				listMap.put("ORG_FILE_NAME", originalFileName);
				listMap.put("STORED_FILE_NAME", storedFileName);
				listMap.put("FILE_SIZE", multipartFile.getSize());
				list.add(listMap);
			}
		}
		return list;
	}
	
	public List<Map<String, Object>> parseInsertFileInfo(MemberVO vo, MultipartHttpServletRequest mpRequest) throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder
			      .getRequestAttributes()).getRequest();
		String filePath = request.getSession().getServletContext().getRealPath("/resources/static/file/");
		Iterator<String> iterator = mpRequest.getFileNames();
		
		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> listMap = null;
		
		int tidx = vo.getTidx();
		
		File file = new File(filePath);
		if(file.exists() == false) {
			file.mkdir();
		}
		
		while(iterator.hasNext()) {
			multipartFile = mpRequest.getFile(iterator.next());
			if(multipartFile.isEmpty() == false) {
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = getRandomString() + originalFileExtension;
				
				file = new File(filePath + storedFileName);
				multipartFile.transferTo(file);
				
				String extension = StringUtils.getFilenameExtension(originalFileName);
				listMap = new HashMap<String, Object>();
				listMap.put("tidx", tidx);
				listMap.put("F_TYPE", extension);
				listMap.put("ORG_FILE_NAME", originalFileName);
				listMap.put("STORED_FILE_NAME", storedFileName);
				listMap.put("FILE_SIZE", multipartFile.getSize());
				list.add(listMap);
			}
		}
		return list;
	}
	
	public List<Map<String, Object>> parseUpdateFileInfo(BoardVO boardVO, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest) throws Exception{ 
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder
			      .getRequestAttributes()).getRequest();
		String filePath = request.getSession().getServletContext().getRealPath("/resources/static/file/");
		Iterator<String> iterator = mpRequest.getFileNames();
		MultipartFile multipartFile = null; 
		String originalFileName = null; 
		String originalFileExtension = null; 
		String storedFileName = null; 
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> listMap = null; 
		int bidx = boardVO.getBidx();
		while(iterator.hasNext()){ 
			multipartFile = mpRequest.getFile(iterator.next()); 
			if(multipartFile.isEmpty() == false){
				originalFileName = multipartFile.getOriginalFilename(); 
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf(".")); 
				storedFileName = getRandomString() + originalFileExtension; 
				multipartFile.transferTo(new File(filePath + storedFileName)); 
				
				String extension = StringUtils.getFilenameExtension(originalFileName);
				listMap = new HashMap<String,Object>();
				listMap.put("IS_NEW", "Y");
				listMap.put("F_TYPE", extension);
				listMap.put("BIDX", bidx); 
				listMap.put("ORG_FILE_NAME", originalFileName);
				listMap.put("STORED_FILE_NAME", storedFileName); 
				listMap.put("FILE_SIZE", multipartFile.getSize()); 
				list.add(listMap); 
			} 
		}
		if(files != null && fileNames != null){ 
			for(int i = 0; i<fileNames.length; i++) {
					listMap = new HashMap<String,Object>();
                    listMap.put("IS_NEW", "N");
					listMap.put("FIDX", files[i]); 
					list.add(listMap); 
			}
		}
		return list; 
	}
	public static String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-","");
	}
}
