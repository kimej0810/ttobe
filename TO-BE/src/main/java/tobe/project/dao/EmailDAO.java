package tobe.project.dao;

import java.util.List;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.EmailVO;

public interface EmailDAO {
	public int writeEmail(EmailVO emailVO)throws Exception;
	public int totalCountEmail(String keyword) throws Exception;
	List<EmailVO> searchEmailList(SearchCriteria searchCriteria) throws Exception;
	int totalCountsearchEmail(SearchCriteria searchCriteria) throws Exception;
	public EmailVO selectOneEmail(int midx) throws Exception;
}


