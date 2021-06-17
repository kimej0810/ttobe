package tobe.project.service;

import java.util.List;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.EmailVO;

public interface EmailService {
	public void sendEmail(EmailVO emailVO);
	public int writeEmail(EmailVO emailVO) throws Exception;
	public int totalCountEmail(String keyword) throws Exception;
	List<EmailVO> searchEmailList(SearchCriteria searchCriteria) throws Exception;
	int totalCountsearchEmail(SearchCriteria searchCriteria) throws Exception;
	public EmailVO selectOneEmail(int midx) throws Exception;
	
}
