package tobe.project.service;

import java.util.List;

import tobe.project.dto.ReplyVO;

public interface ReplyService {
	public List<ReplyVO> listReply(int bidx) throws Exception;
	public void addReply(ReplyVO vo) throws Exception;
	public void modifyReply(ReplyVO vo) throws Exception;
	public void removeReply(int ridx) throws Exception;
}
