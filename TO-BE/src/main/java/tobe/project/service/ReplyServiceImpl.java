package tobe.project.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import tobe.project.dao.ReplyDAO;
import tobe.project.dto.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	private ReplyDAO dao;
	
	@Override
	public List<ReplyVO> listReply(int bidx) throws Exception {
		
		List<ReplyVO> listReply = dao.list(bidx);
		
		for(int i=0; i<listReply.size(); i++) {;
			listReply.get(i).setR_content(listReply.get(i).getR_content().replace("\n", "<br>"));
			//엔터 먹이는중
		}
		
		return listReply;
	}

	@Override
	public void addReply(ReplyVO vo) throws Exception {
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
