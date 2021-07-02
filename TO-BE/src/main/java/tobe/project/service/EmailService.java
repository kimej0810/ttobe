package tobe.project.service;

import java.util.List;

import tobe.project.domain.SearchCriteria;
import tobe.project.dto.EmailDTO;
import tobe.project.dto.EmailVO;

public interface EmailService {
	public void sendEmail(EmailDTO emailVO);
	public int writeEmail(EmailDTO emailVO) throws Exception;
	public int totalCountEmail(String keyword) throws Exception;
	List<EmailDTO> searchEmailList(SearchCriteria searchCriteria) throws Exception;
	//public List<EmailDTO> selectAllEmail(SearchCriteria searchCriteria) throws Exception;
	int totalCountsearchEmail(SearchCriteria searchCriteria) throws Exception;
	public EmailDTO selectOneEmail(EmailDTO dto) throws Exception;
	public int searchMember(EmailDTO dto)throws Exception;
	public int deleteEmail(int eidx)throws Exception;
}
