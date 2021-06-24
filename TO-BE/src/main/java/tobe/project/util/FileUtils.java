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
	//�뙆�씪 ���옣�맆 寃쎈줈
	//private static final String filePath = "D:\\kio\\tobe\\TO-BE\\src\\main\\webapp\\resources\\static\\profile\\";
	private static final String filePath = "C:\\Users\\bakug\\ttobe\\TO-BE\\src\\main\\webapp\\resources\\static\\file\\"; // �뙆�씪�씠 ���옣�맆 �쐞移� �닔吏�
	//private static final String filePath = "D:\\kio\\tobe\\TO-BE\\src\\main\\webapp\\resources\\static\\profile\\";
	//private static final String filePath = "C:\\api_dev\\to-be3\\TO-BE\\src\\main\\webapp\\resources\\static\\file\\"; // �뙆�씪�씠 ���옣�맆 �쐞移� �닔吏�
	//private static final String filePath = "C:\\Users\\750\\git\\ttobe\\TO-BE\\src\\main\\webapp\\resources\\static\\profile\\";
	
	
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
			Iterator�� �뜲�씠�꽣�뱾�쓽 吏묓빀泥�? �뿉�꽌 而щ젆�뀡�쑝濡쒕��꽣 �젙蹂대�� �뼸�뼱�삱 �닔 �엳�뒗 �씤�꽣�럹�씠�뒪�엯�땲�떎.
			List�굹 諛곗뿴�� �닚李⑥쟻�쑝濡� �뜲�씠�꽣�쓽 �젒洹쇱씠 媛��뒫�븯吏�留�, Map�벑�쓽 �겢�옒�뒪�뱾�� �닚李⑥쟻�쑝濡� �젒洹쇳븷 �닔媛� �뾾�뒿�땲�떎.
			Iterator�쓣 �씠�슜�븯�뿬 Map�뿉 �엳�뒗 �뜲�씠�꽣�뱾�쓣 while臾몄쓣 �씠�슜�븯�뿬 �닚李⑥쟻�쑝濡� �젒洹쇳빀�땲�떎.
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
			Iterator�� �뜲�씠�꽣�뱾�쓽 吏묓빀泥�? �뿉�꽌 而щ젆�뀡�쑝濡쒕��꽣 �젙蹂대�� �뼸�뼱�삱 �닔 �엳�뒗 �씤�꽣�럹�씠�뒪�엯�땲�떎.
			List�굹 諛곗뿴�� �닚李⑥쟻�쑝濡� �뜲�씠�꽣�쓽 �젒洹쇱씠 媛��뒫�븯吏�留�, Map�벑�쓽 �겢�옒�뒪�뱾�� �닚李⑥쟻�쑝濡� �젒洹쇳븷 �닔媛� �뾾�뒿�땲�떎.
			Iterator�쓣 �씠�슜�븯�뿬 Map�뿉 �엳�뒗 �뜲�씠�꽣�뱾�쓣 while臾몄쓣 �씠�슜�븯�뿬 �닚李⑥쟻�쑝濡� �젒洹쇳빀�땲�떎.
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
	
	//寃뚯떆�뙋 泥⑤��뙆�씪 �닔�젙
	public List<Map<String, Object>> parseUpdateFileInfo(BoardVO boardVO, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest) throws Exception{ 
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
			//�깉濡쒖슫 泥⑤��뙆�씪�씠 �벑濡앸릺�뿀�쓣 �븣
			if(multipartFile.isEmpty() == false){
				originalFileName = multipartFile.getOriginalFilename(); 
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf(".")); 
				storedFileName = getRandomString() + originalFileExtension; 
				multipartFile.transferTo(new File(filePath + storedFileName)); 
				listMap = new HashMap<String,Object>();
				listMap.put("IS_NEW", "Y");
				listMap.put("BIDX", bidx); 
				listMap.put("ORG_FILE_NAME", originalFileName);
				listMap.put("STORED_FILE_NAME", storedFileName); 
				listMap.put("FILE_SIZE", multipartFile.getSize()); 
				list.add(listMap); 
			} 
		}
		//�궘�젣�븷 �뙆�씪�쓽 �뙆�씪踰덊샇�� �씠由꾩쓣 諛쏆쓬
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
