package tobe.project.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.http.MediaType;
import org.springframework.util.FileCopyUtils;

public class UploadFileUtils {
	//파일 업로드 처리
	public static String uploadFile(String uploadPath, String originalName, byte[] fileData)throws Exception{
		//중복방지 UUID 키값 생성
		UUID uuid = UUID.randomUUID();
		//실제 저장할 파일명
		String savedName = uuid.toString()+"_"+originalName;
		//날짜경로
		String savedPath = calcPath(uploadPath);
		//파일 객체 생성
		File target = new File(uploadPath + savedPath, savedName);
		//fileData를 파일객체에 복사
		FileCopyUtils.copy(fileData, target);
		//파일 확장자 추출
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
		//업로드 파일명 : 썸네일 이미지 파일명 or 일반 파일명
		String uploadFileName = null;
		//확장자에 따라 썸네일 이미지 생성 or 일반 파일 아이콘 생성
		if(MediaUtils.getMediaType(formatName)!=null) {
			//썸네일 이미지 생성, 썸네일 이미지 파일명
			uploadFileName = makeThumbnail(uploadPath, savedPath, savedName);
		}else {
			//파일 아이콘 생성
			uploadFileName = makeIcon(uploadPath, savedPath, savedName);
		}
		//업로드 파일명 반환
		return uploadFileName;
	}
	//날짜별 경로 추출
	public static String calcPath(String uploadPath) {
		Calendar calendar = Calendar.getInstance();
		//년
		String yearPath = File.separator + calendar.get(Calendar.YEAR);
		//년+월
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(calendar.get(Calendar.MONTH)+1);
		//년+월+일
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(calendar.get(Calendar.DATE));
		//파일저장 기본경로 + 날짜 경로 생성
		makeDir(uploadPath, yearPath, monthPath, datePath);
		//날짜경로반환
		return datePath;
	}
	//파일 저장 기본 경로 + 날짜 경로 생성
	private static void makeDir(String uploadPath, String...paths) {
		//기본경로+날짜 경로가 이미 존재 : 메서드 종료
		if(new File(uploadPath+paths[paths.length-1]).exists()) {
			return;
		}
		//날짜 경로가 존재 X : 경로 생성을 위한 반복문 실행
		for(String path : paths) {
			//기본경로+날짜경로에 해당하는 파일 객체 생성
			File dirPath = new File(uploadPath+path);
			//파일 객체에 해당하는 경로가 존재 X
			if(!dirPath.exists()) {
				//경로 생성
				dirPath.mkdir();
			}
		}
	}
	//썸네일 생성 : 이미지 파일의 경우
	private static String makeThumbnail(String uploadPath, String path, String fileName)throws Exception{
		//BufferedImage : 실제 이미지X 메모리상의 이미지를 의미하는 객체
		//원본 이미지파일을 메모리에 로딩
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath+path,fileName));
		//정해진 크기에 맞게 원본이미지를 축소
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC,Scalr.Mode.FIT_TO_HEIGHT, 100);
		//썸네일 이미지 파일명
		String thumbnailName = uploadPath+path+File.separator+"s_"+fileName;
		//썸네일 이미지 파일 객체 생성
		File newFile = new File(thumbnailName);
		//파일 확장자 추출
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		//써네일 파일 저장
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar,'/');
	}
	//아이콘 생성 : 이미지 파일이 아닐 경우
	private static String makeIcon(String uploadPath, String savedPath, String fileName)throws Exception{
		//파일 아이콘명 = 기본저장경로+날짜경로+구분자+파일명
		String iconName = uploadPath+savedPath+File.separator+fileName;
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	//파일 삭제처리 메서드
	public static void removeFile(String uploadPath, String fileName) {
		//파일 확장자 추출
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		//파일 확장자를 통해 이미지 파일인지 판별
		MediaType mediaType = MediaUtils.getMediaType(formatName);
		//이미지 파일인 경우 원본파일 삭제
		if(mediaType!=null) {
			//원본이미지의경로+파일명추출
			//날짜경로추출
			String front = fileName.substring(0,12);
			//UUID + 파일명 추출
			String end = fileName.substring(14);
			//원본 이미지 파일 삭제(구분자변환)
			new File(uploadPath+(front+end).replace('/',File.separatorChar)).delete();
		}
		//파일삭제(일반파일or썸네일이미지파일삭제)
		new File(uploadPath+fileName.replace('/', File.separatorChar)).delete();
	}
}
