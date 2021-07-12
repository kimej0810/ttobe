package tobe.project.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;

import tobe.project.dao.FileInfoDAO;
import tobe.project.dao.ReplyDAO;
import tobe.project.dto.ReplyVO;
import tobe.project.util.RemoveHtml;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Resource(name="removeHtml")
	private RemoveHtml removeHtml;
	
	@Inject
	private ReplyDAO dao;
	
	@Inject
	private FileInfoDAO fdao;
	
	@Override
	public List<ReplyVO> listReply(int bidx) throws Exception {
		
		List<ReplyVO> listReply = dao.list(bidx);
		
		for(int i=0; i<listReply.size(); i++) {;
			listReply.get(i).setR_content(listReply.get(i).getR_content().replace("\n", "<br>"));
			listReply.get(i).setR_content(removeHtml.removeHtml(listReply.get(i).getR_content()));
		}
		
		for(int i=0; i<listReply.size(); i++) {
			Map<String, String> filePath = fdao.selectFileTidx(listReply.get(i).getTidx());
			
			System.out.println("프로필사진경로임~~~~~~~~~``"+filePath.get("F_STORED_FILE_NAME"));
			
			listReply.get(i).getMemberDTO().setF_stored_file_name(filePath.get("F_STORED_FILE_NAME"));
		}
		
		return listReply;
	}

	@Override
	public void addReply(ReplyVO vo) throws Exception {
		vo.setR_content(removeHtml.removeHtml(vo.getR_content()));
		dao.create(vo);
	}

	@Override
	public void modifyReply(ReplyVO vo) throws Exception {
		dao.update(vo);	
	}

	@Override
	public void removeReply(int ridx) throws Exception {
		dao.delete(ridx);	
	}
}
