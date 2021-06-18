package tobe.project.util;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import tobe.project.dto.BoardVO;
import tobe.project.dto.DataLibraryVO;
import tobe.project.dto.MemberVO;

@Component("fileUtils")
public class FileUtils {
	//파일 저장될 경로
	//private static final String filePath = "D:\\kio\\tobe\\TO-BE\\src\\main\\webapp\\resources\\static\\profile\\";
	//private static final String filePath = "C:\\api_dev\\to-be3\\TO-BE\\src\\main\\webapp\\resources\\static\\file\\"; // 파일이 저장될 위치 수진
	private static final String filePath = "C:\\Users\\750\\git\\ttobe\\TO-BE\\src\\main\\webapp\\resources\\static\\profile\\";
	
	
	public List<Map<String, Object>> parseInsertFileInfoProfile(MemberVO memberVO, MultipartHttpServletRequest mpRequest) throws IllegalStateException, IOException{
		Iterator<String> iterator = mpRequest.getFileNames();
		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;
		int tidx = memberVO.getTidx();
		String type = "";
		File file = new File(filePath);
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
				file = new File(filePath+storedFileName);
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
		
		/*
			Iterator은 데이터들의 집합체? 에서 컬렉션으로부터 정보를 얻어올 수 있는 인터페이스입니다.
			List나 배열은 순차적으로 데이터의 접근이 가능하지만, Map등의 클래스들은 순차적으로 접근할 수가 없습니다.
			Iterator을 이용하여 Map에 있는 데이터들을 while문을 이용하여 순차적으로 접근합니다.
		*/
		
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
		
		/*
			Iterator은 데이터들의 집합체? 에서 컬렉션으로부터 정보를 얻어올 수 있는 인터페이스입니다.
			List나 배열은 순차적으로 데이터의 접근이 가능하지만, Map등의 클래스들은 순차적으로 접근할 수가 없습니다.
			Iterator을 이용하여 Map에 있는 데이터들을 while문을 이용하여 순차적으로 접근합니다.
		*/
		
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
	
	public static String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-","");
	}
}
