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
		return dao.list(bidx);
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
