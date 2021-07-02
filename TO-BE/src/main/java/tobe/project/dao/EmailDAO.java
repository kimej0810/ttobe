package tobe.project.dao;

import java.util.List;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.EmailDTO;
import tobe.project.dto.EmailVO;

public interface EmailDAO {
	public int writeEmail(EmailDTO emailVO)throws Exception;
	public int totalCountEmail(String keyword) throws Exception;
	List<EmailDTO> searchEmailList(SearchCriteria searchCriteria) throws Exception;
	int totalCountsearchEmail(SearchCriteria searchCriteria) throws Exception;
	public EmailDTO selectOneEmail(EmailDTO dto) throws Exception;
	public int searchMember(EmailDTO dto)throws Exception;
	public int deleteEmail(int eidx)throws Exception;
}


